//
//  WeightedDirectedGraphSchema.swift
//  SpelledPitch
//
//  Created by Benjamin Wetherfield on 03/11/2018.
//

import DataStructures

struct WeightedDirectedGraphScheme <Node,Weight>: DirectedGraphSchemeProtocol, WeightedGraphSchemeProtocol {
    
    typealias Edge = OrderedPair<Node>
    
    var weight: (Edge) -> Weight?
    
    init (_ weight: @escaping (Edge) -> Weight?) {
        self.weight = weight
    }
}
