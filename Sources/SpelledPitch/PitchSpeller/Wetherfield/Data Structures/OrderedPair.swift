//
//  OrderedPair.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 6/30/18.
//

/// Pair of values for which the order matters.
struct OrderedPair <T>: SwappablePair {

    // MARK: - Instance Properties

    let a: T
    let b: T

    // MARK: - Initializers
    
    init(_ a: T, _ b: T) {
        self.a = a
        self.b = b
    }
}

extension OrderedPair: Equatable where T: Equatable { }
extension OrderedPair: Hashable where T: Hashable { }

