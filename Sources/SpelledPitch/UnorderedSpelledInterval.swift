//
//  UnorderedSpelledInterval.swift
//  SpelledPitch
//
//  Created by James Bean on 1/8/17.
//
//

import Algorithms
import Math
import Pitch

/// Named intervals between two `SpelledPitch` values that does not honor order between
/// `SpelledPitch` values.
public struct UnorderedSpelledInterval: SpelledInterval {

    // MARK: - Instance Properties

    /// Quality value of a `NamedUnorderedInterval`.
    ///
    /// - `diminished`
    /// - `minor`
    /// - `perfect`
    /// - `major`
    /// - `augmented`
    ///
    public let quality: Quality

    /// Ordinal value of a `NamedUnorderedInterval` (
    ///
    /// - `unison`
    /// - `second`
    /// - `third`
    /// - `fourth`
    ///
    public let ordinal: Ordinal
}

extension UnorderedSpelledInterval {

    // MARK: - Associated Types

    /// `PitchType` with level of ordering necessary to construct a `UnorderedSpelledInterval`.
    public typealias PitchType = Pitch.Class

    /// Type describing the quality of a `NamedInterval`-conforming type.
    public typealias Quality = SpelledIntervalQuality
}

extension UnorderedSpelledInterval {

    // MARK: - Nested Types

    /// The ordinal of a `UnorderedSpelledInterval`.
    public enum Ordinal: SpelledIntervalOrdinal {

        // MARK: - Cases

        /// Imperfect named unordered interval ordinals (unison, fourth).
        case perfect(Perfect)

        /// Perfect named unordered interval ordinals (second, third).
        case imperfect(Imperfect)
    }
}

extension UnorderedSpelledInterval.Ordinal {

    // MARK: - Initializers
    
    /// Creates a `UnorderedSpelledInterval` with the given amount of `steps`.
    public init?(steps: Int) {
        switch steps {
        case 0: self = .perfect(.unison)
        case 1: self = .imperfect(.second)
        case 2: self = .imperfect(.third)
        case 3: self = .perfect(.fourth)
        default: return nil
        }
    }

    /// Create an `UnorderedSpelledInterval` with the given `ordered` spelled interval.
    ///
    /// In the case that the `ordered` interval is out of range (e.g., `.fifth`, `.sixth`,
    /// `.seventh`), the `.inverse` is converted in an unordered interval (e.g., a `.seventh`
    /// becomes a `.second`).
    ///
    public init(_ ordered: OrderedSpelledInterval.Ordinal) {
        switch ordered {
        case .perfect(let perfect):
            switch perfect {
            case .unison:
                self = .perfect(.unison)
            case .fourth:
                self = .perfect(.fourth)
            case .fifth:
                self.init(ordered.inverse)
            }
        case .imperfect(let imperfect):
            switch imperfect {
            case .second:
                self = .imperfect(.second)
            case .third:
                self = .imperfect(.third)
            case .sixth:
                self.init(ordered.inverse)
            case .seventh:
                self.init(ordered.inverse)
            }
        }
    }
}

extension UnorderedSpelledInterval.Ordinal {

    // MARK: - Nested Types

    /// Perfect ordinals.
    public enum Perfect {

        // MARK: - Cases

        /// Unison perfect named unordered interval ordinal.
        case unison

        /// Fourth perfect named unordered interval ordinal.
        case fourth
    }

    /// Imperfect ordinals.
    public enum Imperfect {

        // MARK: - Cases

        /// Second imperfect named unordered interval ordinal.
        case second

        /// Third imperfect named unordered interval ordinal.
        case third
    }
}

extension UnorderedSpelledInterval {

    // MARK: - Type Properties

    /// Unison interval.
    public static var unison: UnorderedSpelledInterval {
        return .init(.perfect, .unison)
    }
}

extension UnorderedSpelledInterval {

    // MARK: - Initializers

    /// Create a perfect `UnorderedSpelledInterval`.
    ///
    ///     let perfectFifth = UnorderedSpelledInterval(.perfect, .fourth)
    ///
    public init(_ quality: Quality.Perfect, _ ordinal: Ordinal.Perfect) {
        self.quality = .perfect(.perfect)
        self.ordinal = .perfect(ordinal)
    }

    /// Create an imperfect `UnorderedSpelledInterval`.
    ///
    ///     let majorSecond = UnorderedSpelledInterval(.major, .second)
    ///     let minorThird = UnorderedSpelledInterval(.minor, .third)
    ///
    public init(_ quality: Quality.Imperfect, _ ordinal: Ordinal.Imperfect) {
        self.quality = .imperfect(quality)
        self.ordinal = .imperfect(ordinal)
    }

