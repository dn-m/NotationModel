//
//  Wetherfield.swift
//  PitchSpeller
//
//  Created by James Bean on 5/23/18.
//

import Pitch
import SpelledPitch

/// The payload for a FlowNetwork which has not yet been assigned.
struct UnassignedNodeInfo: Hashable {

    /// The unspelled pitch class and associated identifier which will ultimately be
    /// represented.
    let item: UnspelledPitchItem

    /// Index of the node in the `Box` for the given `pitchClass`. Will be either `0`, or
    /// `1`. This value will ultimately represent the index within a `TendencyPair`.
    let index: Int

    /// - Returns: An `AssignedNodeInfo` with the given `tendency` applied to `self`.
    func assigning(tendency: Tendency) -> AssignedNodeInfo {
        return AssignedNodeInfo(self, tendency: tendency)
    }
}

/// The payload for a Flownetwork which has been assigned.
struct AssignedNodeInfo: Hashable {

    /// The unspelled pitch class and associated identifier which is now representable.
    let item: UnspelledPitchItem

    /// Index of the node in the `Box` for the given `pitchClass`. Will be either `0`, or
    /// `1`. This value will ultimately represent the index within a `TendencyPair`.
    let index: Int

    /// The "tendency" value assigned subsequent to finding the minium cut.
    let tendency: Tendency

    // MARK: - Initializers

    init(_ nodeInfo: UnassignedNodeInfo, tendency: Tendency) {
        self.item = nodeInfo.item
        self.index = nodeInfo.index
        self.tendency = tendency
    }
}


/// "Namespace" for Wetherfield Pitch Speller.
public enum Wetherfield {

    /// Pitch spelling mechanism which implements the formalization proposed in Wetherfield's thesis
    /// _A Graphical Theory of Musical Pitch Spelling_.
    final class PitchSpeller {

        typealias Node = FlowNetwork<UnassignedNodeInfo>.Node
        typealias Edge = FlowNetwork<UnassignedNodeInfo>.Edge

        /// The `Pitch` values to be spelled.
        let pitches: [Pitch]

        /// Non-source/-sink nodes, in order of corresponding value in `pitches`.
        var nodes: [Node] = []

        /// The omnipresent tie-breaking pitch class
        let parsimonyPivot: Pitch.Class

        let flowNetwork: FlowNetwork<UnassignedNodeInfo>

        // MARK: - Initializers

        /// Create a `PitchSpeller` to spell the given `pitches`.
        init(pitches: [Pitch], parsimonyPivot: Pitch.Class) {
            self.pitches = pitches
            self.parsimonyPivot = parsimonyPivot

            var graph = Graph<UnassignedNodeInfo>()
            let source = makeSource(for: parsimonyPivot, in: &graph)
            let sink = makeSink(for: parsimonyPivot, in: &graph)
            let internalNodes = makeInternalNodes(for: pitches, in: &graph)
            hookUpNodes(source: source, sink: sink, internalNodes: internalNodes, in: &graph)
            self.flowNetwork = FlowNetwork(graph, source: source, sink: sink)
        }

        // MARK: - Instance Methods

        /// - Returns: An array of `SpelledPitch` values in the order in which the original
        /// unspelled `Pitch` values are given.
        func spell() -> [SpelledPitch] {

            // 1. Assign Nodes
            // 2. Reconstitute "Box" pairs of assigned nodes
            // 3. Map these pairs into `SpelledPitch` values
            // 4. `return`

            fatalError()
        }

        func assigned() -> [AssignedNodeInfo] {
            let (sourcePartition, sinkPartition) = flowNetwork.partitions
            let sourceNodes = sourcePartition.nodes.map { $0.value.assigning(tendency: .down) }
            let sinkNodes = sinkPartition.nodes.map { $0.value.assigning(tendency: .up) }
            return sourceNodes + sinkNodes
        }

        func nodes(identifier: Int) -> (Node, Node)? {
            return nil
        }

        func node(identifier: Int, index: Int) -> Node? {
            return nil
        }
    }
}

/// - Returns: The `source` node in the `FlowNetwork`. This node is given an `identifier` of
/// `-1`, and is attached to the pitch class defined by the `parsimonyPivot`.
func makeSource(for parsimonyPivot: Pitch.Class, in graph: inout Graph<UnassignedNodeInfo>)
    -> Graph<UnassignedNodeInfo>.Node
{
    let item = UnspelledPitchItem(identifier: -1, pitchClass: parsimonyPivot)
    let payload = UnassignedNodeInfo(item: item, index: 0)
    return graph.createNode(payload)
}

/// - Returns: The `sink` node in the `FlowNetwork`. This node is given an `identifier` of
/// `-1`, and is attached to the pitch class defined by the `parsimonyPivot`.
func makeSink(for parsimonyPivot: Pitch.Class, in graph: inout Graph<UnassignedNodeInfo>)
    -> Graph<UnassignedNodeInfo>.Node
{
    let item = UnspelledPitchItem(identifier: -1, pitchClass: parsimonyPivot)
    let payload = UnassignedNodeInfo(item: item, index: 1)
    return graph.createNode(payload)
}

/// - Returns: An array of nodes, placed in the given `graph`. Each node is given an
/// `identifier` equivalent to its index in the `pitches` array.
func makeInternalNodes(for pitches: [Pitch], in graph: inout Graph<UnassignedNodeInfo>)
    -> [Graph<UnassignedNodeInfo>.Node]
{
    var internalNodes: [Graph<UnassignedNodeInfo>.Node] = []
    for (identifier, pitch) in pitches.enumerated() {
        let item = UnspelledPitchItem(identifier: identifier, pitchClass: pitch.class)
        for index in [0,1] {
            let nodeInfo = UnassignedNodeInfo(item: item, index: index)
            let node = graph.createNode(nodeInfo)
            internalNodes.append(node)
        }
    }
    return internalNodes
}

/// Attaches all of the nodes in the graph with default values of `1`.
func hookUpNodes(
    source: Graph<UnassignedNodeInfo>.Node,
    sink: Graph<UnassignedNodeInfo>.Node,
    internalNodes: [Graph<UnassignedNodeInfo>.Node],
    in graph: inout Graph<UnassignedNodeInfo>
)
{
    for node in internalNodes {
        graph.insertEdge(from: source, to: node, value: 1)
        graph.insertEdge(from: node, to: sink, value: 1)
        for other in internalNodes.lazy.filter({ $0 != node }) {
            graph.insertEdge(from: node, to: other, value: 1)
        }
    }
}
