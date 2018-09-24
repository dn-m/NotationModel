//
//  Graph.swift
//  SpelledPitch
//
//  Created by James Bean on 9/22/18.
//

/// Unweighted, undirected graph.
struct Graph <Node: Hashable>: UnweightedGraphProtocol, UndirectedGraphProtocol {

    // MARK: - Instance Properties

    /// All of the nodes contained herein.
    ///
    /// A `Node` is any `Hashable`-conforming value.
    var nodes: Set<Node>

    /// All of the edges contained herein.
    ///
    /// An `Edge` is an `UnorderedPair` of `Node` values.
    var edges: Set<Edge>
}

extension Graph {

    // MARK: - Initializers

    /// Creates a `Graph` with the given set of nodes, with no edges between the nodes.
    init(_ nodes: Set<Node> = []) {
        self.nodes = nodes
        self.edges = []
    }

    /// Creates a `Graph` with the given set of nodes and the given set of edges connecting the
    /// nodes.
    init(_ nodes: Set<Node> = [], _ edges: Set<Edge> = []) {
        self.init(nodes)
        self.edges = edges
    }
}

extension Graph {

    // MARK: - Type Aliases

    /// The type of edges which connect nodes.
    typealias Edge = UnorderedPair<Node>
}

extension Graph: Equatable { }
extension Graph: Hashable { }
