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
    public typealias Edge = Graph<Value>.Edge
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

    /// - Returns: The edges whose values are equivalent to the maximum flow along the path from
    /// the `source` to the `sink` within which the edge resides.
    internal var saturatedEdges: Set<Edge> {
        return saturatedEdges(in: graph, comparingAgainst: residualNetwork)
    }

    /// - Returns: The residual network produced after subtracting the maximum flow from each of the
    /// edges. The saturated edges will be absent from the `residualNetwork`, as their values
    /// reached zero in the flow-propagation process.
    private var residualNetwork: Graph<Value> {
        var residualNetwork = graph
        while let path = residualNetwork.shortestPath(from: source, to: sink) {
            residualNetwork.insertPath(path.map { $0 - maximumFlow(of: path) })
        }
        return residualNetwork
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
    //
    // TODO: Create / update reverse edges!
    internal func edmondsKarp() -> FlowNetwork {
        let minimumCut = saturatedEdges(in: graph, comparingAgainst: residualNetwork)
        return FlowNetwork(residualNetwork, source: source, sink: sink)
    }

    /// - Returns: The set of edges which were saturated (and therefore removed from the residual
    /// network).
    private func saturatedEdges(
        in flowNetwork: Graph<Value>,
        comparingAgainst residualNetwork: Graph<Value>
    ) -> Set<Edge>
    {
        return Set(
            flowNetwork.edges.filter { originalEdge in
                !residualNetwork.edges.contains(
                    where: { residualEdge in
                        originalEdge.nodesAreEqual(to: residualEdge)
                    }
                )
            }
        )
    }

    internal func maximumFlow(of path: Path) -> Double {
        let capacity = path.edges.map { $0.value }.min()!
        return min(capacity, .greatestFiniteMagnitude)
    }
}
