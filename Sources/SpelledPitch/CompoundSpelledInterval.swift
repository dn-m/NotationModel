//
//  CompoundSpelledInterval.swift
//  SpelledPitch
//
//  Createsd by James Bean on 5/20/18.
//

import Math
import Algorithms
import Pitch

/// A `OrderedSpelledInterval` that can be more than an octave displaced.
public struct CompoundSpelledInterval: SpelledInterval {

    // MARK: - Instance Properties

    /// The base interval.
    public let interval: Interval

    /// The amount of octaves displaced.
    public let octaveDisplacement: Int
}

extension CompoundSpelledInterval {

    // MARK: - Associated Types

    /// `OrderedSpelledInterval`.
    public typealias Interval = OrderedSpelledInterval

    /// `OrderedSpelledInterval.Ordinal`.
    public typealias Ordinal = Interval.Ordinal
}

extension CompoundSpelledInterval {

    // MARK: - Initializers

    /// Creates a `CompoundSpelledInterval` with the given `interval` and the amount of `octaves` of
    /// displacement.
    public init(_ interval: OrderedSpelledInterval, displacedBy octaves: Int = 0) {
        self.interval = interval
        self.octaveDisplacement = octaves
    }

    /// Creates a `CompoundSpelledInterval` with the given `quality` and the given `ordinal`, with
    /// no octave displacement.
    public init(_ quality: SpelledIntervalQuality, _ ordinal: Ordinal) {
        self.init(OrderedSpelledInterval(quality,ordinal))
    }

    /// Creates a `CompoundSpelledInterval` with the two given `SpelledPitch` values.
    public init(_ a: SpelledPitch<EDO12>, _ b: SpelledPitch<EDO12>) {
        self.init(OrderedSpelledInterval(a,b), displacedBy: abs(b.octave - a.octave))
    }
}

extension CompoundSpelledInterval: Equatable { }
extension CompoundSpelledInterval: Hashable { }
