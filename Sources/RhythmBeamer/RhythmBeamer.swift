//
//  RhythmBeamer.swift
//  RhythmBeamer
//
//  Created by James Bean on 6/18/18.
//

import DataStructures
import Algorithms
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

extension Beaming {
    /// Create a `Beaming` with the given amount of beams per vertical.
    init(beamCounts: [Int]) {
        self.init(sanitizingBeamletDirections(for: beamingVerticals(beamCounts)))
    }
}

/// - Returns: An array of `BeamJunction` values for the given `leaves`.
func beamingVerticals (_ leaves: [MetricalDuration]) -> [Beaming.Point.Vertical] {
    return beamingVerticals(leaves.map(beamCount))
}

/// - Returns: An array of `Point.Vertical` values for the given `counts` (amounts of beams).
func beamingVerticals (_ counts: [Int]) -> [Beaming.Point.Vertical] {
    guard !counts.isEmpty else { return [] }
    return zipToLongest([0] + counts.dropLast(), counts, counts.dropFirst(), fill: 0).map(vertical)
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

extension Beaming.Point.StartOrStop {
    /// Create a `StartOrStop` with the given amounts. You can't start and stop in the same
    /// `vertical`, so don't.
    init(start: Int, stop: Int) {
        self = start > 0 ? .start(count: start) : stop > 0 ? .stop(count: stop) : .none
    }
}

func zipToLongest <A,B> (_ a: A, _ b: B, firstFill: A.Element, secondFill: B.Element)
    -> ZipToLongest2Sequence<A,B> where A: Sequence, B: Sequence
{
    return ZipToLongest2Sequence(a, b, firstFill: firstFill, secondFill: secondFill)
}

func zipToLongest <A,B,C> (_ a: A, _ b: B, _ c: C, fill: A.Element)
    -> ZipToLongest3Sequence<A,B,C> where
        A: Sequence, B: Sequence, C: Sequence, A.Element == B.Element, B.Element == C.Element
{
    return ZipToLongest3Sequence(a, b, c, firstFill: fill, secondFill: fill, thirdFill: fill)
}

func zipToLongest <A,B,C> (
    _ a: A,
    _ b: B,
    _ c: C,
    firstFill: A.Element,
    secondFill: B.Element,
    thirdFill: C.Element
) -> ZipToLongest3Sequence<A,B,C> where A: Sequence, B: Sequence, C: Sequence
{
    return ZipToLongest3Sequence(
        a,
        b,
        c,
        firstFill: firstFill,
        secondFill: secondFill,
        thirdFill: thirdFill
    )
}

public struct ZipToLongest2Sequence<A: Sequence, B: Sequence>: IteratorProtocol, Sequence {

    private var firstIterator: A.Iterator
    private var secondIterator: B.Iterator
    private let firstFill: A.Element
    private let secondFill: B.Element

    init(_ a: A, _ b: B, firstFill: A.Element, secondFill: B.Element) {
        self.firstIterator = a.makeIterator()
        self.secondIterator = b.makeIterator()
        self.firstFill = firstFill
        self.secondFill = secondFill
    }

    public mutating func next() -> (A.Element, B.Element)? {
        let firstValue = firstIterator.next()
        let secondValue = secondIterator.next()
        guard firstValue != nil || secondValue != nil else { return nil }
        return (firstValue ?? firstFill, secondValue ?? secondFill)
    }
}

public struct ZipToLongest3Sequence<
    A: Sequence,
    B: Sequence,
    C: Sequence
>: IteratorProtocol, Sequence
{

    private var firstIterator: A.Iterator
    private var secondIterator: B.Iterator
    private var thirdIterator: C.Iterator
    private let firstFill: A.Element
    private let secondFill: B.Element
    private let thirdFill: C.Element

    init(_ a: A, _ b: B, _ c: C, firstFill: A.Element, secondFill: B.Element, thirdFill: C.Element) {
        self.firstIterator = a.makeIterator()
        self.secondIterator = b.makeIterator()
        self.thirdIterator = c.makeIterator()
        self.firstFill = firstFill
        self.secondFill = secondFill
        self.thirdFill = thirdFill
    }

    public mutating func next() -> (A.Element, B.Element, C.Element)? {
        let firstValue = firstIterator.next()
        let secondValue = secondIterator.next()
        let thirdValue = thirdIterator.next()
        guard firstValue != nil || secondValue != nil || thirdValue != nil else { return nil }
        return (firstValue ?? firstFill, secondValue ?? secondFill, thirdValue ?? thirdFill)
    }
}
