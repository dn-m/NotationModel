//
//  NamedIntervalOrdinal.swift
//  SpelledPitch
//
//  Created by James Bean on 1/8/17.
//
//

import DataStructures

/// Interface for ordinals of `NamedInterval`-conforming types.
public protocol NamedIntervalOrdinal: Hashable, InvertibleEnum {

    /// Set of `perfect` interval ordinals
    static var perfects: Set<Self> { get }

    /// Set of `imperfect` interval ordinals
    static var imperfects: Set<Self> { get }

    /// Create a `NamedIntervalOrdinal`-conforming type with a given amount of `steps` between
    /// the `letterName` properties of two `Spelled` types.
    init?(steps: Int)
}

extension NamedIntervalOrdinal {

    /// Whether or not this ordinal belongs to the `perfects` class.
    public var isPerfect: Bool {
        return Self.perfects.contains(self)
    }

    /// Whether or not this ordinal belongs to the `imperfects` class.
    public var isImperfect: Bool {
        return Self.imperfects.contains(self)
    }
}

extension NamedIntervalOrdinal {

    /// Inversion of `self`.
    public var inverse: Self {
        let index = Self.allCases.index(of: self)!
        // .unison.inverse should be equal to .unison (do not consider this index)
        guard index > 0 else { return self }
        let inverseIndex = Self.allCases.count - index
        return Self.allCases[inverseIndex]
    }
}
