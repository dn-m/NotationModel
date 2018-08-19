//
//  OrderedSpelledInterval.swift
//  SpelledPitch
//
//  Created by James Bean on 1/8/17.
//
//

import Algebra
import Math
import DataStructures
import Algorithms
import Pitch

/// Named intervals between two `SpelledPitch` values that honors order between them.
public struct OrderedSpelledInterval: SpelledInterval {

    // MARK: - Instance Properties

    /// The direction of a `NamedOrderedInterval`.
    public let direction: Direction

    /// Ordinal value of a `NamedOrderedInterval`
    /// (`unison`, `second`, `third`, `fourth`, `fifth`, `sixth`, `seventh`).
    public let ordinal: Ordinal

    /// /// Quality value of a `NamedUnorderedInterval`
    /// (`diminished`, `minor`, `perfect`, `major`, `augmented`).
    public let quality: Quality
}

extension OrderedSpelledInterval {

    // MARK: - Associated Types

    /// Type describing the quality of a `NamedInterval`-conforming type.
    public typealias Quality = SpelledIntervalQuality
}

extension OrderedSpelledInterval {

    // MARK: - Nested Types

    /// Direction of a `OrderedSpelledInterval`.
    public enum Direction: InvertibleEnum {
        case ascending, descending
    }

    /// Ordinal for `OrderedSpelledInterval`.
    public enum Ordinal: SpelledIntervalOrdinal {

        // MARK: - Cases

        /// Perfect named ordered interval ordinal (unison, fourth, or fifth).
        case perfect(Perfect)

        /// Imperfect named ordered interval ordinal (second, third, sixth, or seventh).
        case imperfect(Imperfect)

        /// - Returns: Inversion of `self`.
        ///
        ///     let third: Ordinal = .imperfect(.third)
        ///     third.inverse // => .imperfect(.sixth)
        ///     let fifth: Ordinal = .perfect(.fifth)
        ///     fifth.inverse // => .perfect(.fourth)
        ///
        public var inverse: OrderedSpelledInterval.Ordinal {
            switch self {
            case .perfect(let ordinal):
                return .perfect(ordinal.inverse)
            case .imperfect(let ordinal):
                return .imperfect(ordinal.inverse)
            }
        }
    }
}

extension OrderedSpelledInterval.Ordinal {

    // MARK: - Nested Types

    /// Perfect `Ordinal` cases.
    public enum Perfect: InvertibleEnum {

        // MARK: - Cases

        /// Fourth perfect named ordered interval ordinal.
        case fourth

        /// Unison perfect named ordered interval ordinal.
        case unison

        /// Fifth perfect named ordered interval ordinal.
        case fifth
    }

    /// Imperfect `Ordinal` cases
    public enum Imperfect: InvertibleEnum {

        // MARK: - Cases

        /// Second imperfect named ordered interval ordinal.
        case second

        /// Third imperfect named ordered interval ordinal.
        case third

        /// Sixth imperfect named ordered interval ordinal.
        case sixth

        /// Seventh imperfect named ordered interval ordinal.
        case seventh
    }
}

extension OrderedSpelledInterval.Ordinal {

    // MARK: - Initializers

    /// Creates a `OrderedSpelledInterval` with the given amount of `steps`.
    public init?(steps: Int) {
        switch steps {
        case 0: self = .perfect(.unison)
        case 1: self = .imperfect(.second)
        case 2: self = .imperfect(.third)
        case 3: self = .perfect(.fourth)
        case 4: self = .perfect(.fifth)
        case 5: self = .imperfect(.sixth)
        case 6: self = .imperfect(.seventh)
        default: return nil
        }
    }

    /// Creates an `OrderedSpelledInterval` with the given `unordered` spelled interval.
    ///
    /// > This is a lossless conversion.
    ///
    public init(_ unordered: UnorderedSpelledInterval.Ordinal) {
        switch unordered {
        case .perfect(let perfect):
            switch perfect {
            case .unison:
                self = .perfect(.unison)
            case .fourth:
                self = .perfect(.fourth)
            }
        case .imperfect(let imperfect):
            switch imperfect {
            case .second:
                self = .imperfect(.second)
            case .third:
                self = .imperfect(.third)
            }
        }
    }
}

extension OrderedSpelledInterval.Ordinal {
    var platonicThreshold: Double {
        switch self {
        case .perfect:
            return 1
        case .imperfect:
            return 1.5
        }
    }

    static func platonicInterval(steps: Int) -> Double {
        assert((0..<7).contains(steps))
        switch steps {
        case 0:
            return 0
        case 1:
            return 1.5
        case 2:
            return 3.5
        case 3:
            return 5
        case 4:
            return 7
        case 5:
            return 8.5
        case 6:
            return 10.5
        default:
            fatalError("Impossible")
        }
    }
}


extension OrderedSpelledInterval {

    // MARK: - Type Properties

