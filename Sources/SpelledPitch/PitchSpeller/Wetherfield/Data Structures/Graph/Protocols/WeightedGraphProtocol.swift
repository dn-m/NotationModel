//
//  WeightedGraphProtocol.swift
//  SpelledPitch
//
//  Created by James Bean on 9/22/18.
//

/// Interface for weighted graphs.
protocol WeightedGraphProtocol: GraphProtocol {
    associatedtype Weight: Numeric
    var adjacents: [Edge: Weight] { get set }
    init(_ nodes: Set<Node>, _ adjacents: [Edge: Weight])
}

extension WeightedGraphProtocol {

    func unweighted <U> () -> U where U: UnweightedGraphProtocol, U.Edge == Edge {
        return .init(nodes, Set(adjacents.keys.lazy))
    }

    func contains(_ edge: Edge) -> Bool {
        return adjacents.keys.contains(edge)
    }

    func neighbors(of source: Node, in nodes: Set<Node>? = nil) -> Set<Node> {
        return (nodes ?? self.nodes).filter { contains(Edge(source,$0)) }
    }

    mutating func removeEdge (from source: Node, to destination: Node) {
        adjacents[Edge(source, destination)] = nil
    }

    func weight(for edge: Edge) -> Weight? {
        return adjacents[edge]
    }

    func weight(from source: Node, to destination: Node) -> Weight? {
        return adjacents[Edge(source,destination)]
    }

    func edges(containing node: Node) -> Set<Edge> {
        return Set(adjacents.keys.lazy.filter { $0.contains(node) })
    }

    mutating func insertEdge(from source: Node, to destination: Node, weight: Weight) {
        nodes.insert(source)
        nodes.insert(destination)
        adjacents[Edge(source,destination)] = weight
    }

    mutating func insertEdge(_ edge: Edge, weight: Weight) {
        adjacents[edge] = weight
    }

    mutating func updateEdge(_ edge: Edge, by transform: (Weight) -> Weight) {
        guard let weight = weight(for: edge) else { return }
        insertEdge(edge, weight: transform(weight))
    }

    mutating func updateEdge(
        from source: Node,
        to destination: Node,
        by transform: (Weight) -> Weight
    )
    {
        updateEdge(Edge(source,destination), by: transform)
    }
}
