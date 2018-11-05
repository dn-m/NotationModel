//
//  Wetherfield.swift
//  PitchSpeller
//
//  Created by James Bean on 5/23/18.
//

import DataStructures
import Pitch

enum FlowNode<Index>: Hashable where Index: Hashable {
    case `internal`(Index)
    case source
    case sink
}

protocol PitchSpellingNode: Hashable {
    typealias Index = FlowNode<Cross<Int,Tendency>>
    var index: Index { get }
}

extension FlowNode where Index == Cross<Int,Tendency> {
    var tendency: Tendency {
        switch self {
        case .source: return .down
        case.sink: return .up
        case.internal(let index): return index.b
        }
    }
}

struct PitchSpeller {

    struct UnassignedNode: PitchSpellingNode {
        let index: Index
    }

    struct AssignedNode: PitchSpellingNode {
        let index: Index
        let assignment: Tendency
        init(_ index: Index, _ assignment: Tendency) {
            self.index = index
            self.assignment = assignment
        }
    }
    
    struct InternalAssignedNode {
        let index: Cross<Int, Tendency>
        let assignment: Tendency
        init(_ index: Cross<Int, Tendency>, _ assignment: Tendency) {
            self.index = index
            self.assignment = assignment
        }
    }
    
    // For each `Pitch.Class` `n`, denotes which of `(n, .up)` and `(n, .down)` should
    // be connected to `(8, .up)` in the spelling dependency model.
    static let eightTendencyLink: [(Pitch.Class, Tendency)] = [
        (00, .down),
        (01, .up),
        (03, .down),
        (04, .up),
        (05, .down),
        (06, .up),
        (07, .down),
        (08, .up),
        (09, .up),
        (10, .down),
        (11, .up)
    ]
    
    // Maps `eightTendencyLink` to a `Set` of `Edge` values (to check for membership)
    static let eightLookup = Set<UnorderedPair<Cross<Pitch.Class, Tendency>>> (
        PitchSpeller.eightTendencyLink.lazy
            .map { pitchClass, tendency in
                .init(pitchClass, tendency)
            }.map { cross in
                .init(cross, .init(8, .up))
        }
    )
    
    static let connectSameTendencies: GraphScheme<PitchSpellingNode.Index>
        = GraphScheme<Tendency> { edge in edge.a == edge.b }
            .pullback { node in
                switch node {
                case .source: return .down
                case .sink: return .up
                case .internal(let index): return index.b
                }
            }
    
    static func adjacencyScheme (contains: Bool) -> (Pitch.Class) -> GraphScheme<Pitch.Class> {
        func pitchClassAdjacencyScheme (pitchClass: Pitch.Class) -> GraphScheme<Pitch.Class> {
            return GraphScheme<Pitch.Class> { edge in
                edge.contains(pitchClass)
            }
        }
        func pitchClassNonAdjacencyScheme (pitchClass: Pitch.Class) -> GraphScheme<Pitch.Class> {
            return GraphScheme<Pitch.Class> { edge in
                !edge.contains(pitchClass)
            }
        }
        return contains ? pitchClassAdjacencyScheme : pitchClassNonAdjacencyScheme
    }

    /// - Returns: The value of a node at the given offset (index of a `Pitch` within `pitches`),
    /// and an index (either `0` or `1`, which of the two nodes in the `FlowNetwork` that represent
    /// the given `Pitch`.)
    private static func node(_ offset: Int, _ index: Tendency) -> PitchSpellingNode.Index {
        return .internal(.init(offset, index))
    }

    /// - Returns: An array of nodes, each representing the index of the unassigned node in
    /// `pitchNodes`.
    private static func internalNodes(pitches: [Int: Pitch]) -> [PitchSpellingNode.Index] {
        return pitches.keys.flatMap { offset in [.down,.up].map { index in node(offset, index) } }
    }

    // MARK: - Instance Properties

    /// The unspelled `Pitch` values to be spelled.
    let pitch: (PitchSpellingNode.Index) -> Pitch?

    /// The nodes within the `FlowNetwork`. The values are the encodings of the indices of `Pitch`
    /// values in `pitches.
    let pitchNodes: [PitchSpellingNode.Index]

    /// The `FlowNetwork` which will be manipulated in order to spell the unspelled `pitches`.
    var flowNetwork: FlowNetwork<PitchSpellingNode.Index,Double>
    
    /// Getter for pitch class (from Index)
    let getPitchClass: (PitchSpellingNode.Index) -> Pitch.Class

    // MARK: - Initializers

