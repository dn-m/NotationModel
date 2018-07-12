//
//  DirectedEdge.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 7/1/18.
//

public struct DirectedEdge <Node,Weight>: EdgeLike {

    // MARK: - Associated Types

    typealias Pair = OrderedPair<Node>

    // MARK: - Instance Properties

    var weight: Weight
    let nodes: Pair

    // MARK: - Initializers
    
    init (_ source: Node, _ destination: Node, _ weight: Weight) {
        self.nodes = Pair(source, destination)
        self.weight = weight
    }
    
    init (_ nodes: Pair, _ weight: Weight) {
        self.nodes = nodes
        self.weight = weight
    }
}
