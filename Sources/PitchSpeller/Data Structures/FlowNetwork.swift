//
//  FlowNetwork.swift
//  PitchSpeller
//
//  Created by James Bean on 5/24/18.
//

// MARK: typealiases
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
        var residualNetwork = directedGraph
        
        func findAugmentingPath () -> Bool {
            guard let path = residualNetwork.shortestUnweightedPath(from: source, to: sink) else {
                return false
            }
            pushFlow(through: path)
            return true
        }
            
        func pushFlow (through path: UnweightedGraph<Node>.Path) {
            let minimumEdge = (path.adjacents.compactMap(residualNetwork.weight).min())!
            path.adjacents.forEach { edge in
                residualNetwork.updateEdge(edge, with: { capacity in capacity - minimumEdge })
                if residualNetwork.weight(edge)! == 0.0 {
                    residualNetwork.removeEdge(from: edge.a, to: edge.b)
                }
            }
        }
        
        func addBackEdges () {
            directedGraph.adjacents.keys.lazy
            .filterComplement(residualNetwork.adjacents.keys.contains)
            .forEach { nodes in
                residualNetwork.flipEdge(containing: nodes)
            }
        }
        
        func computeFlow () -> Double {
            let sourceEdges = directedGraph.neighbors(of: source).lazy
                .map { OrderedPair(self.source, $0) }
                .partition(residualNetwork.adjacents.keys.contains)
            let edgesPresent = sourceEdges.whereTrue.lazy
                .map { self.directedGraph.weight($0)! - residualNetwork.weight($0)! }
                .reduce(0.0, +)
            let edgesAbsent = sourceEdges.whereFalse.lazy
                .compactMap(directedGraph.weight)
                .reduce(0.0, +)
            return edgesPresent + edgesAbsent
        }
        
        while findAugmentingPath() { continue }
        addBackEdges()
        return (computeFlow(), residualNetwork.unweighted)
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

    // TODO: Consider more (space-)efficient storage of Nodes.
    internal var directedGraph: DirectedGraph<Node>
    internal var source: Node
    internal var sink: Node

    // MARK: - Initializers
    
    /// Create a `FlowNetwork` with the given `directedGraph` and the given `source` and `sink` nodes.
    init(_ directedGraph: DirectedGraph<Node>, source: Node, sink: Node) {
        self.directedGraph = directedGraph
        self.source = source
        self.sink = sink
    }
}

extension Sequence {
    func filterComplement (_ predicate: (Element) -> Bool) -> [Element] {
        return filter { !predicate($0) }
    }
    
    func partition (_ predicate: (Element) -> Bool) -> (whereFalse: [Element], whereTrue: [Element]) {
        return (filterComplement(predicate), filter(predicate))
    }
}
