//
//  SpelledIntervalOrdinal.swift
//  SpelledPitch
//
//  Created by James Bean on 5/20/18.
//

import Algebra
import Math

/// Interface for `NamedIntervalOrdinal`-like values.
protocol SpelledIntervalOrdinal {

    // MARK: - Type Properties

    /// The distance between the given `steps` and the platonic ideal for this
    /// `SpelledIntervalOrdinal` value.
    static func platonicInterval(steps: Int) -> Double

    // MARK: - Instance Properties

    /// The distance from the platonic ideal interval where the spelled interval quality becomes
    /// diminished or augmented.
    var platonicThreshold: Double { get }

    // MARK: - Initializers

    /// Creates a `SpelledIntervalOrdinal` with the given amount of `steps` (i.e., the distance
    /// between the `LetterName` attributes of `Pitch.Spelling` values).
    init?(steps: Int)
}

extension SpelledIntervalOrdinal {

    // MARK: - Type Methods

    /// - Returns: The distance of the given `interval` to the `platonicInterval` from the given
    /// `steps`.
    static func platonicDistance(from interval: Double, to steps: Int) -> Double {
        let ideal = Self.platonicInterval(steps: steps)
        let difference = interval - ideal
        let normalized = mod(difference + 6, 12) - 6
        return steps == 0 ? abs(normalized) : normalized
    }
}
