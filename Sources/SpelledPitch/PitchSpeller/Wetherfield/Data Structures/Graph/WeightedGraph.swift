//
//  WeightedGraph.swift
//  SpelledPitch
//
//  Created by James Bean on 9/22/18.
//

/// Weighted, undirected graph.
struct WeightedGraph <Node: Hashable, Weight: Numeric>:
    WeightedGraphProtocol,
    UndirectedGraphProtocol
{
    // MARK: - Instance Properties

    /// All of the nodes contained herein.
    ///
    /// A `Node` is any `Hashable`-conforming value.
    var nodes: Set<Node>

    /// All of the edges contained herein stored with their weight.
    ///
    /// An `Edge` is an `UnorderedPair` of `Node` values, and a `Weight` is any `Numeric`-conforming
    /// value.
    var adjacents: [Edge: Weight]
}

extension WeightedGraph {

    // MARK: - Type Aliases

    /// The type of edges which connect nodes.
    typealias Edge = UnorderedPair<Node>
}

extension WeightedGraph {

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

extension WeightedGraph: Equatable { }
extension WeightedGraph: Hashable where Weight: Hashable { }
