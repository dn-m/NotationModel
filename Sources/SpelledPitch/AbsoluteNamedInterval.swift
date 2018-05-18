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

    // test, test, test
    // Un_underscore_this
    public enum _Ordinal {

        public enum PerfectOrdinal {

            // convert to general ordinal
            var ordinal: Ordinal {
                switch self {
                case .unison:
                    return .unison
                case .fourth:
                    return .fourth
                case .fifth:
                    return .fifth
                }
            }

            case unison
            case fourth
            case fifth
        }

        public enum ImperfectOrdinal {

            // convert to general ordinal
            var ordinal: Ordinal {
                switch self {
                case .second:
                    return .second
                case .third:
                    return .third
                case .sixth:
                    return .sixth
                case .seventh:
                    return .seventh
                }
            }

            case second
            case third
            case sixth
            case seventh
        }

        case perfect(PerfectOrdinal)
        case imperfect(ImperfectOrdinal)
    }

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

    // MARK: - Type Properties

    /// Unison interval.
    public static var unison: AbsoluteNamedInterval {
        return .init(.perfect(.perfect), .unison)
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
    internal init(_ quality: Quality, _ ordinal: Ordinal) {

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

    public init(_ quality: Quality.PerfectQuality, _ ordinal: _Ordinal.PerfectOrdinal) {
        self.quality = .perfect(.perfect)
        self.ordinal = ordinal.ordinal
    }

    public init(_ quality: Quality.ImperfectQuality, _ ordinal: _Ordinal.ImperfectOrdinal) {
        self.quality = .imperfect(quality)
        self.ordinal = ordinal.ordinal
    }

    public init(_ quality: Quality.AugmentedOrDiminishedQuality.AugmentedOrDiminished, _ ordinal: _Ordinal.ImperfectOrdinal) {
        self.quality = .augmentedOrDiminished(.init(.single, quality))
        self.ordinal = ordinal.ordinal
    }

    public init(_ quality: Quality.AugmentedOrDiminishedQuality.AugmentedOrDiminished, _ ordinal: _Ordinal.PerfectOrdinal) {
        self.quality = .augmentedOrDiminished(.init(.single, quality))
        self.ordinal = ordinal.ordinal
    }

    public init(
        _ degree: Quality.AugmentedOrDiminishedQuality.Degree,
        _ quality: Quality.AugmentedOrDiminishedQuality.AugmentedOrDiminished,
        _ ordinal: _Ordinal.ImperfectOrdinal
    ) {
        self.quality = .augmentedOrDiminished(.init(degree, quality))
        self.ordinal = ordinal.ordinal
    }

    public init(
        _ degree: Quality.AugmentedOrDiminishedQuality.Degree,
        _ quality: Quality.AugmentedOrDiminishedQuality.AugmentedOrDiminished,
        _ ordinal: _Ordinal.PerfectOrdinal
    ) {
        self.quality = .augmentedOrDiminished(.init(degree, quality))
        self.ordinal = ordinal.ordinal
    }
}
