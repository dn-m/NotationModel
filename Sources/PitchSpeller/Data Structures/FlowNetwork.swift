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
    
    typealias DirectedPath = DirectedGraph<Node>.Path
    typealias DirectedEdge = DirectedGraph<Node>.Edge

    /// - Returns: All of the `Node` values contained herein which are neither the `source` nor
    /// the `sink`.
    public var internalNodes: [Node] {
        return directedGraph.nodes.filter { $0 != source && $0 != sink }
    }
    
    /// - Returns: (0) The maximum flow of the network and (1) the residual network produced after
    /// pushing all possible flow from source to sink (while satisfying flow constraints) - with
    /// saturated edges flipped and all weights removed.
    var solvedForMaximumFlow: (flow: Double, network: UnweightedGraph<Node>) {
        var totalFlow = 0.0
        var residualNetwork = directedGraph
        
        func findAugmentingPath () -> Bool {
            guard let path = residualNetwork.shortestUnweightedPath(from: source, to: sink) else {
                return false
            }
            pushFlow(through: path)
            return true
        }
            
        func pushFlow (through path: UnweightedGraph<Node>.Path) {
            let minimumEdge = (path.adjacents.compactMap {
                residualNetwork.weight($0)
                }.min())!
            totalFlow += minimumEdge
            path.adjacents.forEach {
                residualNetwork.updateEdge($0, with: {
                    minuend in
                    minuend - minimumEdge
                })
            }
        }
        
        func addBackEdges () {
            residualNetwork.edges.map {
                $0.nodes
                }.filter {
                    let weight = residualNetwork.weight($0)!
                    return weight < 0.001 && weight > -0.001
                }.forEach {
                    residualNetwork.flipEdge(at: $0)
            }
        }
        
        while findAugmentingPath() { continue }
        addBackEdges()
        return (totalFlow, DirectedGraph<Node>.unWeightedVersion(of: residualNetwork))
    }
    
    /// - Returns: A minimum cut with nodes included on the `sink` side in case of a
    /// tiebreak (in- and out- edges saturated).
    public var minimumCut: (Set<Node>, Set<Node>) {
        return (sourceSideNodes, notSourceSideNodes)
    }
    
    /// - Returns: Nodes in residual network reachable from the `source`
    private var sourceSideNodes: Set<Node> {
        return Set(solvedForMaximumFlow.network.breadthFirstSearch(from: source))
    }
    
    /// - Returns: Nodes in residual network *not* reachable from the `source`
    private var notSourceSideNodes: Set<Node> {
        return solvedForMaximumFlow.network.nodes.subtracting(sourceSideNodes)
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
    
    /// Create a `FlowNetwork` with the given `directedGraph` and the given `source` and `sink` nodes.
    init(_ directedGraph: DirectedGraph<Node>, source: Node, sink: Node) {
        self.directedGraph = directedGraph
        self.source = source
        self.sink = sink
        self.graph = Graph([:])
    }
}