    /// Create a `PitchSpeller` to spell the given `pitches`, with the given `parsimonyPivot`.
    init(pitches: [Int: Pitch], parsimonyPivot: Pitch.Spelling = .init(.d)) {
        self.pitch = { index in
            switch index {
            case .source, .sink:
                return Pitch(value: parsimonyPivot.pitchClass.value)
            case .internal(let cross):
                return pitches[cross.a]
            }
        }
        let getPitchClass: (FlowNode<Cross<Int,Tendency>>) -> Pitch.Class = { flowNode in
            switch flowNode {
            case .source, .sink:
                return parsimonyPivot.pitchClass
            case .internal(let cross):
                return pitches[cross.a]!.class
            }
        }
        self.getPitchClass = getPitchClass
        self.pitchNodes = PitchSpeller.internalNodes(pitches: pitches)
        self.flowNetwork = FlowNetwork(
            source: .source,
            sink: .sink,
            internalNodes: pitchNodes
        )
        let specificToEight = GraphScheme<Cross<Pitch.Class, Tendency>>(PitchSpeller.eightLookup.contains)
        let connectToEight: GraphScheme<PitchSpellingNode.Index> = specificToEight.pullback { flowNode in
            .init(getPitchClass(flowNode), flowNode.tendency)
        }
        flowNetwork.mask((PitchSpeller.connectSameTendencies * whereEdge(contains: false)(8)) +
            (connectToEight * whereEdge(contains: true)(8)) )
    }

    /// - Returns: An array of `SpelledPitch` values with the same indices as the original
    /// unspelled `Pitch` values.
    func spell() -> [Int: SpelledPitch] {

        var assignedNodes: [AssignedNode] {
            var (sourceSide, sinkSide) = flowNetwork.minimumCut
            sourceSide.remove(flowNetwork.source)
            sinkSide.remove(flowNetwork.sink)
            let downNodes = sourceSide.map { index in AssignedNode(index, .down) }
            let upNodes = sinkSide.map { index in AssignedNode(index, .up) }
            return downNodes + upNodes
        }
        return assignedNodes
            .compactMap { (assignedNode) -> InternalAssignedNode? in
                switch assignedNode.index {
                case .source, .sink: return nil
                case .internal(let index): return InternalAssignedNode(index, assignedNode.assignment)
                }
            }
            .reduce(into: [Int: (InternalAssignedNode, InternalAssignedNode)]()) { pairs, node in
                if !pairs.keys.contains(node.index.a) {
                    pairs[node.index.a] = (node, node)
                }
                switch node.index.b {
                case .up: pairs[node.index.a]!.0 = node
                case .down: pairs[node.index.a]!.1 = node
                }
            }.mapValues(spellPitch)
    }

    private func spellPitch(_ up: InternalAssignedNode, _ down: InternalAssignedNode) -> SpelledPitch {
        let pitch = self.pitch(.internal(up.index))!
        let tendencies = TendencyPair(up.assignment, down.assignment)
        let spelling = Pitch.Spelling(pitchClass: pitch.class, tendencies: tendencies)!
        return try! pitch.spelled(with: spelling)
    }
    
    func whereEdge (contains: Bool) -> (Pitch.Class) -> GraphScheme<PitchSpellingNode.Index> {
        func doesContain (pitchClass: Pitch.Class) -> GraphScheme<PitchSpellingNode.Index> {
            return PitchSpeller.adjacencyScheme(contains: true)(8).pullback(getPitchClass)
        }
        func doesNotContain (pitchClass: Pitch.Class) -> GraphScheme<PitchSpellingNode.Index> {
            return PitchSpeller.adjacencyScheme(contains: false)(8).pullback(getPitchClass)
        }
        return contains ? doesContain : doesNotContain
    }
}

extension FlowNetwork where Node == PitchSpellingNode.Index, Weight == Double {
    /// Create a `FlowNetwork` which is hooked up as neccesary for the Wetherfield pitch-spelling
    /// process.
    init(source: PitchSpellingNode.Index, sink: PitchSpellingNode.Index, internalNodes: [PitchSpellingNode.Index]) {
        let graph = WeightedDirectedGraph<PitchSpellingNode.Index,Double>(
            source: source,
            sink: sink,
            internalNodes: internalNodes
        )
        self.init(graph, source: source, sink: sink)
    }
}

extension WeightedDirectedGraph {
    /// Create a `DirectedGraph` which is hooked up as necessary for the Wetherfield pitch-spelling process.
    init(source: Node, sink: Node, internalNodes: [Node]) {
        self.init(Set([source,sink] + internalNodes))
        for node in internalNodes {
            insertEdge(from: source, to: node, weight: 1)
            insertEdge(from: node, to: sink, weight: 1)
            for other in internalNodes.lazy.filter({ $0 != node }) {
                insertEdge(from: node, to: other, weight: 1)
            }
        }
    }
}
