//
//  SpelledPitchConvertingIntervalOrdinal.swift
//  SpelledPitch
//
//  Created by James Bean on 10/14/18.
//

import Math

/// Interface from converting intervals between `SpelledPitch` into `IntervalOrdinal` types.
protocol SpelledPitchConvertingIntervalOrdinal {

    /// The distance between the given `steps` and the platonic ideal for this
    /// `IntervalOrdinal` value.
    static func platonicInterval(steps: Int) -> Double

    // MARK: - Instance Properties

    /// The distance from the platonic ideal interval where the interval quality becomes diminished
    /// or augmented.
    var platonicThreshold: Double { get }
}

extension SpelledPitchConvertingIntervalOrdinal {

    // MARK: - Type Methods

    /// - Returns: The distance of the given `interval` to the `platonicInterval` from the given
    /// `steps`.
    static func platonicDistance(from interval: Double, to steps: Int) -> Double {
        let ideal = platonicInterval(steps: steps)
        let difference = interval - ideal
        let normalized = mod(difference + 6, 12) - 6
        return steps == 0 ? abs(normalized) : normalized
    }
}
