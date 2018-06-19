//
//  RhythmBeamer.swift
//  RhythmBeamer
//
//  Created by James Bean on 6/18/18.
//

import func Math.countTrailingZeros
import MetricalDuration
import Rhythm
import SpelledRhythm

extension Rhythm {

    struct Beamer {
        let rhythm: Rhythm

        func beam() -> [Rhythm.Beaming] {
            fatalError()
        }
    }
}

/// - Returns: The amount of dots required to render the given `duration`.
internal func dotCount(_ duration: MetricalDuration) -> Int {

    let beats = duration.reduced.numerator

    #warning("Implement PowerOfTwoMinusOneSequence (3,7,15,31,...)")
    guard [1,3,7].contains(beats) else {
        fatalError("Unsanitary duration for beamed representation: \(beats)")
    }

    return beats == 3 ? 1 : beats == 7 ? 2 : 0
}

/// - Returns: Amount of beams needed to represent the given `duration`.
internal func beamCount(_ duration: MetricalDuration) -> Int {

    let reduced = duration.reduced

    guard [1,3,7].contains(reduced.numerator) else {
        fatalError("Unsanitary duration for beamed representation: \(reduced)")
    }

    let subdivisionCount = countTrailingZeros(reduced.denominator) - 2

    if reduced.numerator.isDivisible(by: 3) {
        return subdivisionCount - 1
    } else if reduced.numerator.isDivisible(by: 7) {
        return subdivisionCount - 2
    }

    return subdivisionCount
}

extension Rhythm.Beaming.Item {

    /// Create a `Junction` with the given context:
    ///
    /// - prev: Previous beaming count (if it exists)
    /// - cur: Current beaming count
    /// - next: Next beaming count (if it exists)
    public init(_ prev: Int?, _ cur: Int, _ next: Int?) {

        func maintains(_ count: Int) -> [Point] {
            return .init(repeating: .maintain, count: count)
        }

        func starts(_ count: Int) -> [Point] {
            return .init(repeating: .start, count: count)
        }

        func stops(_ count: Int) -> [Point] {
            return .init(repeating: .stop, count: count)
        }

        func beamlets(_ direction: BeamletDirection, _ count: Int) -> [Point] {
            return .init(repeating: .beamlet(direction: direction), count: count)
        }

        /// - Returns: Array of `State` values for a singleton `BeamJunction`.
        func singleton(_ cur: Int) -> [Point] {
            return beamlets(.forward, cur)
        }

        /// - Returns: Array of `State` values for a first `BeamJunction` in a sequence.
        func first(_ cur: Int, _ next: Int) -> [Point] {
            guard cur > 0 else { return [] }
            guard next > 0 else { return beamlets(.forward, cur) }
            return starts(Swift.min(cur,next)) + beamlets(.forward, Swift.max(0, cur - next))
        }

        /// - Returns: Array of `State` values for a middle `BeamJunction` in a sequence.
        func middle(_ prev: Int, _ cur: Int, _ next: Int) -> [Point] {
            guard cur > 0 else { return [] }
            guard prev > 0 else {
                guard next > 0 else { return beamlets(.backward, Swift.max(0, cur - prev)) }
                return starts(next) + beamlets(.backward, Swift.max(0, cur - next))
            }
            guard next > 0 else {
                guard prev > 0 else { return beamlets(.backward, Swift.max(0, cur - next)) }
                return stops(prev) + beamlets(.backward, Swift.max(0, cur - prev))
            }
            return (
                maintains(Swift.min(prev,cur,next)) +
                    starts(Swift.max(0, Swift.min(cur,next) - prev)) +
                    stops(Swift.max(0, Swift.min(cur,prev) - next)) +
                    beamlets(.backward, Swift.max(0, cur - Swift.max(prev,next)))
            )
        }

        /// - Returns: Array of `State` values for a last `BeamJunction` in a sequence.
        func last(_ prev: Int, _ cur: Int) -> [Point] {
            guard cur > 0 else { return [] }
            guard prev > 0 else { return beamlets(.backward, cur) }
            return stops(Swift.min(cur,prev)) + beamlets(.backward, Swift.max(0, cur - prev))
        }

        /// - Returns: Array of `State` values for a given `BeamJunction` context.
        func points(_ prev: Int?, _ cur: Int, _ next: Int?) -> [Point] {
            switch (prev, cur, next) {
            case (nil, cur, nil):
                return singleton(cur)
            case (nil, let cur, let next?):
                return first(cur, next)
            case (let prev?, let cur, let next?):
                return middle(prev, cur, next)
            case (let prev?, let cur, nil):
                return last(prev, cur)
            default:
                fatalError("Ill-formed context")
            }
        }

        self.init(points(prev,cur,next))
    }
}
