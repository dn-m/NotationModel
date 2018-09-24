//
//  DirectedGraph.swift
//  SpelledPitch
//
//  Created by James Bean on 9/22/18.
//

/// Unweighted, directed graph.
struct DirectedGraph <Node: Hashable>: UnweightedGraphProtocol, DirectedGraphProtocol {

    // MARK: - Instance Properties

    /// All of the nodes contained herein.
    ///
    /// A `Node` is any `Hashable`-conforming value.
    var nodes: Set<Node>

    /// All of the edges contained herein.
    ///
    /// An `Edge` is an `OrderedPair` of `Node` values.
    var edges: Set<Edge>
}

extension DirectedGraph {

    // MARK: - Type Aliases

    /// The type of edges which connect nodes.
    typealias Edge = OrderedPair<Node>
}

extension DirectedGraph {

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

extension DirectedGraph {

    // MARK: - Instance Methods

    /// - Returns: A set of edges which emanate from the given `source` node.
    func edges(from source: Node) -> Set<Edge> {
        return edges.filter { $0.a == source }
    }
}

extension DirectedGraph: Equatable { }
extension DirectedGraph: Hashable { }
