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
