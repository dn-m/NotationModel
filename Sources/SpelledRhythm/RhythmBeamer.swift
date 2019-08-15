//
//  RhythmBeamer.swift
//  RhythmBeamer
//
//  Created by James Bean on 6/18/18.
//

import DataStructures
import Math
import Duration

public enum DefaultBeamer {
    /// - Returns: A reasonable `Beaming` for the given `rhythm`.
    public static func beaming <T> (for rhythm: Rhythm<T>) -> Beaming {
        return Beaming(
            sanitizingBeamletDirections(for: beamingVerticals(rhythm.durationTree.leaves))
        )
    }
}

extension Beaming {
    /// Creates a `Beaming` with the given amount of beams per vertical.
    init(beamCounts: [Int]) {
        self.init(sanitizingBeamletDirections(for: beamingVerticals(beamCounts)))
    }
}

/// - Returns: An array of `BeamJunction` values for the given `leaves`.
func beamingVerticals (_ leaves: [Duration]) -> [Beaming.Point.Vertical] {
    return beamingVerticals(leaves.map(beamCount))
}

/// - Returns: An array of `Point.Vertical` values for the given `counts` (amounts of beams).
func beamingVerticals (_ counts: [Int]) -> [Beaming.Point.Vertical] {
    guard !counts.isEmpty else { return [] }
    return zip([0] + counts.dropLast(), counts, counts.dropFirst(), fill: 0).map(vertical)
}

/// - Returns: a `Beaming.Point.Vertical` with the given context:
///
/// - prev: Previous beaming count (if it exists, or 0 if it doesn't)
/// - cur: Current beaming count
/// - next: Next beaming count (if it exists, or 0 if it doesn't)
func vertical(_ prev: Int, _ cur: Int, _ next: Int) -> Beaming.Point.Vertical {
    return .init(
        maintain: min(prev,cur,next),
        startOrStop: .init(start: max(0,min(cur,next)-prev), stop: max(0,min(cur,prev)-next)),
        beamlets: max(0,cur-max(prev,next))
    )
}

/// - Returns: Amount of beams needed to represent the given `duration`.
func beamCount(_ duration: Duration) -> Int {
    let reduced = duration.reduced
    let subdivisionCount = countTrailingZeros(reduced.denominator) - 2
    guard reduced.numerator > 1 else { return subdivisionCount }
    let powers = powersOfTwo(upTo: reduced.numerator, overshooting: true)
    let powersMinusOne = powers.map { $0 - 1 }
    for (offset,divisor) in powersMinusOne.dropFirst().enumerated() {
        if reduced.numerator.isMultiple(of: divisor) {
            let dotCount = offset + 1
            return subdivisionCount - dotCount
        }
    }
    fatalError("\(duration) is not representable with beams")
}

extension Beaming.Point.StartOrStop {
    /// Creates a `StartOrStop` with the given amounts. You can't start and stop in the same
    /// `vertical`, so don't.
    init(start: Int, stop: Int) {
        self = start > 0 ? .start(count: start) : stop > 0 ? .stop(count: stop) : .none
    }
}
