//
//  RhythmBeamer.swift
//  RhythmBeamer
//
//  Created by James Bean on 6/18/18.
//

import DataStructures
import Math
import MetricalDuration
import Rhythm
import SpelledRhythm

public enum DefaultBeamer {
    /// - Returns: A reasonable `Beaming` for the given `rhythm`.
    public static func beaming <T> (for rhythm: Rhythm<T>) -> Beaming {
        return Beaming(
            sanitizingBeamletDirections(for: beamingVerticals(rhythm.metricalDurationTree.leaves))
        )
    }
}

extension Beaming.Point.Vertical {

    /// - Returns: Singleton `Vertical`.
    static func singleton(_ cur: Int) -> Beaming.Point.Vertical {
        return .init(beamlets: cur)
    }

    /// - Returns: The `Vertical` for the first context in a rhythm.
    static func first(_ cur: Int, _ next: Int) -> Beaming.Point.Vertical {
        return .init(start: Swift.min(cur,next), beamlets: Swift.max(0, cur-next))
    }

    /// - Returns: The `Vertical` for the context in a rhythm.
    static func middle(_ prev: Int, _ cur: Int, _ next: Int) -> Beaming.Point.Vertical {
        guard prev > 0 else {
            let beamlets = Swift.max(0, cur - prev)
            guard next > 0 else { return .init(beamlets: beamlets) }
            return .init(start: Swift.min(cur,next), beamlets: Swift.max(0, cur - next))
        }
        guard next > 0 else {
            guard prev > 0 else { return .init(beamlets: Swift.max(0, cur - next)) }
            return .init(stop: Swift.min(cur, prev), beamlets: Swift.max(0, cur - prev))
        }
        let startCount = Swift.max(0, Swift.min(cur,next) - prev)
        let stopCount = Swift.max(0, Swift.min(cur,prev) - next)
        let startOrStop: Beaming.Point.StartOrStop = (
            startCount > 0 ? .start(count: startCount)
                : stopCount > 0 ? .stop(count: stopCount)
                : .none
        )
        return .init(
            maintain: Swift.min(prev,cur,next),
            startOrStop: startOrStop,
            beamlets: Swift.max(0, cur - Swift.max(prev,next))
        )
    }

    /// - Returns: The `Vertical` for the last context in a rhythm.
    static func last(_ prev: Int, _ cur: Int) -> Beaming.Point.Vertical {
        return .init(stop: Swift.min(cur,prev), beamlets: Swift.max(0, cur - prev))
    }

    /// Create a `Vertical` with the given context:
    ///
    /// - prev: Previous beaming count (if it exists)
    /// - cur: Current beaming count
    /// - next: Next beaming count (if it exists)
    public init(_ prev: Int?, _ cur: Int, _ next: Int?) {
        guard cur > 0 else { self.init(); return }
        switch (prev, cur, next) {
        case (nil, cur, nil):
            self = .singleton(cur)
        case (nil, let cur, let next?):
            self = .first(cur, next)
        case (let prev?, let cur, let next?):
            self = .middle(prev, cur, next)
        case (let prev?, let cur, nil):
            self = .last(prev, cur)
        default:
            fatalError("Ill-formed context")
        }
    }
}

extension Beaming {
    /// Create a `Beaming` with the given amount of beams per vertical.
    init(beamCounts: [Int]) {
        self.init(sanitizingBeamletDirections(for: beamingVerticals(beamCounts)))
    }
}

/// - Returns: An array of `Point.Vertical` values for the given `counts` (amounts of beams).
func beamingVerticals (_ counts: [Int]) -> [Beaming.Point.Vertical] {
    return counts.indices.map { index in
        let prev = counts[safe: index - 1]
        let cur = counts[index]
        let next = counts[safe: index + 1]
        return Beaming.Point.Vertical(prev,cur,next)
    }
}

/// - Returns: An array of `BeamJunction` values for the given `leaves`.
func beamingVerticals (_ leaves: [MetricalDuration]) -> [Beaming.Point.Vertical] {
    return beamingVerticals(leaves.map(beamCount))
}

/// - Returns: Amount of beams needed to represent the given `duration`.
func beamCount(_ duration: MetricalDuration) -> Int {
    let reduced = duration.reduced
    let subdivisionCount = countTrailingZeros(reduced.denominator) - 2
    guard reduced.numerator > 1 else { return subdivisionCount }
    let powers = PowerSequence(coefficient: 2, max: reduced.numerator, doOvershoot: true)
    let powersMinusOne = powers.map { $0 - 1 }
    for (offset,divisor) in powersMinusOne.dropFirst().enumerated() {
        if reduced.numerator.isDivisible(by: divisor) {
            let dotCount = offset + 1
            return subdivisionCount - dotCount
        }
    }
    fatalError("\(duration) is not representable with beams")
}
