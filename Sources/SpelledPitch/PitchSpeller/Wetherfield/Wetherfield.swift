//
//  Wetherfield.swift
//  PitchSpeller
//
//  Created by James Bean on 5/23/18.
//

import DataStructures
import Pitch

protocol PitchSpellingNode: Hashable {
    associatedtype Index
    
    var index: Index { get }
}

struct PitchSpeller {

    struct UnassignedNode: PitchSpellingNode {
        let index: Cross<Int, Tendency>
    }

    struct AssignedNode: PitchSpellingNode {
        let index: Cross<Int, Tendency>
        let assignment: Tendency
        init(_ index: Cross<Int, Tendency>, _ assignment: Tendency) {
            self.index = index
            self.assignment = assignment
        }
    }

    struct IndexedPitch: PitchSpellingNode {
        let index: Int
        let pitch: Pitch
    }

    /// - Returns: The nodes for the `Pitch` at the given `index`.
    private static func nodes(pitchAtIndex index: Int) -> (Cross<Int, Tendency>, Cross<Int, Tendency>) {
        return (.init(index, .down), .init(index, .up))
    }

    /// - Returns: The value of a node at the given offset (index of a `Pitch` within `pitches`),
    /// and an index (either `0` or `1`, which of the two nodes in the `FlowNetwork` that represent
    /// the given `Pitch`.)
    private static func node(_ offset: Int, _ index: Tendency) -> Cross<Int, Tendency> {
        return .init(offset, index)
    }

    /// - Returns: An array of nodes, each representing the index of the unassigned node in
    /// `pitchNodes`.
    private static func internalNodes(pitches: [Int: Pitch]) -> [Cross<Int, Tendency>] {
        return pitches.keys.flatMap { offset in [.down,.up].map { index in node(offset, index) } }
    }

    // MARK: - Instance Properties

    /// The omnipresent, tie-breaking `Pitch.Spelling` value.
    let parsimonyPivot: Pitch.Spelling

    /// The unspelled `Pitch` values to be spelled.
    let pitches: [Int: Pitch]

    /// The nodes within the `FlowNetwork`. The values are the encodings of the indices of `Pitch`
    /// values in `pitches.
    let pitchNodes: [Cross<Int, Tendency>]

    /// The `FlowNetwork` which will be manipulated in order to spell the unspelled `pitches`.
    let flowNetwork: FlowNetwork<Cross<Int, Tendency>,Double>

    // MARK: - Initializers

    /// Create a `PitchSpeller` to spell the given `pitches`, with the given `parsimonyPivot`.
    init(pitches: [Int: Pitch], parsimonyPivot: Pitch.Spelling = .init(.d)) {
        self.pitches = pitches
        self.parsimonyPivot = parsimonyPivot
        self.pitchNodes = PitchSpeller.internalNodes(pitches: pitches)
        self.flowNetwork = FlowNetwork(
            source: Cross<Int, Tendency>(-1, .down),
            sink: Cross<Int, Tendency>(-1, .up),
            internalNodes: pitchNodes
        )
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
            .reduce(into: [Int: (AssignedNode, AssignedNode)]()) { pairs, node in
                if !pairs.keys.contains(node.index.a) {
                    pairs[node.index.a] = (node, node)
                }
                switch node.index.b {
                case .up: pairs[node.index.a]!.0 = node
                case .down: pairs[node.index.a]!.1 = node
                }
            }.mapValues(spellPitch)
    }

    private func spellPitch(_ up: AssignedNode, _ down: AssignedNode) -> SpelledPitch {
        let pitch = self.pitch(node: up.index)
        let tendencies = TendencyPair(up.assignment, down.assignment)
        let spelling = Pitch.Spelling(pitchClass: pitch.class, tendencies: tendencies)!
        return try! pitch.spelled(with: spelling)
    }

    /// - Returns: The `Pitch` value for the given `node` value.
    private func pitch(node: Cross<Int, Tendency>) -> Pitch {
        return pitches[node.a]!
    }
}

extension FlowNetwork where Node == Cross<Int, Tendency>, Weight == Double {
    /// Create a `FlowNetwork` which is hooked up as neccesary for the Wetherfield pitch-spelling
    /// process.
    init(source: Cross<Int, Tendency>, sink: Cross<Int, Tendency>, internalNodes: [Cross<Int, Tendency>]) {
        let graph = WeightedDirectedGraph<Cross<Int, Tendency>,Double>(
            source: source,
            sink: sink,
            internalNodes: internalNodes
        )
        self.init(graph, source: source, sink: sink)
    }
}

extension PitchSpeller.AssignedNode: Comparable {
    static func < (lhs: PitchSpeller.AssignedNode, rhs: PitchSpeller.AssignedNode) -> Bool {
        return lhs.index < rhs.index
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
