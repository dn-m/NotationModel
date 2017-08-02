//
//  NamedIntervalOrdinal.swift
//  SpelledPitch
//
//  Created by James Bean on 1/8/17.
//
//

import Structure

/// Interface for ordinals of `NamedInterval`-conforming types.
public protocol NamedIntervalOrdinal: InvertibleOptionSet {

    /// Set of `perfect` interval ordinals
    static var perfects: Self { get }

    /// Set of `imperfect` interval ordinals
    static var imperfects: Self { get }

    /// Interval with zero distance.
    static var unison: Self { get }

    /// Create an `NamedIntervalOrdinal`-conforming type with a given `rawValue`.
    init(rawValue: Int)

    /// Create a `NamedIntervalOrdinal`-conforming type with a given amount of `steps` between
    /// the `letterName` properties of two `Spelled` types.
    init(steps: Int)

    // Whether or not this ordinal belongs to the `perfects` class.
    var isPerfect: Bool { get }

    // Whether or not this ordinal belongs to the `imperfects` class.
    var isImperfect: Bool { get }
}

extension NamedIntervalOrdinal {

    /// Create a `NamedIntervalOrdinal`-conforming type with a given amount of `steps` between
    /// the `letterName` properties of two `Spelled` types.
    public init(steps: Int) {
        self.init(rawValue: 1 << steps)
    }
}
