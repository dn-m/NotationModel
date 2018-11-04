//
//  WeightCarrying.swift
//  SpelledPitch
//
//  Created by Benjamin Wetherfield on 30/10/2018.
//

import DataStructures

struct WeightCarrying<G: WeightedGraphProtocol> {
    let weight: (G.Edge) -> G.Weight?
    
    private init (weight: @escaping (G.Edge) -> G.Weight?) {
        self.weight = weight
    }
    
    func weight (from start: G.Node, to end: G.Node) -> G.Weight? {
        return weight(G.Edge(start, end))
    }

    func pullback <H: WeightedGraphProtocol> (_ f: @escaping (H.Node) -> G.Node) -> WeightCarrying<H>
        where H.Weight == G.Weight
    {
        return WeightCarrying<H> { e in self.weight(G.Edge(f(e.a), f(e.b))) }
    }
    
    static func build (from g: G) -> WeightCarrying {
        return WeightCarrying(weight: g.weight)
    }
    
    static func build (_ weight: @escaping (G.Edge) -> G.Weight?) -> WeightCarrying {
        return WeightCarrying(weight: weight)
    }
}

extension WeightCarrying {
    
    static func * <H> (lhs: WeightCarrying, rhs: WeightCarrying<H>) -> WeightCarrying
        where
        H: UndirectedGraphProtocol,
        H.Node == G.Node,
        H.Weight == G.Weight
    {
        return WeightCarrying { e in
            guard let lweight = lhs.weight(e), let rweight = rhs.weight(H.Edge(e.a, e.b))
                else { return nil }
            return lweight * rweight
        }
    }
    
    static func * <H> (lhs: WeightCarrying, rhs: AdjacencyCarrying<H>) -> WeightCarrying
        where
        H: UndirectedGraphProtocol,
        H.Node == G.Node
    {
        return WeightCarrying { e in rhs.contains(H.Edge(e.a,e.b)) ? lhs.weight(e) : nil }
    }
    
    static func * <H> (lhs: AdjacencyCarrying<H>, rhs: WeightCarrying) -> WeightCarrying
        where
        H: UndirectedGraphProtocol,
        H.Node == G.Node
    {
        return WeightCarrying { e in lhs.contains(H.Edge(e.a,e.b)) ? rhs.weight(e) : nil }
    }
    
    static func + (lhs: WeightCarrying, rhs: WeightCarrying) -> WeightCarrying {
        return WeightCarrying { e in
            guard let lweight = lhs.weight(e) else { return rhs.weight(e) }
            guard let rweight = rhs.weight(e) else { return lhs.weight(e) }
            return lweight + rweight
        }
    }
}

extension WeightCarrying where G: DirectedGraphProtocol {
    
    static func * <H> (lhs: WeightCarrying, rhs: WeightCarrying<H>) -> WeightCarrying
        where
        H: DirectedGraphProtocol,
        H.Node == G.Node,
        H.Weight == G.Weight
    {
        return WeightCarrying { e in
            guard let lweight = lhs.weight(e), let rweight = rhs.weight(H.Edge(e.a, e.b))
                else { return nil }
            return lweight * rweight
        }
    }
    
    static func * <H> (lhs: WeightCarrying, rhs: AdjacencyCarrying<H>) -> WeightCarrying
        where
        H: DirectedGraphProtocol,
        H.Node == G.Node
    {
        return WeightCarrying { e in rhs.contains(H.Edge(e.a,e.b)) ? lhs.weight(e) : nil }
    }
    
    static func * <H> (lhs: AdjacencyCarrying<H>, rhs: WeightCarrying) -> WeightCarrying
        where
        H: DirectedGraphProtocol,
        H.Node == G.Node
    {
        return WeightCarrying { e in lhs.contains(H.Edge(e.a,e.b)) ? rhs.weight(e) : nil }
    }
}

