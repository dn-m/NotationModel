//
//  RelativeNamedInterval.swift
//  SpelledPitch
//
//  Created by James Bean on 1/8/17.
//
//

import Restructure
import DataStructures
import Math
import Pitch

/// Named intervals between two `SpelledPitch` values that does not honor order between
/// `SpelledPitch` values.
public struct RelativeNamedInterval {

    // MARK: - Associated Types
    
    /// `PitchType` with level of ordering necessary to construct a `RelativeNamedInterval`.
    public typealias PitchType = Pitch.Class
    
    /// Type describing the quality of a `NamedInterval`-conforming type.
    public typealias Quality = NamedIntervalQuality
    
    // MARK: - Nested Types

    public enum Ordinal {

        public enum Perfect {
            case unison, fourth
        }

        public enum Imperfect {
            case second, third
        }

        case perfect(Perfect)
        case imperfect(Imperfect)

        /// Creates a `RelativeNamedInterval` with the given amount of `steps`.
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
    public static var unison: RelativeNamedInterval {
        return .init(.perfect, .unison)
    }
    
    // MARK: - Instance Properties
    
    /// Ordinal value of a `RelativeNamedInterval` (`unison`, `second`, `third`, `fourth`).
    public let ordinal: Ordinal
    
    /// Quality value of a `RelativeNamedInterval`
    /// (`diminished`, `minor`, `perfect`, `major`, `augmented`).
    public let quality: Quality
    
    // MARK: - Initializers

    public init(_ quality: Quality.Perfect, _ ordinal: Ordinal.Perfect) {
        self.quality = .perfect(.perfect)
        self.ordinal = .perfect(ordinal)
    }

    public init(_ quality: Quality.Imperfect, _ ordinal: Ordinal.Imperfect) {
        self.quality = .imperfect(quality)
        self.ordinal = .imperfect(ordinal)
    }

    public init(_ quality: Quality.Extended.AugmentedOrDiminished, _ ordinal: Ordinal.Imperfect) {
        self.quality = .augmentedOrDiminished(.init(.single, quality))
        self.ordinal = .imperfect(ordinal)
    }

    public init(_ quality: Quality.Extended.AugmentedOrDiminished, _ ordinal: Ordinal.Perfect) {
        self.quality = .augmentedOrDiminished(.init(.single, quality))
        self.ordinal = .perfect(ordinal)
    }

    public init(
        _ degree: Quality.Extended.Degree,
        _ quality: Quality.Extended.AugmentedOrDiminished,
        _ ordinal: Ordinal.Imperfect
    )
    {
        self.quality = .augmentedOrDiminished(.init(degree, quality))
        self.ordinal = .imperfect(ordinal)
    }

    public init(
        _ degree: Quality.Extended.Degree,
        _ quality: Quality.Extended.AugmentedOrDiminished,
        _ ordinal: Ordinal.Perfect
    )
    {
        self.quality = .augmentedOrDiminished(.init(degree, quality))
        self.ordinal = .perfect(ordinal)
    }

    /// Create a `RelativeNamedInterval` with a given `quality` and `ordinal`.
    ///
    /// **Example:**
    /// ```Swift
    /// let minorSecond = RelativeNamedInterval(.minor, .second)
    /// let augmentedSixth = RelativeNamedInterval(.relative, .sixth)
    /// ```
    internal init(_ quality: Quality, _ ordinal: Ordinal) {
        self.quality = quality
        self.ordinal = ordinal
    }
    
    /// Create a `RelativeNamedInterval` with two `SpelledPitch` values.
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
        let ordinal = Ordinal(steps: steps)!
        let quality = Quality(sanitizedIntervalClass: sanitizedInterval, ordinal: ordinal)
        
        // Init
        self.init(quality, ordinal)
    }
}

extension RelativeNamedInterval.Ordinal: Equatable, Hashable { }
extension RelativeNamedInterval: Equatable, Hashable { }

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

