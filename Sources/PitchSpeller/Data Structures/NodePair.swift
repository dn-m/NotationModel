//
//  NodePair.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 7/1/18.
//

protocol NodePair {
    
    // MARK: - Associated Types
    
    associatedtype Pair: Symmetric
    
    // MARK: - Instance Properties
    
    var nodes: Pair { get }
}
