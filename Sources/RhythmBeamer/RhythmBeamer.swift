//
//  RhythmBeamer.swift
//  RhythmBeamer
//
//  Created by James Bean on 6/18/18.
//

import DataStructures
import func Math.countTrailingZeros
import MetricalDuration
import Rhythm
import SpelledRhythm

public enum DefaultBeamer {
    public static func beaming <T> (for rhythm: Rhythm<T>) -> Rhythm<T>.Beaming {
        return .init(beamingItems(rhythm.metricalDurationTree.leaves))
    }
}

extension Rhythm.Beaming.Item {

    /// Create a `Junction` with the given context:
    ///
    /// - prev: Previous beaming count (if it exists)
    /// - cur: Current beaming count
    /// - next: Next beaming count (if it exists)
    public init(_ prev: Int?, _ cur: Int, _ next: Int?) {

        func maintains(_ count: Int) -> Stack<Point> {
            return .init(repeating: .maintain, count: count)
        }

        func starts(_ count: Int) -> Stack<Point> {
            return .init(repeating: .start, count: count)
        }

        func stops(_ count: Int) -> Stack<Point> {
            return .init(repeating: .stop, count: count)
        }

        func beamlets(_ direction: BeamletDirection, _ count: Int) -> Stack<Point> {
            return .init(repeating: .beamlet(direction: direction), count: count)
        }

        /// - Returns: Array of `State` values for a singleton `BeamJunction`.
        func singleton(_ cur: Int) -> Stack<Point> {
            return beamlets(.forward, cur)
        }

        /// - Returns: Array of `State` values for a first `BeamJunction` in a sequence.
        func first(_ cur: Int, _ next: Int) -> Stack<Point> {
            guard cur > 0 else { return [] }
            guard next > 0 else { return beamlets(.forward, cur) }
            return starts(Swift.min(cur,next)) + beamlets(.forward, Swift.max(0, cur - next))
        }

        /// - Returns: Array of `State` values for a middle `BeamJunction` in a sequence.
        func middle(_ prev: Int, _ cur: Int, _ next: Int) -> Stack<Point> {
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
        func last(_ prev: Int, _ cur: Int) -> Stack<Point> {
            guard cur > 0 else { return [] }
            guard prev > 0 else { return beamlets(.backward, cur) }
            return stops(Swift.min(cur,prev)) + beamlets(.backward, Swift.max(0, cur - prev))
        }

        /// - Returns: Array of `State` values for a given `BeamJunction` context.
        func points(_ prev: Int?, _ cur: Int, _ next: Int?) -> Stack<Point> {
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

/// - Returns: An array of `BeamJunction` values for the given `counts` (amounts of beams).
internal func beamingItems <T> (_ counts: [Int]) -> [Rhythm<T>.Beaming.Item] {
    return counts.indices.map { index in
        let prev = counts[safe: index - 1]
        let cur = counts[index]
        let next = counts[safe: index + 1]
        return Rhythm<T>.Beaming.Item(prev, cur, next)
    }
}

/// - Returns: An array of `BeamJunction` values for the given `leaves`.
func beamingItems <T> (_ leaves: [MetricalDuration]) -> [Rhythm<T>.Beaming.Item] {
    return beamingItems(leaves.map(beamCount))
}

/// - Returns: Amount of beams needed to represent the given `duration`.
func beamCount(_ duration: MetricalDuration) -> Int {

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

extension Stack {

    init(repeating element: Element, count: Int) {
        self.init(repeatElement(element, count: count))
    }
}
