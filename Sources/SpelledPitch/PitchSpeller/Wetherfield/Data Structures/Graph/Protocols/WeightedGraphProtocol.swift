//
//  WeightedGraphProtocol.swift
//  SpelledPitch
//
//  Created by James Bean on 9/22/18.
//

/// Interface for weighted graphs.
protocol WeightedGraphProtocol: GraphProtocol {

    // MARK: - Associated Type

    /// The type of the weight of an `Edge`.
    associatedtype Weight: Numeric

    // MARK: - Instance Properties

    /// The storage of weights by the applicable edge.
    var adjacents: [Edge: Weight] { get set }

    // MARK: - Initializers

    /// Creates a `WeightedGraphProtocol`-conforming type value with the given set of `nodes` and
    /// the given dictionary of weights stored by the applicable edge.
    init(_ nodes: Set<Node>, _ adjacents: [Edge: Weight])
}

extension WeightedGraphProtocol {

    // MARK: - Transforming into unweighted graphs

    /// - Returns: An unweighted version of this `WeightedGraphProtocol`-conforming type value.
    func unweighted <U> () -> U where U: UnweightedGraphProtocol, U.Edge == Edge {
        return .init(nodes, Set(adjacents.keys.lazy))
    }
}

extension WeightedGraphProtocol {

    // MARK: - Querying

    /// - Returns: `true` if this graph contains the given `edge`. Otherwise, `false`.
    func contains(_ edge: Edge) -> Bool {
        return adjacents.keys.contains(edge)
    }
    
    /// - Returns: The weight for the edge connecting the given `source` and `destination` nodes,
    /// if the given `edge` is contained herein. Otherwise, `nil`.
    func weight(from source: Node, to destination: Node) -> Weight? {
        return weight(Edge(source,destination))
    }

    /// - Returns: The weight for the given `edge`, if the given `edge` is contained herein.
    /// Otherwise, `nil`.
    func weight(_ edge: Edge) -> Weight? {
        return adjacents[edge]
    }

    /// - Returns: A set of edges containing the given `node`.
    func edges(containing node: Node) -> Set<Edge> {
        return Set(adjacents.keys.lazy.filter { $0.contains(node) })
    }
}

extension WeightedGraphProtocol {

    // MARK: - Modifying

    /// Inserts an edge between the given `source` and `destination` nodes, with the given `weight`.
    ///
    /// If the `source` or `destination` nodes are not yet contained herein, they are inserted.
    mutating func insertEdge(from source: Node, to destination: Node, weight: Weight) {
        nodes.insert(source)
        nodes.insert(destination)
        adjacents[Edge(source,destination)] = weight
    }

    /// Removes the edge between the given `source` and `destination` nodes.
    mutating func removeEdge (from source: Node, to destination: Node) {
        adjacents[Edge(source, destination)] = nil
    }

    /// Inserts the given `edge` with the given `weight`.
    mutating func insertEdge(_ edge: Edge, weight: Weight) {
        adjacents[edge] = weight
    }

    /// Updates the weight of the edge between the given `source` and `destination` nodes by the
    /// given `transform`.
    mutating func updateEdge(
        from source: Node,
        to destination: Node,
        by transform: (Weight) -> Weight
    )
    {
        updateEdge(Edge(source,destination), by: transform)
    }

    /// Updates the weight of the given `edge` by the given `transform`.
    mutating func updateEdge(_ edge: Edge, by transform: (Weight) -> Weight) {
        guard let weight = weight(edge) else { return }
        insertEdge(edge, weight: transform(weight))
    }
}
