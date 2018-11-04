//
//  WeightedGraphProtocolExtension.swift
//  SpelledPitch
//
//  Created by Benjamin Wetherfield on 03/11/2018.
//

import DataStructures

extension WeightedGraphProtocol {
    @inlinable
    func weightScheme <G> () -> G where
        G: WeightedGraphSchemeProtocol,
        G.Edge == Edge,
        G.Weight == Weight,
        G.Node == Node
    {
        return G.init(self.weight)
    }
}
