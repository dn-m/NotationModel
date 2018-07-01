//
//  NodePair.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 7/1/18.
//

protocol NodePair {
    associatedtype Pair: Symmetric
    var nodes: Pair { get }
    var source: Pair.A { get }
    var destination: Pair.A { get }
}

extension NodePair {
    var source: Pair.A { return nodes.a }
    var destination: Pair.A { return nodes.b }
}
