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

    // MARK: - Associated Types
    
    /// `PitchType` with level of ordering necessary to construct a `NamedUnorderedInterval`.
    public typealias PitchType = Pitch.Class
    
    /// Type describing the quality of a `NamedInterval`-conforming type.
    public typealias Quality = NamedIntervalQuality
    
    // MARK: - Nested Types

    /// The name of a `NamedUnorderedInterval`.
    public enum Size {

        /// Perfect ordinals.
        public enum Perfect {
            case unison, fourth
        }

        /// Imperfect ordinals.
        public enum Imperfect {
            case second, third
        }

        case perfect(Perfect)
        case imperfect(Imperfect)

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

    // MARK: - Type Properties

    /// Unison interval.
    public static var unison: NamedUnorderedInterval {
        return .init(.perfect, .unison)
    }
    
    // MARK: - Instance Properties
    
    /// Name value of a `NamedUnorderedInterval` (`unison`, `second`, `third`, `fourth`).
    public let name: Size
    
    /// Quality value of a `NamedUnorderedInterval`
    /// (`diminished`, `minor`, `perfect`, `major`, `augmented`).
    public let quality: Quality
    
    // MARK: - Initializers

    /// Create a perfect `NamedUnorderedInterval`.
    ///
    ///     let perfectFifth = NamedUnorderedInterval(.perfect, .fourth)
    ///
    public init(_ quality: Quality.Perfect, _ name: Size.Perfect) {
        self.quality = .perfect(.perfect)
        self.name = .perfect(name)
    }

    /// Create an imperfect `NamedUnorderedInterval`.
    ///
    ///     let majorSecond = NamedUnorderedInterval(.major, .second)
    ///     let minorThird = NamedUnorderedInterval(.minor, .third)
    ///
    public init(_ quality: Quality.Imperfect, _ name: Size.Imperfect) {
        self.quality = .imperfect(quality)
        self.name = .imperfect(name)
    }

    /// Create an augmented or diminished `NamedUnorderedInterval` with an imperfect name.
    ///
    ///     let doubleDiminishedSecond = NamedUnorderedInterval(.diminished, .second)
    ///     let tripleAugmentedThird = NamedUnorderedInterval(.augmented, .third)
    ///
    public init(_ quality: Quality.Extended.AugmentedOrDiminished, _ name: Size.Imperfect) {
        self.quality = .extended(.init(.single, quality))
        self.name = .imperfect(name)
    }

    /// Create an augmented or diminished `NamedUnorderedInterval` with a perfect name.
    ///
    ///     let doubleAugmentedUnison = NamedUnorderedInterval(.augmented, .unison)
    ///     let tripleDiminishedFourth = NamedUnorderedInterval(.diminished, .fourth)
    ///
    public init(_ quality: Quality.Extended.AugmentedOrDiminished, _ name: Size.Perfect) {
        self.quality = .extended(.init(.single, quality))
        self.name = .perfect(name)
    }

    /// Create an augmented or diminished `NamedOrderedInterval` with a imperfect name. These
    /// intervals can be up to quintuple augmented or diminished.
    ///
    ///     let doubleAugmentedUnison = NamedOrderedInterval(.double, .augmented, .second)
    ///     let tripleDiminishedFourth = NamedOrderedInterval(.triple, .diminished, .third)
    ///
    public init(
        _ degree: Quality.Extended.Degree,
        _ quality: Quality.Extended.AugmentedOrDiminished,
        _ name: Size.Imperfect
    )
    {
        self.quality = .extended(.init(degree, quality))
        self.name = .imperfect(name)
    }

    /// Create an augmented or diminished `NamedOrderedInterval` with a perfect name. These
    /// intervals can be up to quintuple augmented or diminished.
    ///
    ///     let doubleAugmentedUnison = NamedOrderedInterval(.double, .augmented, .unison)
    ///     let tripleDiminishedFourth = NamedOrderedInterval(.triple, .diminished, .fourth)
    ///
    public init(
        _ degree: Quality.Extended.Degree,
        _ quality: Quality.Extended.AugmentedOrDiminished,
        _ name: Size.Perfect
    )
    {
        self.quality = .extended(.init(degree, quality))
        self.name = .perfect(name)
    }

    /// Create a `NamedUnorderedInterval` with a given `quality` and `name`.
    ///
    ///     let minorSecond = NamedUnorderedInterval(.minor, .second)
    ///     let augmentedSixth = NamedUnorderedInterval(.augmented, .sixth)
    ///
    internal init(_ quality: Quality, _ name: Size) {
        self.quality = quality
        self.name = name
    }
    
    /// Create a `NamedUnorderedInterval` with two `SpelledPitch` values.
    ///
    // FIXME: Modify to take in `SpelledDyad`.
    public init(_ a: SpelledPitchClass, _ b: SpelledPitchClass) {
        
        // Ensure that the two `SpelledPitchClass` values are in the correct order to create
        // a relative interval.
        let (a,b) = ordered(a,b)

        // Given the ordered `SpelledPitchClass` values, retrieve the difference in steps of
        // the `Pitch.Spelling.letterName` properties, and the difference between the
        // `noteNumber` properties.
        let (steps, interval) = stepsAndInterval(a,b)
        
        // Sanitize interval in order to calulate the `Quality`.
        let sanitizedInterval = sanitizeIntervalClass(interval, steps: steps)
        
        // Create the necessary structures
        let name = Size(steps: steps)!
        let quality = Quality(sanitizedIntervalClass: sanitizedInterval, name: name)
        
        // Init
        self.init(quality, name)
    }
}

extension NamedUnorderedInterval.Size: Equatable, Hashable { }
extension NamedUnorderedInterval: Equatable, Hashable { }

private func ordered (_ a: SpelledPitchClass, _ b: SpelledPitchClass)
    -> (SpelledPitchClass, SpelledPitchClass)
{
    let (a,b,_) = swapped(a, b) { mod(steps(a,b), 7) > mod(steps(b,a), 7) }
    return (a,b)
}

private func stepsAndInterval(_ a: SpelledPitchClass, _ b: SpelledPitchClass)
    -> (Int, Double)
{
    return (steps(a,b), interval(a,b))
}

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

private func interval(_ a: SpelledPitchClass, _ b: SpelledPitchClass) -> Double {
    return (b.pitchClass - a.pitchClass).noteNumber.value
}

/// Modulo 7
private func steps(_ a: SpelledPitchClass, _ b: SpelledPitchClass) -> Int {
    return mod(b.spelling.letterName.steps - a.spelling.letterName.steps, 7)
}
