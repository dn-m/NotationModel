//
//  DirectedGraphProtocol.swift
//  SpelledPitch
//
//  Created by Benjamin Wetherfield on 03/11/2018.
//

import DataStructures

struct DirectedGraphScheme <Node>: DirectedGraphSchemeProtocol, UnweightedGraphSchemeProtocol {
    
    typealias Edge = OrderedPair<Node>
    
    var contains: (Edge) -> Bool
    
    init (_ contains: @escaping (Edge) -> Bool) {
        self.contains = contains
    }
    
    func containsEdge(from start: Node, to end: Node) -> Bool {
        return contains(Edge(start, end))
    }
}
