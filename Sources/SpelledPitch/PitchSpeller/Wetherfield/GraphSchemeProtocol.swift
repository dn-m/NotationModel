//
//  GraphSchemeProtocol.swift
//  SpelledPitch
//
//  Created by Benjamin Wetherfield on 03/11/2018.
//

import DataStructures

public protocol GraphSchemeProtocol {
    associatedtype Node
    associatedtype Edge: SymmetricPair where Edge.A == Node
}

extension GraphProtocol {
    func adjacencyScheme <G> (_ f: @escaping (G.Node) -> Node) -> AdjacencyCarrying<G> where
        G: GraphProtocol
    {
        return AdjacencyCarrying.build(from: self).pullback(f)
    }
}
