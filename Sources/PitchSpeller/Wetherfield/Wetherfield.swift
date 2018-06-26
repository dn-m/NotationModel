//
//  Wetherfield.swift
//  PitchSpeller
//
//  Created by James Bean on 5/23/18.
//

import Restructure
import Pitch
import SpelledPitch

struct AssignedNode {
    let index: Int
    let tendency: Tendency
    init(_ index: Int, _ tendency: Tendency) {
        self.index = index
        self.tendency = tendency
    }
}

struct PitchSpeller {

    /// - Returns: The nodes for the `Pitch` at the given `index`.
    private static func nodes(pitchAtIndex index: Int) -> (Int, Int) {
        let offset = 2 * index
        return (offset, offset + 1)
    }

    /// - Returns: The value of a node at the given offset (index of a `Pitch` within `pitches`),
    /// and an index (either `0` or `1`, which of the two nodes in the `FlowNetwork` that represent
    /// the given `Pitch`.)
    private static func node(_ offset: Int, _ index: Int) -> Int {
        return 2 * offset + index
    }

    /// - Returns: An array of nodes, each representing the index of the unassigned node in
    /// `pitchNodes`.
    private static func internalNodes(pitches: [Pitch]) -> [Graph<Int>.Node] {
        return pitches.indices.flatMap { offset in [0,1].map { index in node(offset, index) } }
    }

    // MARK: - Instance Properties

    /// The omnipresent, tie-breaking `Pitch.Class` value.
    let parsimonyPivot: Pitch.Class

    /// The unspelled `Pitch` values to be spelled.
    let pitches: [Pitch]

    /// The nodes within the `FlowNetwork`. The values are the encodings of the indices of `Pitch`
    /// values in `pitches.
    let pitchNodes: [Int]

    /// The `FlowNetwork` which will be manipulated in order to spell the unspelled `pitches`.
    let flowNetwork: FlowNetwork<Int>

    // MARK: - Initializers

    /// Create a `PitchSpeller` to spell the given `pitches`, with the given `parsimonyPivot`.
    init(pitches: [Pitch], parsimonyPivot: Pitch.Class = 2) {
        self.pitches = pitches
        self.parsimonyPivot = parsimonyPivot
        self.pitchNodes = PitchSpeller.internalNodes(pitches: pitches)
        self.flowNetwork = FlowNetwork(source: -2, sink: -1, internalNodes: pitchNodes)
    }

    /// - Returns: An array of `SpelledPitch` values in the order in which the original
    /// unspelled `Pitch` values are given.
    func spell() -> [SpelledPitch] {

        var assignedNodes: [AssignedNode] {
            let (sourcePartition, sinkPartition) = flowNetwork.partitions
            let sourceNodes = sourcePartition.nodes.map { index in AssignedNode(index, .down) }
            let sinkNodes = sinkPartition.nodes.map { index in AssignedNode(index, .up) }
            return sourceNodes + sinkNodes
        }

        return assignedNodes
            .sorted { $0.index < $1.index }
            .dropFirst(2)
            .pairs
            .map(spellPitch)
    }

    private func spellPitch(_ up: AssignedNode, _ down: AssignedNode) -> SpelledPitch {
        let pitch = self.pitch(node: up.index)
        let tendencies = TendencyPair((up.tendency, down.tendency))
        let spelling = Pitch.Spelling(pitchClass: pitch.class, tendencies: tendencies)!
        return try! pitch.spelled(with: spelling)
    }

    /// - Returns: The `Pitch` value for the given `node` value.
    private func pitch(node: Int) -> Pitch {
        return pitches[node / 2]
    }
}

extension FlowNetwork where Value == Int {
    /// Create a `FlowNetwork` which is hooked up as neccesary for the Wetherfield pitch-spelling
    /// process.
    init(source: Int, sink: Int, internalNodes: [Int]) {
        let graph = Graph(source: source, sink: sink, internalNodes: internalNodes)
        self.init(graph, source: -2, sink: -1)
    }
}

extension Graph where Node == Int {
    /// Create a `Graph` which is hooked up as necessary for the Wetherfield pitch-spelling process.
    init(source: Int, sink: Int, internalNodes: [Int]) {
        self.init([source, sink] + internalNodes)
        for node in internalNodes {
            insertEdge(from: source, to: node, value: 1)
            // FIXME: insertEdge(from: source, to: node, value: epsilon *
            // lookupTable[source.pitchclass, source.index, node.pitchclass, node.index])
            insertEdge(from: node, to: sink, value: 1)
            // FIXME: insertEdge(from: node, to: sink, value: epsilon *
            // lookupTable[node.pitchclass, node.index, sink.pitchclass, sink.index])
            for other in internalNodes.lazy.filter({ $0 != node }) {
                insertEdge(from: node, to: other, value: 1)
                // FIXME: if node.offset == other.offset && node.index == 1 {
                //           insertEdge(from: node, to other, value: bigM)
                // else insertEdge(from: node, to: other,
                //      value: lookupTable[node.pitchclass, node.index, other.pitchclass, other.index])
            }
        }
    }
}
