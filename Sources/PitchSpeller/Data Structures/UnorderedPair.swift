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

extension UnorderedPair: Equatable where T: Equatable {

    // MARK: - Equatable

    /// - Returns: `true` if both values contained by the given `UnorderedPair` values are
    /// equivalent, regardless of order. Otherwise, `false`.
    static func == (_ lhs: UnorderedPair, _ rhs: UnorderedPair) -> Bool {
        return (lhs.a == rhs.a && lhs.b == rhs.b) || (lhs.a == rhs.b && lhs.b == rhs.a)
    }
}

extension UnorderedPair: Hashable where T: Hashable {

    // MARK: - Hashable

    /// Implements hashable requirement.
    func hash(into hasher: inout Hasher) {
        return Set([a,b]).hash(into: &hasher)
    }
}
