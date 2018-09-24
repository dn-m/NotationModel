//
//  WeightedDirectedGraph.swift
//  SpelledPitch
//
//  Created by James Bean on 9/22/18.
//

/// Weighted, directed graph.
struct WeightedDirectedGraph <Node: Hashable, Weight: Numeric>:
    WeightedGraphProtocol,
    DirectedGraphProtocol
{
    // MARK: - Instance Properties

    var nodes: Set<Node>
    var adjacents: [Edge: Weight]
}

extension WeightedDirectedGraph {

    // MARK: - Type Aliases

    /// The type of edges which connect nodes.
    typealias Edge = OrderedPair<Node>
}

extension WeightedDirectedGraph {

    // MARK: - Initializers

    /// Creates a `Graph` with the given set of nodes, with no edges between the nodes.
    init(_ nodes: Set<Node> = []) {
        self.nodes = nodes
        self.adjacents = [:]
    }

    /// Creates a `Graph` with the given set of nodes and the given dictionary of weights
    /// stored by the applicable edge.
    init(_ nodes: Set<Node> = [], _ adjacents: [Edge: Weight] = [:]) {
        self.init(nodes)
        self.adjacents = adjacents
    }
}

extension WeightedDirectedGraph {

    // MARK: - Instance Methods

    /// - Returns: A set of edges which emanate from the given `source` node.
    func edges(from source: Node) -> Set<Edge> {
        return Set(adjacents.keys.lazy.filter { $0.a == source })
    }
}

extension WeightedDirectedGraph: Equatable { }
extension WeightedDirectedGraph: Hashable where Weight: Hashable { }
