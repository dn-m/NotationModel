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

    /// Create a `Vertical` with the given context:
    ///
    /// - prev: Previous beaming count (if it exists)
    /// - cur: Current beaming count
    /// - next: Next beaming count (if it exists)
    public init(_ prev: Int?, _ cur: Int, _ next: Int?) {
        self = vertical(prev,cur,next)
    }
}

extension Beaming.Point.StartOrStop {
    /// Create a `StartOrStop` with the given amounts.
    init(start: Int, stop: Int) {
        self = start > 0 ? .start(count: start) : stop > 0 ? .stop(count: stop) : .none
    }
}

/// - Returns: a `Beaming.Point.Vertical` with the given context:
///
/// - prev: Previous beaming count (if it exists)
/// - cur: Current beaming count
/// - next: Next beaming count (if it exists)
private func vertical(_ prev: Int?, _ cur: Int, _ next: Int?) -> Beaming.Point.Vertical {
    switch (prev, cur, next) {
    case (nil, cur, nil):
        return .init(beamlets: cur)
    case (nil, let cur, let next?):
        return .init(start: min(cur,next), beamlets: max(0,cur-next))
    case (let prev?, let cur, let next?):
        return .init(
            maintain: min(prev,cur,next),
            startOrStop: .init(start: max(0,min(cur,next)-prev), stop: max(0,min(cur,prev)-next)),
            beamlets: max(0,cur-max(prev,next))
        )
    case (let prev?, let cur, nil):
        return .init(stop: min(cur,prev), beamlets: max(0,cur-prev))
    default:
        fatalError("Ill-formed context")
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
