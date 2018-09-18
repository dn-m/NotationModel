//
//  EdgeLike.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 7/1/18.
//

protocol EdgeLike: Weighted & NodePair {
    init(_ nodes: Pair, _ weight: Weight)
}

extension EdgeLike where Pair: SwappablePair {
    var reversed: Self { return Self(nodes.swapped, weight) }
}
