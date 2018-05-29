//
//  FlowNetwork.swift
//  PitchSpeller
//
//  Created by James Bean on 5/24/18.
//

import Pitch

extension Wetherfield {

    // TODO: Expand this out so that each "notehead" (pitch-event) has a `box` of two nodes as
    // opposed to only a single `Pitch.Class` having a `box`.
    internal static func flowNetwork(
        pitchClasses: Set<Pitch.Class>,
        parsimonyPivot: Pitch.Class = 2
    ) -> FlowNetwork<UnassignedNodeInfo>
    {

        // Create an empty `Graph`.
        var graph = Graph<UnassignedNodeInfo>()

        // Create the `source` node of the pair representing the `parsimony pivot`.
        let source = graph.createNode(
            UnassignedNodeInfo(pitchClass: parsimonyPivot, index: 0)
        )

        // Create the `sink` node of the pair representing the `parsimony pivot`.
        let sink = graph.createNode(
            UnassignedNodeInfo(pitchClass: parsimonyPivot, index: 1)
        )

        var internalNodes: [Graph<UnassignedNodeInfo>.Node] = []

        // Create nodes for each pitch class in the given `pitchClasses`.
        for pitchClass in pitchClasses {

            // Create two nodes, one which will represent the `up` tendency (index 0), and the
            // other which will represent the `down` tendency (index 1)
            for index in [0,1] {
                internalNodes.append(
                    graph.createNode(UnassignedNodeInfo(pitchClass: pitchClass, index: index))
                )
            }
        }

        // Connect nodes
        for node in internalNodes {

            // Add edges from source to all internal nodes, with an initial value of 1.
            graph.addEdge(from: source, to: node, value: 1)

            // Add edges from all internal nodes to sink, with an initial value of 1.
            graph.addEdge(from: node, to: sink, value: 1)

            // Add edges from all internal nodes to all other internal nodes.
            // TODO: Ensure `filter` does not making this accidentally expensive.
            for other in internalNodes.lazy.filter({ $0 != node }) {
                graph.addEdge(from: node, to: other, value: 1)
            }
        }

        return FlowNetwork(graph, source: source, sink: sink)
    }

    internal struct UnassignedNodeInfo: Hashable {

        /// The `pitchClass` which is being represented by a given `Node`.
        ///
        /// - TODO: Make reference to `box` for `notehead` (pitch event) instead of `Pitch.Class`.
        let pitchClass: Pitch.Class

        /// Index of the node in the `Box` for the given `pitchClass`. Will be either `0`, or
        /// `1`. This value will ultimately represent the index within a `TendencyPair`.
        let index: Int
    }

    internal struct AssignedNodeInfo: Hashable {

        /// The `pitchClass` which is being represented by a given `Node`.
        let pitchClass: Pitch.Class

        /// Index of the node in the `Box` for the given `pitchClass`. Will be either `0`, or
        /// `1`. This value will ultimately represent the index within a `TendencyPair`.
        let index: Int

        /// The "tendency" value assigned subsequent to finding the minium cut.
        let tendency: PitchSpeller.Category.Tendency

        // MARK: - Initializers

        init(_ nodeInfo: UnassignedNodeInfo, tendency: PitchSpeller.Category.Tendency) {
            self.pitchClass = nodeInfo.pitchClass
            self.index = nodeInfo.index
            self.tendency = tendency
        }
    }

    /// - TODO: Make generic
    public struct FlowNetwork <Value: Hashable>: Hashable {

        typealias Path = Graph<Value>.Path
        typealias Node = Graph<Value>.Node

        // TODO: Consider more (space-)efficient storage of Nodes.
        internal var graph: Graph<Value>
        internal var source: Node
        internal var sink: Node
        internal var internalNodes: [Node] = []

        public init(_ graph: Graph<Value>, source: Graph<Value>.Node, sink: Graph<Value>.Node) {
            self.graph = graph
            self.source = source
            self.sink = sink
            self.internalNodes = graph.nodes.filter { $0 != source && $0 != sink }
        }

        /// - Returns: All of the paths from the `source` to the `sink`.
        internal var paths: Set<Path> {
            return graph.paths(from: source, to: sink)
        }

        /// - TODO: Implement
        private func edmondsKarp() {

            // Create Residual Network
            var residual = graph

            // Iterate over all Augmenting Paths

            while let path = residual.shortestPath(from: source, to: sink) {
                // Get maximum flow of shortest path:
                let maximumFlow = path.map { $0.value }.min()!

            }


            // ...

            // just keep puuuuushin' it through

            // ...
        }
    }
}
