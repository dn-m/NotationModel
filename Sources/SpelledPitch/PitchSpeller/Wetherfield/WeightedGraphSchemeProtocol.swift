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
}

extension WeightedGraphSchemeProtocol {
    @inlinable
    func pullback <H> (_ f: @escaping (H.Node) -> Node) -> H where
        H: WeightedGraphSchemeProtocol,
        H.Weight == Weight
    {
        return H.init { self.weight(Edge(f($0.a),f($0.b))) }
    }
}

extension WeightedGraphSchemeProtocol {
    @inlinable
    func unweighted <H> () -> H where
        H: UnweightedGraphSchemeProtocol,
        H.Edge == Edge
    {
        return H.init { self.weight($0) != nil }
    }
}
