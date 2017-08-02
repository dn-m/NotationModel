//
//  AbsoluteNamedInterval.swift
//  SpelledPitch
//
//  Created by James Bean on 1/8/17.
//
//

import Structure

/// Named intervals between two `SpelledPitch` values that honors order between `SpelledPitch`
/// values.
public struct AbsoluteNamedInterval: NamedInterval {

    // MARK: - Associated Types

    /// Type describing the quality of a `NamedInterval`-conforming type.
    public typealias Quality = NamedIntervalQuality

    // MARK: - Nested Types

    /// Type descripting ordinality of an `AbsoluteNamedInterval`.
    public struct Ordinal: NamedIntervalOrdinal {

        // MARK: - Instance Properties

        /// Raw value.
        public let rawValue: Int

        // MARK: - Cases

        // MARK: Ordinal classes

        // Set of `perfect` interval ordinals
        public static let perfects: Ordinal = [unison, fourth, fifth]

        // Set of `imperfect` interval ordinals
        public static var imperfects: Ordinal = [second, third, sixth, seventh]

        // MARK: Ordinal instances

        /// Unison.
        public static var unison = Ordinal(rawValue: 1 << 0)

        /// Second.
        public static var second = Ordinal(rawValue: 1 << 1)

        /// Third.
        public static var third = Ordinal(rawValue: 1 << 2)

        /// Fourth.
        public static var fourth = Ordinal(rawValue: 1 << 3)

        /// Fifth.
        public static var fifth = Ordinal(rawValue: 1 << 4)

        /// Sixth.
        public static var sixth = Ordinal(rawValue: 1 << 5)

        /// Seventh.
        public static var seventh = Ordinal(rawValue: 1 << 6)

        // MARK: - Instance Properties

        /// Amount of options contained herein.
        public var optionsCount: Int {
            return 7
        }

        /// Inverse of `self`.
        public var inverse: Ordinal {
            let ordinal = countTrailingZeros(rawValue)
            let inverseOrdinal = optionsCount - ordinal
            return Ordinal(rawValue: 1 << inverseOrdinal)
        }

        /// - returns: `true` if an `Ordinal` belongs to the `perfects` class. Otherwise,
        /// `false`.
        public var isPerfect: Bool {
            return Ordinal.perfects.contains(self)
        }

        /// - returns: `true` if an `Ordinal` belongs to the `imperfects` class. Otherwise,
        /// `false`.
        public var isImperfect: Bool {
            return Ordinal.imperfects.contains(self)
        }

        // MARK: - Initializers

        /// Create an `AbsoluteNamedInterval` with a given `rawValue`.
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

    }

    // MARK: - Instance Properties

    /// Ordinal value of a `AbsoluteNamedInterval`
    /// (`unison`, `second`, `third`, `fourth`, `fifth`, `sixth`, `seventh`).
    public let ordinal: Ordinal

    /// /// Quality value of a `RelativeNamedInterval`
    /// (`diminished`, `minor`, `perfect`, `major`, `augmented`).
    public let quality: Quality

    // MARK: - Initializers

    /// Create an `AbsoluteNamedInterval` with a given `quality` and `ordinal`.
    public init(_ quality: Quality, _ ordinal: Ordinal) {

        guard areValid(quality, ordinal) else {
            fatalError("Cannot create an AbsoluteNamedInterval with \(quality) and \(ordinal)")
        }

        self.quality = quality
        self.ordinal = ordinal
    }

    /// Create a `NamedInterval` with two `SpelledPitch` values.
    public init(_ a: SpelledPitch, _ b: SpelledPitch) {
        fatalError()
    }
}

