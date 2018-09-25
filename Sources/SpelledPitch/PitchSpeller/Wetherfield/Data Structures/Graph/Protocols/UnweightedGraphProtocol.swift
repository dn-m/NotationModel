//
//  UnweightedGraphProtocol.swift
//  SpelledPitch
//
//  Created by James Bean on 9/22/18.
//

/// Interface for unweighted graphs.
protocol UnweightedGraphProtocol: GraphProtocol {

    // MARK: - Instance Properties

    /// All of the edges contained herein.
    var edges: Set<Edge> { get set }

    // MARK: - Initializers

    /// Creates an `UnweightedGraphProtocol`-conforming type value with the given set of `nodes`
    /// and the given set of `edges`.
    init(_ nodes: Set<Node>, _ edges: Set<Edge>)
}

extension UnweightedGraphProtocol {

    /// Creates an `UnweightedGraphProtocol`-conforming type value which is composed a path of
    /// nodes.
    init <S> (path: S) where S: Sequence, S.Element == Node {
        self.init(Set(path), Set(path.pairs.map(Edge.init)))
    }
}

extension UnweightedGraphProtocol {

    // MARK: - Querying

    /// - Returns: `true` if this graph contains the given `edge`. Otherwise, `false`.
    func contains(_ edge: Edge) -> Bool {
        return edges.contains(edge)
    }

    /// - Returns: A set of edges containing the given `node`.
    func edges(containing node: Node) -> Set<Edge> {
        return edges.filter { $0.a == node || $0.b == node }
    }
}

extension UnweightedGraphProtocol {

    // MARK: - Modifying

    /// Inserts an edge between the given `source` and `destination` nodes.
    ///
    /// If the `source` or `destination` nodes are not yet contained herein, they are inserted.
    mutating func insertEdge(from source: Node, to destination: Node) {
        insert(source)
        insert(destination)
        edges.insert(Edge(source,destination))
    }

    /// Removes the edge between the given `source` and `destination` nodes.
    mutating func removeEdge(from source: Node, to destination: Node) {
        edges.remove(Edge(source,destination))
    }
}

extension UnweightedGraphProtocol {

    static func + (lhs: Self, rhs: Self) -> Self {
        return .init(lhs.nodes.union(rhs.nodes), lhs.edges.union(rhs.edges))
    }
}
