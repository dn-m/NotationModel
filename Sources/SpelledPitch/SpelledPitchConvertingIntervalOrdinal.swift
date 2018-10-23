//
//  SpelledPitchConvertingIntervalOrdinal.swift
//  SpelledPitch
//
//  Created by James Bean on 10/14/18.
//

import Math

/// Interface from converting intervals between `SpelledPitch` into `IntervalOrdinal` types.
protocol SpelledPitchConvertingIntervalOrdinal {

    // MARK: - Instance Properties

    /// The distance from the platonic ideal interval where the interval quality becomes diminished
    /// or augmented.
    var platonicThreshold: Double { get }
}

extension SpelledPitchConvertingIntervalOrdinal {

    // MARK: - Type Methods

    /// - Returns: The distance of the given `interval` to the `idealSemitoneInterval` from the given
    /// `steps`.
    static func platonicDistance(from interval: Double, to steps: Int) -> Double {
        let ideal = idealSemitoneInterval(steps: steps)
        let difference = interval - ideal
        let normalized = mod(difference + 6, 12) - 6
        let result = steps == 0 ? abs(normalized) : normalized
        return result
    }
}
