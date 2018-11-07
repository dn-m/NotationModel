//
//  UndirectedGraphSchemeProtocol.swift
//  SpelledPitch
//
//  Created by Benjamin Wetherfield on 03/11/2018.
//

import DataStructures

public protocol UndirectedGraphSchemeProtocol: GraphSchemeProtocol where Edge == UnorderedPair<Node> { }

extension UndirectedGraphSchemeProtocol where Self: WeightedGraphSchemeProtocol {
    
    func directed <D> () -> D where
        D: DirectedGraphSchemeProtocol & WeightedGraphSchemeProtocol,
        D.Weight == Weight,
        D.Node == Node
    {
        return .init { edge in self.weight(from: edge.a, to: edge.b) }
    }
}

extension UndirectedGraphSchemeProtocol where Self: UnweightedGraphSchemeProtocol {
    
    func directed <D> () -> D where
        D: DirectedGraphSchemeProtocol & UnweightedGraphSchemeProtocol,
        D.Node == Node
    {
        return .init { edge in self.contains(from: edge.a, to: edge.b) }
    }
}
