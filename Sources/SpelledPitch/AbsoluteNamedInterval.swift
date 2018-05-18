//
//  AbsoluteNamedInterval.swift
//  SpelledPitch
//
//  Created by James Bean on 1/8/17.
//
//

/// Named intervals between two `SpelledPitch` values that honors order between `SpelledPitch`
/// values.
public struct AbsoluteNamedInterval: NamedInterval, Equatable {

    // MARK: - Associated Types

    /// Type describing the quality of a `NamedInterval`-conforming type.
    public typealias Quality = NamedIntervalQuality

    // MARK: - Nested Types

    /// Type descripting ordinality of an `AbsoluteNamedInterval`.
    public enum Ordinal: Int, NamedIntervalOrdinal {

        // MARK: Ordinal classes

        // Set of `perfect` interval ordinals
        public static let perfects: Set<Ordinal> = [.unison, .fourth, .fifth]

        // Set of `imperfect` interval ordinals
        public static var imperfects: Set<Ordinal> = [.second, .third, .sixth, .seventh]

        // MARK: Ordinal instances

        /// Unison.
        case unison = 0

        /// Second.
        case second = 1

        /// Third.
        case third = 2

        /// Fourth.
        case fourth = 3

        /// Fifth.
        case fifth = 4

        /// Sixth.
        case sixth = 5

        /// Seventh.
        case seventh = 6

        public init?(steps: Int) {
            self.init(rawValue: steps)
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
            print(quality)
            print(ordinal)
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

