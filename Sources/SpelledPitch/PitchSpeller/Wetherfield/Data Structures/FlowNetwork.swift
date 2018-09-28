//
//  FlowNetwork.swift
//  PitchSpeller
//
//  Created by James Bean on 5/24/18.
//

/// Directed _Graph with several properties:
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
        self.source = source
        self.sink = sink
    }
}

extension FlowNetwork {

    // MARK: - Computed Properties

    /// - Returns: All of the `Node` values contained herein which are neither the `source` nor
    /// the `sink`.
    public var internalNodes: [Node] {
        return directedGraph.nodes.filter { $0 != source && $0 != sink }
    }

    /// - Returns: (0) The maximum flow of the network and (1) the residual network produced after
    /// pushing all possible flow from source to sink (while satisfying flow constraints) - with
    /// saturated edges flipped and all weights removed.
    var solvedForMaximumFlow: (flow: Weight, network: DirectedGraph<Node>) {

        var residualNetwork = directedGraph

        func findAugmentingPath () -> Bool {
            guard let path = residualNetwork.shortestUnweightedPath(from: source, to: sink) else {
                return false
            }
            pushFlow(through: path)
            return true
        }

        func pushFlow (through path: [Node]) {
            let edges = path.pairs.map(OrderedPair.init)
            let minimumEdge = edges.compactMap(residualNetwork.weight).min()!

            edges.forEach { edge in

                // reduce flow by minimum flow
                residualNetwork.updateEdge(edge, by: { capacity in capacity - minimumEdge })

                // remove edges with a flow of 0
                if residualNetwork.weight(edge)! == 0 {
                    residualNetwork.removeEdge(from: edge.a, to: edge.b)
                }

                // if flipped edge already exists, increase flow
                if residualNetwork.contains(edge.swapped) {
                    residualNetwork.updateEdge(edge.swapped, by: { capacity in capacity + minimumEdge })
                // otherwise, insert back edge
                } else {
                    residualNetwork.insertEdge(edge.swapped, weight: minimumEdge)
                }
            }
        }

        func computeFlow () -> Weight {
            let sourceEdges = directedGraph.neighbors(of: source).lazy
                .map { OrderedPair(self.source, $0) }
                .partition(residualNetwork.contains)
            let edgesPresent = sourceEdges.whereTrue.lazy
                .map { self.directedGraph.weight($0)! - residualNetwork.weight($0)! }
                .reduce(0,+)
            let edgesAbsent = sourceEdges.whereFalse.lazy
                .compactMap(directedGraph.weight)
                .reduce(0,+)
            return edgesPresent + edgesAbsent
        }

        while let augmentingPath = residualNetwork.shortestUnweightedPath(from: source, to: sink) {
            pushFlow(through: augmentingPath)
        }

        //while findAugmentingPath() { continue }
        let flow = computeFlow()
        let unweighted: DirectedGraph = residualNetwork.unweighted()
        return (flow: flow, network: unweighted)
    }

    /// - Returns: A minimum cut with nodes included on the `sink` side in case of a
    /// tiebreak (in- and out- edges saturated).
    //
    // - FIXME: Don't compute `solvedForMaximumFlow` twice (compute `solvedForMaximumFlow` once
    // here).
    public var minimumCut: (Set<Node>, Set<Node>) {
        return (sourceSideNodes, notSourceSideNodes)
    }

    /// - Returns: Nodes in residual network reachable from the `source`
    //
    // - FIXME: Don't compute `solvedForMaximumFlow` twice
    var sourceSideNodes: Set<Node> {
        return Set(solvedForMaximumFlow.network.breadthFirstSearch(from: source))
    }

    /// - Returns: Nodes in residual network *not* reachable from the `source`
    //
    // - FIXME: Don't compute `solvedForMaximumFlow` twice
    var notSourceSideNodes: Set<Node> {
        return solvedForMaximumFlow.network.nodes.subtracting(sourceSideNodes)
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
