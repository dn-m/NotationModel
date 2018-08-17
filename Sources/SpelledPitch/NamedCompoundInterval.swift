//
//  CompoundSpelledInterval.swift
//  SpelledPitch
//
//  Created by James Bean on 5/20/18.
//

/// A `OrderedSpelledInterval` that can be more than an octave displaced.
public struct CompoundSpelledInterval {

    // MARK: - Instance Properties

    /// The base interval.
    public let interval: OrderedSpelledInterval

    /// The amount of octaves displaced.
    public let octaveDisplacement: Int

    // MARK: - Initializers

    /// Create a `CompoundSpelledInterval` with the given `interval` and the amount of `octaves` of
    /// displacement.
    public init(_ interval: OrderedSpelledInterval, displacedBy octaves: Int) {
        self.interval = interval
        self.octaveDisplacement = octaves
    }
}
