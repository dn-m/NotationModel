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

extension FlowNode where Index == Cross<Int,Tendency> {
    var tendency: Tendency {
        switch self {
        case .source: return .down
        case .sink: return .up
        case .internal(let index): return index.b
        }
    }
    var int: Int? {
        switch self {
        case .internal(let index): return index.a
        case .source, .sink: return nil
        }
    }
}

protocol PitchSpellingNode: Hashable {
    typealias Index = FlowNode<Cross<Int,Tendency>>
    var index: Index { get }
}

struct PitchSpeller {

    // MARK: - Instance Properties

    /// The `FlowNetwork` which will be manipulated in order to spell the unspelled `pitches`.
    var flowNetwork: FlowNetwork<PitchSpellingNode.Index,Double>

    /// The unspelled `Pitch` values to be spelled.
    let pitch: (PitchSpellingNode.Index) -> Pitch?

    /// Getter for pitch class (from Index)
    let getPitchClass: (PitchSpellingNode.Index) -> Pitch.Class
}

extension PitchSpeller {

    // MARK: - Nested Types

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
}

extension PitchSpeller {

    // MARK: - Initializers

    /// Create a `PitchSpeller` to spell the given `pitches`, with the given `parsimonyPivot`.
    init(pitches: [Int: Pitch], parsimonyPivot: Pitch.Spelling = .init(.d)) {
        self.flowNetwork = FlowNetwork(
            source: .source,
            sink: .sink,
            internalNodes: internalNodes(pitches: pitches)
        )
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

        let specificToEight = GraphScheme<Cross<Pitch.Class, Tendency>> (eightLookup.contains)
        let connectToEight: GraphScheme<PitchSpellingNode.Index> = specificToEight.pullback { flowNode in
            .init(getPitchClass(flowNode), flowNode.tendency)
        }
        let connectedToTwoNotEight = connectSameTendencies * whereEdge(contains: false)(8) * whereEdge(contains: true)(2)
        let sameClass = connectSameTendencies * GraphScheme<Pitch.Class> { edge in
            edge.a == edge.b }
            .pullback(getPitchClass)
        let connectedToEight = connectToEight * whereEdge(contains: true)(8)
        let generalConnections: DirectedGraphScheme<PitchSpellingNode.Index> =
            (connectDifferentInts * (connectedToTwoNotEight + sameClass + connectedToEight)).directed
        
        let maskArgument: WeightedDirectedGraphScheme<PitchSpellingNode.Index, Double> =
            1.0 * generalConnections * connectDifferentInts + bigMAssignment * connectSameInts
        flowNetwork.mask(maskArgument)
    }
}

extension PitchSpeller {

    // MARK: - Instance Methods

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
                case .source, .sink:
                    return nil
                case .internal(let index):
                    return InternalAssignedNode(index, assignedNode.assignment)
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

    private func spellPitch(
        _ up: InternalAssignedNode,
        _ down: InternalAssignedNode
    ) -> SpelledPitch
    {
        let pitch = self.pitch(.internal(up.index))!
        let tendencies = TendencyPair(up.assignment, down.assignment)
        let spelling = Pitch.Spelling(pitchClass: pitch.class, tendencies: tendencies)!
        return try! pitch.spelled(with: spelling)
    }

    /// FIXME: Consider implementing as:
    /// `let whereEdge: (Bool) -> (Pitch.Class) -> GraphScheme<PitchSpellingNode.Index>`
    func whereEdge (contains: Bool) -> (Pitch.Class) -> GraphScheme<PitchSpellingNode.Index> {
        return { pitchClass in
            adjacencyScheme(contains: contains)(pitchClass).pullback(self.getPitchClass)
        }
    }
}

/// - Returns: An array of nodes, each representing the index of the unassigned node in
/// `pitchNodes`.
private func internalNodes(pitches: [Int: Pitch]) -> [PitchSpellingNode.Index] {
    return pitches.keys.flatMap { offset in [.down,.up].map { index in node(offset, index) } }
}

/// - Returns: The value of a node at the given offset (index of a `Pitch` within `pitches`),
/// and an index (either `0` or `1`, which of the two nodes in the `FlowNetwork` that represent
/// the given `Pitch`.)
private func node(_ offset: Int, _ index: Tendency) -> PitchSpellingNode.Index {
    return .internal(.init(offset, index))
}

private func adjacencyScheme (contains: Bool) -> (Pitch.Class) -> GraphScheme<Pitch.Class> {
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

private let connectSameTendencies: GraphScheme<PitchSpellingNode.Index> =
    GraphScheme<Tendency> { edge in edge.a == edge.b }.pullback { node in node.tendency }

private let connectUpToDown: DirectedGraphScheme<PitchSpellingNode.Index> =
    DirectedGraphScheme<Tendency> { edge in
        edge.a == .up && edge.b == .down
        }.pullback { node in node.tendency }

private let bigMAdjacency: DirectedGraphScheme<PitchSpellingNode.Index> =
    connectSameTendencies * connectUpToDown

private let bigMAssignment: WeightedDirectedGraphScheme<PitchSpellingNode.Index, Double> =
    Double.infinity * bigMAdjacency

private let connectSameInts: GraphScheme<PitchSpellingNode.Index> =
    GraphScheme<Int?> { edge in edge.a == edge.b && edge.a != nil }.pullback { node in node.int }

private let connectDifferentInts: GraphScheme<PitchSpellingNode.Index> =
    GraphScheme<Int?> { edge in edge.a != edge.b }.pullback { node in node.int }

// For each `Pitch.Class` `n`, denotes which of `(n, .up)` and `(n, .down)` should
// be connected to `(8, .up)` in the spelling dependency model.
private let eightTendencyLink: [(Pitch.Class, Tendency)] = [
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
private let eightLookup = Set<UnorderedPair<Cross<Pitch.Class, Tendency>>> (
    eightTendencyLink.lazy.map(Cross.init).map { UnorderedPair($0, .init(8, .up)) }
)

extension FlowNetwork where Node == PitchSpellingNode.Index, Weight == Double {
    /// Create a `FlowNetwork` which is hooked up as neccesary for the Wetherfield pitch-spelling
    /// process.
    init(
        source: PitchSpellingNode.Index,
        sink: PitchSpellingNode.Index,
        internalNodes: [PitchSpellingNode.Index]
    )
    {
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
