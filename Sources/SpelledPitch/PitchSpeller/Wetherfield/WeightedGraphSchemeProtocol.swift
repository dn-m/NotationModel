//
//  WeightedGraphSchemeProtocol.swift
//  SpelledPitch
//
//  Created by Benjamin Wetherfield on 03/11/2018.
//

import DataStructures

public protocol WeightedGraphSchemeProtocol: GraphSchemeProtocol {
    associatedtype Weight
    
    var weight: (Edge) -> Weight? { get }
    
    init (_ weight: @escaping (Edge) -> Weight?)
    
    func weight (from start: Node, to end: Node) -> Weight?
}

extension WeightedGraphSchemeProtocol {
    @inlinable
    func pullback <H> (_ f: @escaping (H.Node) -> Node) -> H where
        H: WeightedGraphSchemeProtocol,
        H.Weight == Weight
    {
        return H { self.weight(from: f($0.a), to: f($0.b)) }
    }

    @inlinable
    func unweighted <H> () -> H where
        H: UnweightedGraphSchemeProtocol,
        H.Edge == Edge
    {
        return H { self.weight($0) != nil }
    }
}

extension WeightedGraphSchemeProtocol where Self: UndirectedGraphSchemeProtocol, Weight: Numeric {
    
    static func * (lhs: Self, rhs: Self) -> Self {
        return Self { edge in
            guard let lweight = lhs.weight(edge), let rweight = rhs.weight(edge) else { return nil }
            return lweight * rweight
        }
    }
    
    static func + (lhs: Self, rhs: Self) -> Self {
        return Self { edge in
            if let lweight = lhs.weight(edge) {
                if let rweight = rhs.weight(edge) { return lweight + rweight }
                return lweight
            } else {
                guard let rweight = rhs.weight(edge) else { return nil }
                return rweight
            }
        }
    }
}

extension WeightedGraphSchemeProtocol where Self: DirectedGraphSchemeProtocol, Weight: Numeric {
    
    static func * <Scheme> (lhs: Self, rhs: Scheme) -> Self where
    Scheme: WeightedGraphSchemeProtocol,
    Scheme.Node == Node,
    Scheme.Weight == Weight
    {
        return Self { edge in
            lhs.weight(edge).flatMap { lweight in
                rhs.weight(from: edge.a, to: edge.b).flatMap { rweight in
                    lweight * rweight
                }
            }
        }
    }
    
    static func * <Scheme> (lhs: Self, rhs: Scheme) -> Self where
        Scheme: UnweightedGraphSchemeProtocol,
        Scheme.Node == Node
    {
        return Self { edge in
            lhs.weight(edge).flatMap { weight in
                rhs.containsEdge(from: edge.a, to: edge.b) ? weight : nil
            }
        }
    }
    
    static func * <Scheme> (lhs: Scheme, rhs: Self) -> Self where
        Scheme: UnweightedGraphSchemeProtocol,
        Scheme.Node == Node
    {
        return rhs * lhs
    }
    
    static func + (lhs: Self, rhs: Self) -> Self {
        return Self { edge in
            if let lweight = lhs.weight(edge) {
                if let rweight = rhs.weight(edge) { return lweight + rweight }
                return lweight
            } else {
                guard let rweight = rhs.weight(edge) else { return nil }
                return rweight
            }
        }
    }
}
