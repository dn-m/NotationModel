//
//  UnweightedGraphProtocol.swift
//  SpelledPitch
//
//  Created by James Bean on 9/22/18.
//

protocol UnweightedGraphProtocol: GraphProtocol {
    var edges: Set<Edge> { get set }
    init(_ nodes: Set<Node>, _ edges: Set<Edge>)
}

extension UnweightedGraphProtocol {

    func contains(_ edge: Edge) -> Bool {
        return edges.contains(edge)
    }

    func neighbors(of source: Node, in nodes: Set<Node>? = nil) -> Set<Node> {
        return (nodes ?? self.nodes).filter { destination in
            edges.contains(Edge(source,destination))
        }
    }

    mutating func insertEdge(from source: Node, to destination: Node) {
        edges.insert(Edge(source,destination))
    }

    mutating func removeEdge (from source: Node, to destination: Node) {
        edges.remove(Edge(source,destination))
    }
}
