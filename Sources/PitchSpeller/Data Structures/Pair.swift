//
//  Pairable.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 6/30/18.
//

protocol Pairable {
    
    // MARK: - Associated Types
    
    associatedtype A
    associatedtype B
    
    // MARK: - Instance Properties
    
    var a: A { get }
    var b: B { get }
    
    // MARK: - Initializers
    
    init(_ a: A, _ b: B)
}
