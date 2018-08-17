//
//  NamedUnorderedInterval.swift
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
public struct NamedUnorderedInterval {

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

extension NamedUnorderedInterval {

    // MARK: - Associated Types

    /// `PitchType` with level of ordering necessary to construct a `NamedUnorderedInterval`.
    public typealias PitchType = Pitch.Class

    /// Type describing the quality of a `NamedInterval`-conforming type.
    public typealias Quality = NamedIntervalQuality
}

extension NamedUnorderedInterval {

    // MARK: - Nested Types

    /// The ordinal of a `NamedUnorderedInterval`.
    public enum Ordinal {

        // MARK: - Cases

        /// Imperfect named unordered interval ordinals (unison, fourth).
        case perfect(Perfect)

        /// Perfect named unordered interval ordinals (second, third).
        case imperfect(Imperfect)
    }
}

extension NamedUnorderedInterval.Ordinal {

    // MARK: - Initializers
    
    /// Creates a `NamedUnorderedInterval` with the given amount of `steps`.
    public init?(steps: Int) {
        switch steps {
        case 0:
            self = .perfect(.unison)
        case 1:
            self = .imperfect(.second)
        case 2:
            self = .imperfect(.third)
        case 3:
            self = .perfect(.fourth)
        default:
            return nil
        }
    }
}

extension NamedUnorderedInterval.Ordinal {

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

extension NamedUnorderedInterval {

    // MARK: - Type Properties

    /// Unison interval.
    public static var unison: NamedUnorderedInterval {
        return .init(.perfect, .unison)
    }
}

extension NamedUnorderedInterval {

    // MARK: - Initializers

    /// Create a perfect `NamedUnorderedInterval`.
    ///
    ///     let perfectFifth = NamedUnorderedInterval(.perfect, .fourth)
    ///
    public init(_ quality: Quality.Perfect, _ ordinal: Ordinal.Perfect) {
        self.quality = .perfect(.perfect)
        self.ordinal = .perfect(ordinal)
    }

    /// Create an imperfect `NamedUnorderedInterval`.
    ///
    ///     let majorSecond = NamedUnorderedInterval(.major, .second)
    ///     let minorThird = NamedUnorderedInterval(.minor, .third)
    ///
    public init(_ quality: Quality.Imperfect, _ ordinal: Ordinal.Imperfect) {
        self.quality = .imperfect(quality)
        self.ordinal = .imperfect(ordinal)
    }

    /// Create an augmented or diminished `NamedUnorderedInterval` with an imperfect ordinal.
    ///
    ///     let doubleDiminishedSecond = NamedUnorderedInterval(.diminished, .second)
    ///     let tripleAugmentedThird = NamedUnorderedInterval(.augmented, .third)
    ///
    public init(_ quality: Quality.Extended.AugmentedOrDiminished, _ ordinal: Ordinal.Imperfect) {
        self.quality = .extended(.init(.single, quality))
        self.ordinal = .imperfect(ordinal)
    }

    /// Create an augmented or diminished `NamedUnorderedInterval` with a perfect ordinal.
    ///
    ///     let doubleAugmentedUnison = NamedUnorderedInterval(.augmented, .unison)
    ///     let tripleDiminishedFourth = NamedUnorderedInterval(.diminished, .fourth)
    ///
    public init(_ quality: Quality.Extended.AugmentedOrDiminished, _ ordinal: Ordinal.Perfect) {
        self.quality = .extended(.init(.single, quality))
        self.ordinal = .perfect(ordinal)
    }

    /// Create an augmented or diminished `NamedOrderedInterval` with a imperfect ordinal. These
    /// intervals can be up to quintuple augmented or diminished.
    ///
    ///     let doubleAugmentedUnison = NamedOrderedInterval(.double, .augmented, .second)
    ///     let tripleDiminishedFourth = NamedOrderedInterval(.triple, .diminished, .third)
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

    /// Create an augmented or diminished `NamedOrderedInterval` with a perfect ordinal. These
    /// intervals can be up to quintuple augmented or diminished.
    ///
    ///     let doubleAugmentedUnison = NamedOrderedInterval(.double, .augmented, .unison)
    ///     let tripleDiminishedFourth = NamedOrderedInterval(.triple, .diminished, .fourth)
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

    /// Create a `NamedUnorderedInterval` with a given `quality` and `ordinal`.
    ///
    ///     let minorSecond = NamedUnorderedInterval(.minor, .second)
    ///     let augmentedSixth = NamedUnorderedInterval(.augmented, .sixth)
    ///
    internal init(_ quality: Quality, _ ordinal: Ordinal) {
        self.quality = quality
        self.ordinal = ordinal
    }

    /// Create a `NamedUnorderedInterval` with two `SpelledPitch` values.
    public init(_ a: Pitch.Spelling, _ b: Pitch.Spelling) {

        // Ensure that the two `Pitch.Speller` values are in the correct order to create
        // a relative interval.
        let (a,b) = ordered(a,b)

        // Given the ordered `Pitch.Speller` values, retrieve the difference in steps of
        // the `Pitch.Spelling.letterName` properties, and the difference between the
        // `noteNumber` properties.
        let (steps, interval) = stepsAndInterval(a,b)

        // Sanitize interval in order to calulate the `Quality`.
        let sanitizedInterval = sanitizeIntervalClass(interval, steps: steps)

        // Create the necessary structures
        let ordinal = Ordinal(steps: steps)!
        let quality = Quality(sanitizedIntervalClass: sanitizedInterval, ordinal: ordinal)

        // Init
        self.init(quality, ordinal)
    }
}

extension NamedUnorderedInterval.Ordinal: Equatable, Hashable { }
extension NamedUnorderedInterval: Equatable, Hashable { }

/// - Returns: The two `Pitch.Spelling` values such that the difference between `b` and `a` is less
/// that the difference between `a` and `b`.
private func ordered (_ a: Pitch.Spelling, _ b: Pitch.Spelling) -> (Pitch.Spelling, Pitch.Spelling) {
    let (a,b,_) = swapped(a, b) { mod(steps(a,b), 7) > mod(steps(b,a), 7) }
    return (a,b)
}

/// - Returns: The steps and interval between the two given `Pitch.Spelling` values.
private func stepsAndInterval(_ a: Pitch.Spelling, _ b: Pitch.Spelling) -> (Int, Double) {
    return (steps(a,b), interval(a,b))
}

/// - Returns: Sanitizes the interval class with the given `steps`.
private func sanitizeIntervalClass(_ intervalClass: Double, steps: Int) -> Double {

    // 1. Retrieve the platonic ideal interval class (neutral second, neutral third)
    let neutral = neutralIntervalClass(steps: steps)

    // 2. Calculate the difference between the actual and ideal
    let difference = intervalClass - neutral

    // 3. Normalize the difference
    let normalizedDifference = mod(difference + 6, 12) - 6
    
    // 4. Enforce positive values if unison
    return steps == 0 ? abs(normalizedDifference) : normalizedDifference
}

private func neutralIntervalClass(steps: Int) -> Double {
    
    assert(steps < 4)

    var neutral: Double {
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
            fatalError()
        }
    }
    
    return neutral
}

private func interval(_ a: Pitch.Spelling, _ b: Pitch.Spelling) -> Double {
    return (b.pitchClass - a.pitchClass).noteNumber.value
}

/// Modulo 7
private func steps(_ a: Pitch.Spelling, _ b: Pitch.Spelling) -> Int {
    return mod(b.letterName.steps - a.letterName.steps, 7)
}