    /// Unison named ordered interval.
    public static var unison: OrderedSpelledInterval {
        return .init(.perfect, .unison)
    }
}

extension OrderedSpelledInterval {

    // MARK: - Initializers

    /// Creates an `OrderedSpelledInterval` with a given `quality` and `ordinal`.
    internal init(_ direction: Direction, _ quality: Quality, _ ordinal: Ordinal) {
        self.direction = direction
        self.quality = quality
        self.ordinal = ordinal
    }

    /// Creates an `OrderedSpelledInterval` with a given `quality` and `ordinal`.
    internal init(_ quality: Quality, _ ordinal: Ordinal) {
        self.direction = .ascending
        self.quality = quality
        self.ordinal = ordinal
    }

    /// Creates a perfect `OrderedSpelledInterval`.
    ///
    ///     let perfectFifth = OrderedSpelledInterval(.perfect, .fifth)
    ///
    public init(_ quality: Quality.Perfect, _ ordinal: Ordinal.Perfect) {
        self.direction = .ascending
        self.quality = .perfect(.perfect)
        self.ordinal = .perfect(ordinal)
    }

    /// Creates a perfect `OrderedSpelledInterval` with a given `direction`.
    ///
    ///     let descendingPerfectFifth = OrderedSpelledInterval(.descending, .perfect, .fifth)
    ///
    public init(_ direction: Direction, _ quality: Quality.Perfect, _ ordinal: Ordinal.Perfect) {
        self.direction = direction
        self.quality = .perfect(.perfect)
        self.ordinal = .perfect(ordinal)
    }

    /// Creates an imperfect `OrderedSpelledInterval`.
    ///
    ///     let majorSecond = OrderedSpelledInterval(.major, .second)
    ///     let minorThird = OrderedSpelledInterval(.minor, .third)
    ///     let majorSixth = OrderedSpelledInterval(.major, .sixth)
    ///     let minorSeventh = OrderedSpelledInterval(.minor, .seventh)
    ///
    public init(_ quality: Quality.Imperfect, _ ordinal: Ordinal.Imperfect) {
        self.direction = .ascending
        self.quality = .imperfect(quality)
        self.ordinal = .imperfect(ordinal)
    }

    /// Creates an imperfect `OrderedSpelledInterval`.
    ///
    ///     let majorSecond = OrderedSpelledInterval(.ascending, .major, .second)
    ///     let minorThird = OrderedSpelledInterval(.descending, .minor, .third)
    ///     let majorSixth = OrderedSpelledInterval(.ascending, .major, .sixth)
    ///     let minorSeventh = OrderedSpelledInterval(.descending, .minor, .seventh)
    ///
    public init(
        _ direction: Direction,
        _ quality: Quality.Imperfect,
        _ ordinal: Ordinal.Imperfect
    )
    {
        self.direction = direction
        self.quality = .imperfect(quality)
        self.ordinal = .imperfect(ordinal)
    }

    /// Creates an augmented or diminished `OrderedSpelledInterval` with an imperfect ordinal. These
    /// intervals can be up to quintuple augmented or diminished.
    ///
    ///     let doubleDiminishedSecond = OrderedSpelledInterval(.double, .diminished, .second)
    ///     let tripleAugmentedThird = OrderedSpelledInterval(.triple, .augmented, .third)
    ///
    public init(
        _ degree: Quality.Extended.Degree,
        _ quality: Quality.Extended.AugmentedOrDiminished,
        _ ordinal: Ordinal.Imperfect
    )
    {
        self.direction = .ascending
        self.quality = .extended(.init(degree, quality))
        self.ordinal = .imperfect(ordinal)
    }

    /// Creates an augmented or diminished `OrderedSpelledInterval` with a given `direction` and an
    /// imperfect ordinal. These intervals can be up to quintuple augmented or diminished.
    ///
    ///     let doubleDiminishedSecond = OrderedSpelledInterval(.descending, .double, .diminished, .second)
    ///     let tripleAugmentedThird = OrderedSpelledInterval(.ascending, .triple, .augmented, .third)
    ///
    public init(
        _ direction: Direction,
        _ degree: Quality.Extended.Degree,
        _ quality: Quality.Extended.AugmentedOrDiminished,
        _ ordinal: Ordinal.Imperfect
    )
    {
        self.direction = direction
        self.quality = .extended(.init(degree, quality))
        self.ordinal = .imperfect(ordinal)
    }

    /// Creates an augmented or diminished `OrderedSpelledInterval` with a perfect ordinal. These
    /// intervals can be up to quintuple augmented or diminished.
    ///
    ///     let doubleAugmentedUnison = OrderedSpelledInterval(.double, .augmented, .unison)
    ///     let tripleDiminishedFourth = OrderedSpelledInterval(.triple, .diminished, .fourth)
    ///
    public init(
        _ degree: Quality.Extended.Degree,
        _ quality: Quality.Extended.AugmentedOrDiminished,
        _ ordinal: Ordinal.Perfect
    )
    {
        self.direction = .ascending
        self.quality = .extended(.init(degree, quality))
        self.ordinal = .perfect(ordinal)
    }

