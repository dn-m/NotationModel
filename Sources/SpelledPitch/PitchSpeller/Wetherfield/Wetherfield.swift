//
//  Wetherfield.swift
//  PitchSpeller
//
//  Created by James Bean on 5/23/18.
//

import Pitch

protocol PitchSpellingNode: Hashable {
    var index: Int { get }
}

struct PitchSpeller {

    struct UnassignedNode: PitchSpellingNode {
        let index: Int
    }

    struct AssignedNode: PitchSpellingNode {
        let index: Int
        let assignment: Tendency
        init(_ index: Int, _ assignment: Tendency) {
            self.index = index
            self.assignment = assignment
        }
    }

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
    private static func internalNodes(pitches: [Pitch]) -> [Int] {
        return pitches.indices.flatMap { offset in [0,1].map { index in node(offset, index) } }
    }

    // MARK: - Instance Properties

    /// The omnipresent, tie-breaking `Pitch.Spelling` value.
    let parsimonyPivot: Pitch.Spelling<EDO12>

    /// The unspelled `Pitch` values to be spelled.
    let pitches: [Pitch]

    /// The nodes within the `FlowNetwork`. The values are the encodings of the indices of `Pitch`
    /// values in `pitches.
    let pitchNodes: [Int]

    /// The `FlowNetwork` which will be manipulated in order to spell the unspelled `pitches`.
    let flowNetwork: FlowNetwork<Int>

    // MARK: - Initializers

    /// Create a `PitchSpeller` to spell the given `pitches`, with the given `parsimonyPivot`.
    init(pitches: [Pitch], parsimonyPivot: Pitch.Spelling<EDO12> = .init(.d)) {
        self.pitches = pitches
        self.parsimonyPivot = parsimonyPivot
        self.pitchNodes = PitchSpeller.internalNodes(pitches: pitches)
        self.flowNetwork = FlowNetwork(source: -2, sink: -1, internalNodes: pitchNodes)
    }

    /// - Returns: An array of `SpelledPitch` values in the order in which the original
    /// unspelled `Pitch` values are given.
    func spell() -> [SpelledPitch<EDO12>] {

        var assignedNodes: [AssignedNode] {
            let (sourceSide, sinkSide) = flowNetwork.minimumCut
            let downNodes = sourceSide.map { index in AssignedNode(index, .down) }
            let upNodes = sinkSide.map { index in AssignedNode(index, .up) }
            return downNodes + upNodes
        }

        return assignedNodes
            .sorted { $0.index < $1.index }
            .dropFirst(2)
            .pairs
            .map(spellPitch)
    }

    private func spellPitch(_ up: AssignedNode, _ down: AssignedNode) -> SpelledPitch<EDO12> {
        let pitch = self.pitch(node: up.index)
        let tendencies = TendencyPair((up.assignment, down.assignment))
        let spelling = Pitch.Spelling<EDO12>(pitchClass: pitch.class, tendencies: tendencies)!
        return SpelledPitch(try! pitch.spelled(with: Pitch.Spelling<EDO48>(spelling)))
    }

    /// - Returns: The `Pitch` value for the given `node` value.
    private func pitch(node: Int) -> Pitch {
        return pitches[node / 2]
    }
}

extension FlowNetwork where Node == Int {
    /// Create a `FlowNetwork` which is hooked up as neccesary for the Wetherfield pitch-spelling
    /// process.
    init(source: Int, sink: Int, internalNodes: [Int]) {
        let graph = _DirectedGraph(source: source, sink: sink, internalNodes: internalNodes)
        self.init(graph, source: -2, sink: -1)
    }
}

extension _DirectedGraph where Pair.A == Int, Weight == Double {
    /// Create a `DirectedGraph` which is hooked up as necessary for the Wetherfield pitch-spelling process.
    init (source: Int, sink: Int, internalNodes: [Int]) {
        self.init(Set([source, sink] + internalNodes), [:])
        for node in internalNodes {
            insertEdge(from: source, to: node, withWeight: 1)
            insertEdge(from: node, to: sink, withWeight: 1)
            for other in internalNodes.lazy.filter({ $0 != node }) {
                insertEdge(from: node, to: other, withWeight: 1)
            }
        }
    }
}
