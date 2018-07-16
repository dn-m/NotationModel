//
//  NodePair.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 7/1/18.
//

protocol NodePair {
    
    // MARK: - Associated Types
    
    associatedtype Pair: SymmetricPair
    
    // MARK: - Typealiases
    
    typealias Node = Pair.A
    
    // MARK: - Instance Properties
    
    var nodes: Pair { get }
}
