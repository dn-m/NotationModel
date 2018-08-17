//
//  NamedCompoundInterval.swift
//  SpelledPitch
//
//  Created by James Bean on 5/20/18.
//

/// A `NamedOrderedInterval` that can be more than an octave displaced.
public struct NamedCompoundInterval {

    // MARK: - Instance Properties

    /// The base interval.
    public let interval: NamedOrderedInterval

    /// The amount of octaves displaced.
    public let octaveDisplacement: Int

    // MARK: - Initializers

    /// Create a `NamedCompoundInterval` with the given `interval` and the amount of `octaves` of
    /// displacement.
    public init(_ interval: NamedOrderedInterval, displacedBy octaves: Int) {
        self.interval = interval
        self.octaveDisplacement = octaves
    }
}
