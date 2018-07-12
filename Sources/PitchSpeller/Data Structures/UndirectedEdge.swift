//
//  UndirectedEdge.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 7/1/18.
//

public struct UndirectedEdge<Node, Num>: EdgeLike {
    
    typealias Weight = Num
    typealias Pair = UnorderedPair<Node>
    
    var weight: Weight
    let nodes: Pair
    
    init (_ source: Node, _ destination: Node, _ weight: Weight) {
        self.nodes = Pair(source, destination)
        self.weight = weight
    }
    
    init (_ nodes: Pair, _ weight: Weight) {
        self.nodes = nodes
        self.weight = weight
    }
}
