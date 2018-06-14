//
//  Wetherfield.swift
//  PitchSpeller
//
//  Created by James Bean on 5/23/18.
//

import Pitch
import SpelledPitch

struct PitchSpeller {

    let parsimonyPivot: Pitch.Class
    let pitches: [Pitch]

    // 2 * Box offset + Box index
    let pitchNodes: [Int]
    let flowNetwork: FlowNetwork<Int>

    init(pitches: [Pitch], parsimonyPivot: Pitch.Class) {
        self.pitches = pitches
        self.parsimonyPivot = parsimonyPivot
        self.pitchNodes = internalNodes(pitches: pitches)
        self.flowNetwork = FlowNetwork(source: -2, sink: -1, internalNodes: pitchNodes)
    }

    /// - Returns: An array of `SpelledPitch` values in the order in which the original
    /// unspelled `Pitch` values are given.
    func spell() -> [SpelledPitch] {

        // 1. Assign Nodes
        // 2. Reconstitute "Box" pairs of assigned nodes
        // 3. Map these pairs into `SpelledPitch` values
        // 4. `return`

        fatalError()
    }

    private func assignedNodes() -> [Tendency] {
        let (sourcePartition, sinkPartition) = flowNetwork.partitions
        return sourcePartition.nodes.map { _ in .down } + sinkPartition.nodes.map { _ in .up }
    }

    /// - Returns: The `Pitch` value for the given `offset` and the given `index`.
    func index(offset: Int, index: Int) -> Pitch {
        return pitches[2 * offset + index]
    }

    func pitch(node: Int) -> Pitch? {
        guard node >= pitches.startIndex && node < pitches.endIndex else { return nil }
        return pitches[node]
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

extension Graph where Value == Int {
    /// Create a `Graph` which is hooked up as necessary for the Wetherfield pitch-spelling process.
    init(source: Int, sink: Int, internalNodes: [Int]) {
        self.init([source, sink] + internalNodes)
        for node in internalNodes {
            insertEdge(from: source, to: node, value: 1)
            insertEdge(from: node, to: sink, value: 1)
            for other in internalNodes.lazy.filter({ $0 != node }) {
                insertEdge(from: node, to: other, value: 1)
            }
        }
    }
}

/// - Returns: The `source` node for a `FlowNetwork`. This node is given an `identifier` of
/// `-1`, and is attached to the pitch class defined by the `parsimonyPivot`.
func source() -> Graph<Int>.Node {
    return node(offset: -1, index: 0)
}

/// - Returns: The `sink` node for a `FlowNetwork`. This node is given an `identifier` of
/// `-1`, and is attached to the pitch class defined by the `parsimonyPivot`.
func sink() -> Graph<Int>.Node {
    return node(offset: -1, index: 1)
}

/// - Returns: An array of nodes, placed in the given `graph`. Each node is given an
/// `identifier` equivalent to its index in the `pitches` array.
//
// FIXME: the `-> [Graph<UnassignedNodeInfo>.Node]` disambiguation should not be necessary. Further,
// the `flatMap` _should_ become `compactMap`, as `compactMap` seems only to work for optionals?
func internalNodes(pitches: [Pitch]) -> [Graph<Int>.Node] {
    return pitches.enumerated().flatMap { offset, pitch -> [Graph<Int>.Node] in
        return [0,1].map { index in node(offset: offset, index: index) }
    }
}

/// - Returns: A `Node` which wraps an `UnassignedNodeInfo` with the given `item` and `index`.
func node(offset: Int, index: Int) -> Graph<Int>.Node {
    return 2 * offset + index
}
