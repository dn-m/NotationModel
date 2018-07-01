//
//  DirectedEdge.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 7/1/18.
//

public struct DirectedEdge<Node, Num>: Weighted & NodePair {

    typealias Weight = Num
    typealias Pair = OrderedPair<Node>

    var weight: Weight
    let nodes: Pair
}
