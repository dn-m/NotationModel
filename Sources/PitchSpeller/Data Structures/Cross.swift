//
//  Cross.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 6/30/18.
//

struct Cross<T,U>: Pairable {
    
    typealias A = T
    typealias B = U
    
    let a: T
    let b: U
    
    init(_ a: A, _ b: B) {
        self.a = a
        self.b = b
    }
    
    init(_ pair: (A, B)) {
        self.a = pair.0
        self.b = pair.1
    }
}

extension Cross: Equatable where T: Equatable, U: Equatable { }
extension Cross: Hashable where T: Hashable, U: Hashable { }
