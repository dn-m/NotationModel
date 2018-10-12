//
//  FlowNetwork.swift
//  PitchSpeller
//
//  Created by James Bean on 5/24/18.
//

import DataStructures

/// Directed graph with several properties:
/// - Each edge has a capacity for flow
/// - A "source" node, which is only emanates flow outward
/// - A "sink" node, which only receives flow
public struct FlowNetwork <Node: Hashable, Weight: Numeric & Comparable> {

    // MARK: - Instance Properties

    var directedGraph: WeightedDirectedGraph<Node,Weight>
    var source: Node
    var sink: Node
}

extension FlowNetwork {

    // MARK: - Initializers

    /// Create a `FlowNetwork` with the given `directedGraph` and the given `source` and `sink` nodes.
    init(_ directedGraph: WeightedDirectedGraph<Node,Weight>, source: Node, sink: Node) {
        self.directedGraph = directedGraph
        self.directedGraph.insert(source)
        self.directedGraph.insert(sink)
        self.source = source
        self.sink = sink
    }
}

extension WeightedDirectedGraph where Weight: Comparable {

    /// Inserts an edge in the opposite direction of the given `edge` with the minimum capacity
    mutating func letReturn(_ amount: Weight, through edge: Edge) {
        let reversedEdge = edge.swapped
        if contains(reversedEdge) {
            updateEdge(reversedEdge) { capacity in capacity + amount }
        } else {
            insertEdge(reversedEdge, weight: amount)
        }
    }

    /// Pushes `amount` of flow through `edge` while allow the flow come back in the opposite
    /// direction if the `edge` is completely saturated
    mutating func push(_ amount: Weight, through edge: Edge) {
        if amount < weight(edge)! {
            updateEdge(edge) { capacity in capacity - amount }
        } else {
            removeEdge(edge)
        }
        letReturn(amount, through: edge)
    }

    /// Pushes flow through the given `path` in this `graph`.
    mutating func pushFlow(through path: [Node]) {
        let edges = path.pairs.map(OrderedPair.init)
        let mostFlow = edges.compactMap(weight).min() ?? 0
        edges.forEach { edge in push(mostFlow, through: edge) }
    }
}

extension FlowNetwork {

    // MARK: - Computed Properties

    /// - Returns: All of the `Node` values contained herein which are neither the `source` nor
    /// the `sink`.
    public var internalNodes: [Node] {
        return directedGraph.nodes.filter { $0 != source && $0 != sink }
    }

    /// - Returns: A minimum cut with nodes included on the `sink` side in case of a
    /// tiebreak (in- and out- edges saturated).
    public var minimumCut: (Set<Node>, Set<Node>) {
        let (_, residualNetwork) = maximumFlowAndResidualNetwork
        let sourceSideNodes = Set(residualNetwork.breadthFirstSearch(from: source))
        let notSourceSideNodes = residualNetwork.nodes.subtracting(sourceSideNodes)
        return (sourceSideNodes, notSourceSideNodes)
    }

    /// - Returns: (0) The maximum flow of the network and (1) the residual network produced after
    /// pushing all possible flow from source to sink (while satisfying flow constraints) - with
    /// saturated edges flipped and all weights removed.
    var maximumFlowAndResidualNetwork: (flow: Weight, network: DirectedGraph<Node>) {
        // Make a copy of the directed representation of the network to be mutated by pushing flow
        // through it.
        var residualNetwork = directedGraph
        // While an augmenting path (a path emanating directionally from the source node) can be
        // found, push flow through the path, mutating the residual network
        while let augmentingPath = residualNetwork.shortestUnweightedPath(from: source, to: sink) {
            residualNetwork.pushFlow(through: augmentingPath)
        }
        // Compares the edges in the mutated residual network against the original directed
        // graph.
        let flow: Weight = {
            let sourceEdges = directedGraph.neighbors(of: source).lazy
                .map { OrderedPair(self.source, $0) }
                .partition(residualNetwork.contains)
            let edgesPresent = sourceEdges.whereTrue.lazy
                .map { edge in self.directedGraph.weight(edge)! - residualNetwork.weight(edge)! }
                .reduce(0,+)
            let edgesAbsent = sourceEdges.whereFalse.lazy
                .compactMap(directedGraph.weight)
                .reduce(0,+)
            return edgesPresent + edgesAbsent
        }()
        return (flow: flow, network: residualNetwork.unweighted())
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
