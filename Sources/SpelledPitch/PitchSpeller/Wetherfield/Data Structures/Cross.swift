//
//  Cross.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 6/30/18.
//

/// - TODO: Move to `dn-m/Structure/DataStructures`
struct Cross <T,U>: Pair {
    
    let a: T
    let b: U
    
    init(_ a: T, _ b: U) {
        self.a = a
        self.b = b
    }
}

extension Cross: Equatable where T: Equatable, U: Equatable { }
extension Cross: Hashable where T: Hashable, U: Hashable { }
