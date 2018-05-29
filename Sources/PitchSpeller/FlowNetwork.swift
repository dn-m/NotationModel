//
//  FlowNetwork.swift
//  PitchSpeller
//
//  Created by James Bean on 5/24/18.
//

/// Directed Graph with several properties:
/// - Each edge has a capacity for flow
/// - A "source" node, which is only emanates flow outward
/// - A "sink" node, which only receives flow
public struct FlowNetwork <Value: Hashable>: Hashable {

    public typealias Path = Graph<Value>.Path
    public typealias Node = Graph<Value>.Node

    /// - Returns: All of the `Node` values contained herein which are neither the `source` nor
    /// the `sink`.
    public var internalNodes: [Node] {
        return graph.nodes.filter { $0 != source && $0 != sink }
    }

    /// - Returns: All of the paths from the `source` to the `sink`.
    internal var paths: Set<Path> {
        return graph.paths(from: source, to: sink)
    }

    // TODO: Consider more (space-)efficient storage of Nodes.
    internal var graph: Graph<Value>
    internal var source: Node
    internal var sink: Node

    // MARK: - Initializers

    /// Create a `FlowNetwork` with the given `graph` and the given `source` and `sink` nodes.
    public init(_ graph: Graph<Value>, source: Graph<Value>.Node, sink: Graph<Value>.Node) {
        self.graph = graph
        self.source = source
        self.sink = sink
    }

    /// - TODO: Implement
    internal func edmondsKarp() {

        // Create Residual Network
        var residual = graph

        // Iterate over all Augmenting Paths

        // The maximum flow for the entire network
        var flow: Double = 0

        while let path = residual.shortestPath(from: source, to: sink) {
            // Get maximum flow of shortest path:
            let capacities = min(maximumFlow(of: path), .greatestFiniteMagnitude)

        }

        // ...

        // just keep puuuuushin' it through

        // ...
    }

    internal func maximumFlow(of path: Path) -> Double {
        return path.edges.map { $0.value }.min()!
    }
}

