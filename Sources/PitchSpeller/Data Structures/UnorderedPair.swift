//
//  UnorderedPair.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 6/30/18.
//

struct UnorderedPair<T>: Symmetric {
    
    typealias A = T
    
    let a: T
    let b: T
    
    init(_ pair: (T, T)) {
        self.a = pair.0
        self.b = pair.1
    }
    
    init(_ a: T, _ b: T) {
        self.a = a
        self.b = b
    }
}
