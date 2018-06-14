//
//  Wetherfield.swift
//  PitchSpeller
//
//  Created by James Bean on 5/23/18.
//

import Pitch
import SpelledPitch

typealias Node = Graph<UnassignedNodeInfo>.Node
typealias Edge = Graph<UnassignedNodeInfo>.Edge

/// The index of an `UnassignedNodeInfo` within a pair of nodes which represent a single
/// `PitchItem`.
enum Index: Int {
    case zero = 0
    case one = 1
}

struct PitchSpeller {

    let pitches: [Pitch]
    let pitchNodes: [Node]
    let flowNetwork: FlowNetwork<UnassignedNodeInfo>

    init(pitches: [Pitch], parsimonyPivot: Pitch.Class) {
        self.pitches = pitches
        self.pitchNodes = internalNodes(pitches: pitches)
        self.flowNetwork = makeFlowNetwork(
            source: source(parsimonyPivot: parsimonyPivot),
            sink: sink(parsimonyPivot: parsimonyPivot),
            internalNodes: pitchNodes
        )
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

    private func assignedNodes() -> [AssignedNodeInfo] {
        let (sourcePartition, sinkPartition) = flowNetwork.partitions
        let sourceNodes = sourcePartition.nodes.map { $0.value.assigning(tendency: .down) }
        let sinkNodes = sinkPartition.nodes.map { $0.value.assigning(tendency: .up) }
        return sourceNodes + sinkNodes
    }

    /// - Returns: The index in `pitches` / `pitchNodes` of the given `unassignedNodeInfo`.
    private func index(of unassignedNodeInfo: UnassignedNodeInfo) -> Int? {
        let index = unassignedNodeInfo.item.identifier + unassignedNodeInfo.index.rawValue
        guard index >= pitches.startIndex && index < pitches.endIndex else { return nil }
        return index
    }
}

/// - Returns: A `FlowNetwork` which is hooked up as neccesary for the Wetherfield pitch-spelling
/// process.
func makeFlowNetwork(source: Node, sink: Node, internalNodes: [Node])
    -> FlowNetwork<UnassignedNodeInfo>
{
    return FlowNetwork(
        makeGraph(source: source, sink: sink, internalNodes: internalNodes),
        source: source,
        sink: sink
    )
}

/// - Returns: A `Graph` which is hooked up as necessary for the Wetherfield pitch-spelling process.
func makeGraph(source: Node, sink: Node, internalNodes: [Node]) -> Graph<UnassignedNodeInfo> {
    var graph = Graph([source, sink] + internalNodes)
    for node in internalNodes {
        graph.insertEdge(from: source, to: node, value: 1)
        graph.insertEdge(from: node, to: sink, value: 1)
        for other in internalNodes.lazy.filter({ $0 != node }) {
            graph.insertEdge(from: node, to: other, value: 1)
        }
    }
    return graph
}

/// - Returns: A `Node` which wraps an `UnassignedNodeInfo` with the given `item` and `index`.
func node(item: UnspelledPitchItem, index: Index) -> Graph<UnassignedNodeInfo>.Node {
    return Graph.Node(UnassignedNodeInfo(item: item, index: index))
}

/// - Returns: The `source` node for a `FlowNetwork`. This node is given an `identifier` of
/// `-1`, and is attached to the pitch class defined by the `parsimonyPivot`.
func source(parsimonyPivot: Pitch.Class) -> Graph<UnassignedNodeInfo>.Node {
    let item = UnspelledPitchItem(identifier: -1, pitchClass: parsimonyPivot)
    return node(item: item, index: .zero)
}

/// - Returns: The `sink` node for a `FlowNetwork`. This node is given an `identifier` of
/// `-1`, and is attached to the pitch class defined by the `parsimonyPivot`.
func sink(parsimonyPivot: Pitch.Class) -> Graph<UnassignedNodeInfo>.Node {
    let item = UnspelledPitchItem(identifier: -1, pitchClass: parsimonyPivot)
    return node(item: item, index: .one)
}

/// - Returns: An array of nodes, placed in the given `graph`. Each node is given an
/// `identifier` equivalent to its index in the `pitches` array.
//
// FIXME: the `-> [Graph<UnassignedNodeInfo>.Node]` disambiguation should not be necessary. Further,
// the `flatMap` _should_ become `compactMap`, as `compactMap` seems only to work for optionals?
func internalNodes(pitches: [Pitch]) -> [Graph<UnassignedNodeInfo>.Node] {
    return pitches.enumerated().flatMap { identifier, pitch -> [Graph<UnassignedNodeInfo>.Node] in
        let item = UnspelledPitchItem(identifier: identifier, pitchClass: pitch.class)
        return [.zero, .one].map { index in node(item: item, index: index) }
    }
}
