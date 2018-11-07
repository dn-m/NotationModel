//
//  WeightedGraphScheme.swift
//  SpelledPitch
//
//  Created by Benjamin Wetherfield on 03/11/2018.
//

import DataStructures

struct WeightedGraphScheme <Node,Weight>: UndirectedGraphSchemeProtocol, WeightedGraphSchemeProtocol {
    
    typealias Edge = UnorderedPair<Node>
    
    var weight: (Edge) -> Weight?
    
    init (_ weight: @escaping (Edge) -> Weight?) {
        self.weight = weight
    }
    
    func weight(from start: Node, to end: Node) -> Weight? {
        return weight(Edge(start, end))
    }
}

extension WeightedGraphScheme {
    
    var directed: WeightedDirectedGraphScheme<Node,Weight> {
        return .init { edge in self.weight(from: edge.a, to: edge.b) }
    }
}
