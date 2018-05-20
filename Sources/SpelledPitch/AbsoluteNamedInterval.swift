//
//  AbsoluteNamedInterval.swift
//  SpelledPitch
//
//  Created by James Bean on 1/8/17.
//
//

import DataStructures

/// Named intervals between two `SpelledPitch` values that honors order between `SpelledPitch`
/// values.
public struct AbsoluteNamedInterval: Equatable {

    // MARK: - Associated Types

    /// Type describing the quality of a `NamedInterval`-conforming type.
    public typealias Quality = NamedIntervalQuality

    // MARK: - Nested Types

    /// Ordinal for `AbsoluteNamedInterval`.
    public enum Ordinal: Equatable, Invertible {

        /// Perfect `Ordinal` cases.
        public enum Perfect: InvertibleEnum {
            case unison, fourth, fifth

            /// Customizes the `InvertibleEnum` `inverse` implementation to return `unison` as the
            /// inverse of `unison`.
            ///
            /// - Returns: Inverse of `self`.
            public var inverse: Perfect {
                let index = Perfect.allCases.index(of: self)!
                guard index > 0 else { return self }
                let inverseIndex = Perfect.allCases.count - index
                return Perfect.allCases[inverseIndex]
            }
        }

        /// Imperfect `Ordinal` cases
        public enum Imperfect: InvertibleEnum {
            case second, third, sixth, seventh
        }

        case perfect(Perfect)
        case imperfect(Imperfect)

        /// - Returns: Inversion of `self`.
        ///
        ///     let third: Ordinal = .imperfect(.third)
        ///     third.inverse // => .imperfect(.sixth)
        ///     let fifth: Ordinal = .perfect(.fifth)
        ///     fifth.inverse // => .perfect(.fourth)
        ///
        public var inverse: AbsoluteNamedInterval.Ordinal {
            switch self {
            case .perfect(let ordinal):
                return .perfect(ordinal.inverse)
            case .imperfect(let ordinal):
                return .imperfect(ordinal.inverse)
            }
        }
    }

    // MARK: - Type Properties

    /// Unison interval.
    public static var unison: AbsoluteNamedInterval {
        return .init(.perfect, .unison)
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
        self.quality = quality
        self.ordinal = ordinal
    }

    /// Create a `NamedInterval` with two `SpelledPitch` values.
    ///
    /// - TODO: Implement!
    internal init(_ a: SpelledPitch, _ b: SpelledPitch) {
        fatalError()
    }

    /// Create a perfect `AbsoluteNamedInterval`.
    ///
    ///     let perfectFifth = AbsoluteNamedInterval(.perfect, .fifth)
    ///
    public init(_ quality: Quality.PerfectQuality, _ ordinal: Ordinal.Perfect) {
        self.quality = .perfect(.perfect)
        self.ordinal = .perfect(ordinal)
    }

    /// Create an imperfect `AbsoluteNamedInterval`.
    ///
    ///     let majorSecond = AbsoluteNamedInterval(.major, .second)
    ///     let minorThird = AbsoluteNamedInterval(.minor, .third)
    ///     let majorSixth = AbsoluteNamedInterval(.major, .sixth)
    ///     let minorSeventh = AbsoluteNamedInterval(.minor, .seventh)
    ///
    public init(_ quality: Quality.ImperfectQuality, _ ordinal: Ordinal.Imperfect) {
        self.quality = .imperfect(quality)
        self.ordinal = .imperfect(ordinal)
    }

    /// Create an augmented or diminished `AbsoluteNamedInterval` with an imperfect ordinal. These
    /// intervals can be up to quintuple augmented or diminished.
    ///
    ///     let doubleDiminishedSecond = AbsoluteNamedInterval(.double, .diminished, .second)
    ///     let tripleAugmentedThird = AbsoluteNamedInterval(.triple, .augmented, .third)
    ///
    public init(
        _ degree: Quality.AugmentedOrDiminishedQuality.Degree,
        _ quality: Quality.AugmentedOrDiminishedQuality.AugmentedOrDiminished,
        _ ordinal: Ordinal.Imperfect
    )
    {
        self.quality = .augmentedOrDiminished(.init(degree, quality))
        self.ordinal = .imperfect(ordinal)
    }

    /// Create an augmented or diminished `AbsoluteNamedInterval` with a perfect ordinal. These
    /// intervals can be up to quintuple augmented or diminished.
    ///
    ///     let doubleAugmentedUnison = AbsoluteNamedInterval(.double, .augmented, .unison)
    ///     let tripleDiminishedFourth = AbsoluteNamedInterval(.triple, .diminished, .fourth)
    ///
    public init(
        _ degree: Quality.AugmentedOrDiminishedQuality.Degree,
        _ quality: Quality.AugmentedOrDiminishedQuality.AugmentedOrDiminished,
        _ ordinal: Ordinal.Perfect
    )
    {
        self.quality = .augmentedOrDiminished(.init(degree, quality))
        self.ordinal = .perfect(ordinal)
    }

    /// Create an augmented or diminished `AbsoluteNamedInterval` with an imperfect ordinal.
    ///
    ///     let diminishedSecond = AbsoluteNamedInterval(.diminished, .second)
    ///     let augmentedSixth = AbsoluteNamedInterval(.augmented, .sixth)
    ///
    public init(
        _ quality: Quality.AugmentedOrDiminishedQuality.AugmentedOrDiminished,
        _ ordinal: Ordinal.Imperfect
    )
    {
        self.quality = .augmentedOrDiminished(.init(.single, quality))
        self.ordinal = .imperfect(ordinal)
    }

    /// Create an augmented or diminished `AbsoluteNamedInterval` with a perfect ordinal.
    ///
    ///     let augmentedUnison = AbsoluteNamedInterval(.augmented, .unison)
    ///     let diminishedFourth = AbsoluteNamedInterval(.diminished, .fourth)
    ///
    public init(
        _ quality: Quality.AugmentedOrDiminishedQuality.AugmentedOrDiminished,
        _ ordinal: Ordinal.Perfect
    )
    {
        self.quality = .augmentedOrDiminished(.init(.single, quality))
        self.ordinal = .perfect(ordinal)
    }
}

extension AbsoluteNamedInterval: Invertible {

    /// - Returns: Inversion of `self`.
    public var inverse: AbsoluteNamedInterval {
        return .init(quality.inverse, ordinal.inverse)
    }
}
