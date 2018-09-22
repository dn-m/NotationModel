//
//  WeightedGraphProtocol.swift
//  SpelledPitch
//
//  Created by James Bean on 9/22/18.
//

protocol WeightedGraphProtocol: GraphProtocol {
    associatedtype Weight: Numeric
    var adjacents: [Edge: Weight] { get set }
    init(_ nodes: Set<Node>, _ adjacents: [Edge: Weight])
}

extension WeightedGraphProtocol {

    func unweighted <U> () -> U where U: UnweightedGraphProtocol, U.Edge == Edge {
        return .init(nodes, Set(adjacents.keys))
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

    mutating func insertEdge(from source: Node, to destination: Node, weight: Weight) {
        adjacents[Edge(source,destination)] = weight
    }
    
    mutating func insertEdge(_ edge: Edge, weight: Weight) {
        adjacents[edge] = weight
    }

    mutating func updateEdge(_ edge: Edge, by transform: (Weight) -> Weight) {
        guard let weight = weight(for: edge) else { return }
        insertEdge(edge, weight: transform(weight))
    }
}