    /// Creates an augmented or diminished `OrderedSpelledInterval` with a given `direction` and a
    /// perfect ordinal. These intervals can be up to quintuple augmented or diminished.
    ///
    ///     let doubleAugmentedUnison = OrderedSpelledInterval(.descending, .double, .augmented, .unison)
    ///     let tripleDiminishedFourth = OrderedSpelledInterval(.ascending, .triple, .diminished, .fourth)
    ///
    public init(
        _ direction: Direction,
        _ degree: Quality.Extended.Degree,
        _ quality: Quality.Extended.AugmentedOrDiminished,
        _ ordinal: Ordinal.Perfect
    )
    {
        self.direction = direction
        self.quality = .extended(.init(degree, quality))
        self.ordinal = .perfect(ordinal)
    }

    /// Creates an augmented or diminished `OrderedSpelledInterval` with an imperfect ordinal.
    ///
    ///     let diminishedSecond = OrderedSpelledInterval(.diminished, .second)
    ///     let augmentedSixth = OrderedSpelledInterval(.augmented, .sixth)
    ///
    public init(_ quality: Quality.Extended.AugmentedOrDiminished, _ ordinal: Ordinal.Imperfect) {
        self.direction = .ascending
        self.quality = .extended(.init(.single, quality))
        self.ordinal = .imperfect(ordinal)
    }

    /// Creates an augmented or diminished `OrderedSpelledInterval` with a given `direction` and an
    /// imperfect ordinal.
    ///
    ///     let diminishedSecond = OrderedSpelledInterval(.descending, .diminished, .second)
    ///     let augmentedSixth = OrderedSpelledInterval(.ascending, .augmented, .sixth)
    ///
    public init(
        _ direction: Direction,
        _ quality: Quality.Extended.AugmentedOrDiminished,
        _ ordinal: Ordinal.Imperfect
    )
    {
        self.direction = direction
        self.quality = .extended(.init(.single, quality))
        self.ordinal = .imperfect(ordinal)
    }

    /// Creates an augmented or diminished `OrderedSpelledInterval` with a perfect ordinal.
    ///
    ///     let augmentedUnison = OrderedSpelledInterval(.augmented, .unison)
    ///     let diminishedFourth = OrderedSpelledInterval(.diminished, .fourth)
    ///
    public init(_ quality: Quality.Extended.AugmentedOrDiminished, _ ordinal: Ordinal.Perfect) {
        self.direction = .ascending
        self.quality = .extended(.init(.single, quality))
        self.ordinal = .perfect(ordinal)
    }

    /// Creates an augmented or diminished `OrderedSpelledInterval` with a given `direction` and a
    /// perfect ordinal.
    ///
    ///     let augmentedUnison = OrderedSpelledInterval(.ascending, .augmented, .unison)
    ///     let diminishedFourth = OrderedSpelledInterval(.descending, .diminished, .fourth)
    ///
    public init(
        _ direction: Direction,
        _ quality: Quality.Extended.AugmentedOrDiminished,
        _ ordinal: Ordinal.Perfect
    )
    {
        self.direction = direction
        self.quality = .extended(.init(.single, quality))
        self.ordinal = .perfect(ordinal)
    }

    /// Creates a `OrderedSpelledInterval` with two `SpelledPitch` values.
    internal init(_ a: SpelledPitch<EDO12>, _ b: SpelledPitch<EDO12>) {
        let (a,b,didSwap) = swapped(a,b) { a > b }
        let (interval,steps) = intervalAndSteps(a,b)
        let (quality,ordinal) = OrderedSpelledInterval.qualityAndOrdinal(interval: interval, steps: steps)
        self.init(didSwap ? .descending : .ascending, quality, ordinal)
    }
}

func intervalAndSteps(_ a: SpelledPitch<EDO12>,  _ b: SpelledPitch<EDO12>) -> (Double,Int) {
    return ((interval(a,b), steps(a,b)))
}

private func interval(_ a: SpelledPitch<EDO12>, _ b: SpelledPitch<EDO12>) -> Double {
    return (b.pitch - a.pitch).noteNumber.value
}

private func steps(_ a: SpelledPitch<EDO12>, _ b: SpelledPitch<EDO12>) -> Int {
    return mod(b.spelling.letterName.steps - a.spelling.letterName.steps, 7)
}

extension OrderedSpelledInterval.Ordinal: Equatable, Hashable { }
extension OrderedSpelledInterval: Equatable, Hashable { }

extension OrderedSpelledInterval: Invertible {

    /// - Returns: Inversion of `self`.
    public var inverse: OrderedSpelledInterval {
        return .init(direction.inverse, quality.inverse, ordinal.inverse)
    }
}