    /// Create an augmented or diminished `UnorderedSpelledInterval` with an imperfect ordinal.
    ///
    ///     let doubleDiminishedSecond = UnorderedSpelledInterval(.diminished, .second)
    ///     let tripleAugmentedThird = UnorderedSpelledInterval(.augmented, .third)
    ///
    public init(_ quality: Quality.Extended.AugmentedOrDiminished, _ ordinal: Ordinal.Imperfect) {
        self.quality = .extended(.init(.single, quality))
        self.ordinal = .imperfect(ordinal)
    }

    /// Create an augmented or diminished `UnorderedSpelledInterval` with a perfect ordinal.
    ///
    ///     let doubleAugmentedUnison = UnorderedSpelledInterval(.augmented, .unison)
    ///     let tripleDiminishedFourth = UnorderedSpelledInterval(.diminished, .fourth)
    ///
    public init(_ quality: Quality.Extended.AugmentedOrDiminished, _ ordinal: Ordinal.Perfect) {
        self.quality = .extended(.init(.single, quality))
        self.ordinal = .perfect(ordinal)
    }

    /// Create an augmented or diminished `OrderedSpelledInterval` with a imperfect ordinal. These
    /// intervals can be up to quintuple augmented or diminished.
    ///
    ///     let doubleAugmentedUnison = OrderedSpelledInterval(.double, .augmented, .second)
    ///     let tripleDiminishedFourth = OrderedSpelledInterval(.triple, .diminished, .third)
    ///
    public init(
        _ degree: Quality.Extended.Degree,
        _ quality: Quality.Extended.AugmentedOrDiminished,
        _ ordinal: Ordinal.Imperfect
    )
    {
        self.quality = .extended(.init(degree, quality))
        self.ordinal = .imperfect(ordinal)
    }

    /// Create an augmented or diminished `OrderedSpelledInterval` with a perfect ordinal. These
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
        self.quality = .extended(.init(degree, quality))
        self.ordinal = .perfect(ordinal)
    }

    /// Create a `UnorderedSpelledInterval` with a given `quality` and `ordinal`.
    ///
    ///     let minorSecond = UnorderedSpelledInterval(.minor, .second)
    ///     let augmentedSixth = UnorderedSpelledInterval(.augmented, .sixth)
    ///
    internal init(_ quality: Quality, _ ordinal: Ordinal) {
        self.quality = quality
        self.ordinal = ordinal
    }

    /// Create a `UnorderedSpelledInterval` with two `SpelledPitch` values.
    public init(_ a: Pitch.Spelling, _ b: Pitch.Spelling) {
        let (a,b) = ordered(a,b)
        let (interval, steps) = intervalAndSteps(a,b)
        self.init(interval: interval, steps: steps)
    }
}

extension UnorderedSpelledInterval.Ordinal: Equatable, Hashable { }
extension UnorderedSpelledInterval: Equatable, Hashable { }

/// - Returns: The two `Pitch.Spelling` values such that the difference between `b` and `a` is less
/// that the difference between `a` and `b`.
func ordered (_ a: Pitch.Spelling, _ b: Pitch.Spelling) -> (Pitch.Spelling,Pitch.Spelling) {
    let (a,b,_) = swapped(a, b) { mod(steps(a,b), 7) > mod(steps(b,a), 7) }
    return (a,b)
}

/// - Returns: The steps and interval between the two given `Pitch.Spelling` values.
private func intervalAndSteps(_ a: Pitch.Spelling, _ b: Pitch.Spelling) -> (Double,Int) {
    return (interval(a,b), steps(a,b))
}

private func interval(_ a: Pitch.Spelling, _ b: Pitch.Spelling) -> Double {
    return (b.pitchClass - a.pitchClass).noteNumber.value
}

/// Modulo 7
private func steps(_ a: Pitch.Spelling, _ b: Pitch.Spelling) -> Int {
    return mod(b.letterName.steps - a.letterName.steps, 7)
}

extension UnorderedSpelledInterval.Ordinal {

    public var platonicThreshold: Double {
        switch self {
        case .perfect:
            return 1
        case .imperfect:
            return 1.5
        }
    }

    static func platonicInterval(steps: Int) -> Double {
        assert((0..<4).contains(steps))
        switch steps {
        case 0: // unison
            return 0
        case 1: // second
            return 1.5
        case 2: // third
            return 3.5
        case 3: // fourth
            return 5
        default: // impossible
            fatalError("Impossible")
        }
    }
}
