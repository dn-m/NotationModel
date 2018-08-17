//
//  CompoundSpelledInterval.swift
//  SpelledPitch
//
//  Created by James Bean on 5/20/18.
//

import Math
import Algorithms
import Pitch

/// A `OrderedSpelledInterval` that can be more than an octave displaced.
public struct CompoundSpelledInterval {

    // MARK: - Instance Properties

    /// The base interval.
    public let interval: OrderedSpelledInterval

    /// The amount of octaves displaced.
    public let octaveDisplacement: Int
}

extension CompoundSpelledInterval {

    // MARK: - Initializers

    /// Create a `CompoundSpelledInterval` with the given `interval` and the amount of `octaves` of
    /// displacement.
    public init(_ interval: OrderedSpelledInterval, displacedBy octaves: Int = 0) {
        self.interval = interval
        self.octaveDisplacement = octaves
    }

    /// Create a `CompoundSpelledInterval` with the two given `SpelledPitch` values.
    public init(_ a: SpelledPitch, _ b: SpelledPitch) {
        let (a,b,didSwap) = swapped(a,b) { a > b }
        let steps = mod(b.spelling.letterName.steps - a.spelling.letterName.steps, 7)
        let interval = (b.pitch - a.pitch).noteNumber.value
        let neutral = neutralInterval(steps: steps)
        let difference = interval - neutral
        let normalizedDifference = mod(difference + 6, 12) - 6
        let sanitizedInterval = steps == 0 ? abs(normalizedDifference) : normalizedDifference
        let ordinal = OrderedSpelledInterval.Ordinal(steps: steps)!
        let quality = OrderedSpelledInterval.Quality(
            sanitizedIntervalClass: sanitizedInterval,
            ordinal: ordinal
        )
        let direction: OrderedSpelledInterval.Direction = didSwap ? .descending : .ascending
        let orderedInterval = OrderedSpelledInterval(direction, quality, ordinal)
        self.init(orderedInterval, displacedBy: b.octave - a.octave)
    }
}

extension CompoundSpelledInterval: Equatable { }
extension CompoundSpelledInterval: Hashable { }

func neutralInterval(steps: Int) -> Double {
    assert((0..<7).contains(steps))
    switch steps {
    case 0:
        return 0
    case 1:
        return 1.5
    case 2:
        return 3.5
    case 3:
        return 5
    case 4:
        return 7
    case 5:
        return 8.5
    case 6:
        return 10.5
    default:
        fatalError("Impossible")
    }
}
