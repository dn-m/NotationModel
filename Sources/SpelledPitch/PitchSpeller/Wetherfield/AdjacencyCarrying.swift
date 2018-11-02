//
//  AdjacencyCarrying.swift
//  SpelledPitch
//
//  Created by Benjamin Wetherfield on 30/10/2018.
//

import DataStructures

struct AdjacencyCarrying <G: GraphProtocol> {
    let contains: (G.Edge) -> Bool
    
    private init (contains: @escaping (G.Edge) -> Bool) {
        self.contains = contains
    }
    
    func contains (from start: G.Node, to end: G.Node) -> Bool {
        return contains(G.Edge(start, end))
    }
    
    func pullback <H: GraphProtocol> (_ f: @escaping (H.Node) -> G.Node) -> AdjacencyCarrying<H> {
        return AdjacencyCarrying<H> { e in self.contains(G.Edge(f(e.a), f(e.b))) }
    }
    
    static func build (from g: G) -> AdjacencyCarrying {
        return AdjacencyCarrying(contains: g.contains)
    }
}

extension AdjacencyCarrying {
    
    static func * <H> (lhs: AdjacencyCarrying, rhs: AdjacencyCarrying<H>) -> AdjacencyCarrying
        where
        H: UndirectedGraphProtocol,
        H.Node == G.Node
    {
        return AdjacencyCarrying { e in lhs.contains(e) && rhs.contains(H.Edge(e.a, e.b)) }
    }
    
    static func + (lhs: AdjacencyCarrying, rhs: AdjacencyCarrying) -> AdjacencyCarrying {
        return AdjacencyCarrying { e in lhs.contains(e) || rhs.contains(e) }
    }
}

extension AdjacencyCarrying where G: DirectedGraphProtocol {
    
    static func * <H> (lhs: AdjacencyCarrying, rhs: AdjacencyCarrying<H>) -> AdjacencyCarrying
        where
        H: DirectedGraphProtocol,
        H.Node == G.Node
    {
        return AdjacencyCarrying { e in lhs.contains(e) && rhs.contains(H.Edge(e.a, e.b)) }
    }
}
