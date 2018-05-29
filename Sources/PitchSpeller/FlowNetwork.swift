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

    /// - Returns: The residual network of this one after pushing maximum flow through.
    internal func edmondsKarp() -> FlowNetwork {
        var residualNetwork = graph
        var maximumNetworkFlow: Double = 0
        while let path = residualNetwork.shortestPath(from: source, to: sink) {
            let maximumPathFlow = min(maximumFlow(of: path), .greatestFiniteMagnitude)
            residualNetwork.insertPath(path.map { $0 - maximumPathFlow })
            // TODO: Create / update reverse edge
            maximumNetworkFlow += maximumPathFlow
        }
        return FlowNetwork(residualNetwork, source: source, sink: sink)
    }

    internal func maximumFlow(of path: Path) -> Double {
        return path.edges.map { $0.value }.min()!
    }
}
