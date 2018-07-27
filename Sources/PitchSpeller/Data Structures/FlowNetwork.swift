//
//  FlowNetwork.swift
//  PitchSpeller
//
//  Created by James Bean on 5/24/18.
//

// temporary typealiases
public typealias Graph = __Graph
typealias DirectedGraph<Node: Hashable> = _Graph<Double, DirectedOver<Node>>
typealias UnweightedGraph<Node: Hashable> = _Graph<WithoutWeights, DirectedOver<Node>>

/// Directed Graph with several properties:
/// - Each edge has a capacity for flow
/// - A "source" node, which is only emanates flow outward
/// - A "sink" node, which only receives flow
public struct FlowNetwork <Node: Hashable> {

    public typealias Path = Graph<Node>.Path
    public typealias Edge = Graph<Node>.Edge
    
    typealias DirectedPath = DirectedGraph<Node>.Path
    typealias DirectedEdge = DirectedGraph<Node>.Edge

    /// - Returns: All of the `Node` values contained herein which are neither the `source` nor
    /// the `sink`.
    public var internalNodes: [Node] {
        return directedGraph.nodes.filter { $0 != source && $0 != sink }
    }

    /// - Returns: The edges whose values are equivalent to the maximum flow along the path from
    /// the `source` to the `sink` within which the edge resides.
    public var saturatedEdges: Set<Edge> {
        return saturatedEdges(in: graph, comparingAgainst: residualNetwork)
    }

    /// - Returns: The residual network produced after subtracting the maximum flow from each of the
    /// edges. The saturated edges will be absent from the `residualNetwork`, as their values
    /// reached zero in the flow-propagation process.
    ///
    /// - TODO: Add backflow to reversed edges.
    public var residualNetwork: Graph<Node> {
        var residualNetwork = graph
        while let path = residualNetwork.shortestPath(from: source, to: sink) {
            residualNetwork.insertPath(path.map { $0 - maximumFlow(of: path) })
        }
        return residualNetwork
    }
    
    // Redundant extra residualNetwork variable for phasing out the other
    var maxFlowNetwork: UnweightedGraph<Node> {
        var maxFlowNetwork = directedGraph
        
        func findAugmentingPaths () {
            while let path = maxFlowNetwork.shortestUnweightedPath(from: source, to: sink) {
                guard let minimumEdge = (path.adjacents.compactMap {
                    maxFlowNetwork.weight($0)
                    }.min()) else { break }
                path.adjacents.forEach { maxFlowNetwork.updateEdge($0, with: {
                    minuend in
                    minuend - minimumEdge
                })
                }
            }
        }
        
        func addBackEdges () {
            maxFlowNetwork.edges.map {
                $0.nodes
                }.filter {
                    let weight = maxFlowNetwork.weight($0)!
                    return weight < 0.001 && weight > -0.001
                }.forEach {
                    maxFlowNetwork.flipEdge(at: $0)
            }
        }
        
        findAugmentingPaths()
        addBackEdges()
        return DirectedGraph<Node>.unWeightedVersion(of: maxFlowNetwork)
    }

    /// - Returns: The two partitions on either side of the s-t cut.
    public var partitions: (source: Graph<Node>, sink: Graph<Node>) {
        return (graph(sourceReachableNodes), graph(sinkReachableNodes.reversed()))
    }

    /// - Returns: Nodes in residual network reachable forwards from the `source`.
    private var sourceReachableNodes: [Node] {
        return residualNetwork.breadthFirstSearch(from: source)
    }

    /// - Returns: Nodes in residual network reachable backwards from the `sink`.
    private var sinkReachableNodes: [Node] {
        return residualNetwork.reversed.breadthFirstSearch(from: sink)
    }

    /// - Returns: A `Graph` composed of the given `nodes`, and corresponding edges in this graph.
    private func graph(_ nodes: [Node]) -> Graph<Node> {
        return Graph(graph.edges(nodes))
    }

    // TODO: Consider more (space-)efficient storage of Nodes.
    internal var graph: Graph<Node>
    internal var directedGraph: DirectedGraph<Node>
    internal var source: Node
    internal var sink: Node

    // MARK: - Initializers

    /// Create a `FlowNetwork` with the given `graph` and the given `source` and `sink` nodes.
    public init(_ graph: Graph<Node>, source: Node, sink: Node) {
        self.graph = graph
        self.directedGraph = DirectedGraph(graph)
        self.source = source
        self.sink = sink
    }

    /// - Returns: The set of edges which were saturated (and therefore removed from the residual
    /// network).
    private func saturatedEdges(
        in flowNetwork: Graph<Node>,
        comparingAgainst residualNetwork: Graph<Node>
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
