//
//  UnweightedGraphSchemeProtocol.swift
//  SpelledPitch
//
//  Created by Benjamin Wetherfield on 03/11/2018.
//

import DataStructures

public protocol UnweightedGraphSchemeProtocol: GraphSchemeProtocol {
    var contains: (Edge) -> Bool { get }
    
    init (_ contains: @escaping (Edge) -> Bool)

    func containsEdge (from start: Node, to end: Node) -> Bool
}

extension UnweightedGraphSchemeProtocol {
    @inlinable
    func pullback <H> (_ f: @escaping (H.Node) -> Node) -> H where H: UnweightedGraphSchemeProtocol {
        return H { self.contains(Edge(f($0.a),f($0.b))) }
    }
}

extension UnweightedGraphSchemeProtocol {
    
    static func + (lhs: Self, rhs: Self) -> Self {
        return Self { edge in lhs.contains(edge) || rhs.contains(edge) }
    }
}

extension UnweightedGraphSchemeProtocol {
    
    static func * (lhs: Self, rhs: Self) -> Self {
        return Self { edge in lhs.contains(edge) && rhs.contains(edge) }
    }
}

extension UnweightedGraphSchemeProtocol where Self: DirectedGraphSchemeProtocol {
    
    static func * <Scheme> (lhs: Self, rhs: Scheme) -> Self where
        Scheme: UnweightedGraphSchemeProtocol,
        Scheme.Node == Node
    {
        return Self { edge in lhs.contains(edge) && rhs.containsEdge(from: edge.a, to: edge.b) }
    }
    
    static func * <Scheme> (lhs: Scheme, rhs: Self) -> Self where
        Scheme: UnweightedGraphSchemeProtocol,
        Scheme.Node == Node
    {
        return rhs * lhs
    }
    
    static func + (lhs: Self, rhs: Self) -> Self {
        return Self { edge in lhs.contains(edge) || rhs.contains(edge) }
    }
}

extension UnweightedGraphSchemeProtocol {
    
    static func * <Weight, Scheme> (lhs: Weight, rhs: Self) -> Scheme where
        Scheme: WeightedGraphSchemeProtocol,
        Scheme.Weight == Weight,
        Scheme.Node == Node,
        Scheme.Edge == Edge
    {
        return Scheme { edge in
            return rhs.contains(edge) ? lhs : nil
        }
    }
}

