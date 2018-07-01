//
//  DirectedEdge.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 7/1/18.
//

public struct DirectedEdge<Node, Num>: EdgeLike {

    typealias Weight = Num
    typealias Pair = OrderedPair<Node>

    var weight: Weight
    let nodes: Pair
    
    init (_ source: Node, _ destination: Node, _ weight: Weight) {
        self.nodes = Pair(source, destination)
        self.weight = weight
    }
    
    init (_ nodepair: Pair, _ weight: Weight) {
        self.nodes = nodepair
        self.weight = weight
    }
}
