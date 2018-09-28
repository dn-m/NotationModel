//
//  UnorderedPair.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 6/30/18.
//

/// - TODO: Move to `dn-m/Structure/DataStructures`
struct UnorderedPair <T>: SymmetricPair {
    
    typealias A = T
    
    let a: T
    let b: T
    
    init(_ a: T, _ b: T) {
        self.a = a
        self.b = b
    }
}

extension UnorderedPair where T: Equatable {

    func other(_ value: T) -> T? {
        return a == value ? b : b == value ? a : nil
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
