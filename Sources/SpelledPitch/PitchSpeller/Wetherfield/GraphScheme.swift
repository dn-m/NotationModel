//
//  GraphScheme.swift
//  SpelledPitch
//
//  Created by Benjamin Wetherfield on 03/11/2018.
//

import DataStructures

struct GraphScheme <Node>: UndirectedGraphSchemeProtocol, UnweightedGraphSchemeProtocol {
    
    typealias Edge = UnorderedPair<Node>
    
    var contains: (Edge) -> Bool
    
    init (_ contains: @escaping (Edge) -> Bool) {
        self.contains = contains
    }

    func containsEdge(from start: Node, to end: Node) -> Bool {
        return contains(Edge(start, end))
    }
}

extension GraphScheme {
    
    var directed: DirectedGraphScheme<Node> {
        return .init { edge in self.containsEdge(from: edge.a, to: edge.b) }
    }
}
