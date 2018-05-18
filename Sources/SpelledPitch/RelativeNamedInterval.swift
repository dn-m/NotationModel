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
public struct RelativeNamedInterval: NamedInterval, Equatable {
    
    // MARK: - Associated Types
    
    /// `PitchType` with level of ordering necessary to construct a `RelativeNamedInterval`.
    public typealias PitchType = Pitch.Class
    
    /// Type describing the quality of a `NamedInterval`-conforming type.
    public typealias Quality = NamedIntervalQuality
    
    // MARK: - Nested Types

    public enum RelativeOrdinal {

        public enum PerfectOrdinal {

            // convert to general ordinal
            var ordinal: Ordinal {
                switch self {
                case .unison:
                    return .unison
                case .fourth:
                    return .fourth
                }
            }

            case unison
            case fourth
        }

        public enum ImperfectOrdinal {

            // convert to general ordinal
            var ordinal: Ordinal {
                switch self {
                case .second:
                    return .second
                case .third:
                    return .third
                }
            }

            case second
            case third
        }

        case perfect(PerfectOrdinal)
        case imperfect(ImperfectOrdinal)
    }

    /// Type describing ordinality of a `RelativeNamedInterval`.
    public enum Ordinal: Int, NamedIntervalOrdinal {
        
        // MARK: Ordinal classes
        
        /// Set of `perfect` interval ordinals (`unison`, `fourth`)
        public static let perfects: Set<Ordinal> = [.unison, .fourth]
        
        /// Set of `imperfect` interval ordinals (`second`, `third`)
        public static var imperfects: Set<Ordinal> = [.second, .third]
        
        // MARK: Ordinal instances
        
        /// Unison.
        case unison = 0
        
        /// Second.
        case second = 1
        
        /// Third.
        case third = 2
        
        /// Fourth.
        case fourth = 3

        public init?(steps: Int) {
            self.init(rawValue: steps)
        }
    }

    // MARK: - Type Properties

    /// Unison interval.
    public static var unison: RelativeNamedInterval {
        return .init(.perfect(.perfect), .unison)
    }
    
    // MARK: - Instance Properties
    
    /// Ordinal value of a `RelativeNamedInterval` (`unison`, `second`, `third`, `fourth`).
    public let ordinal: Ordinal
    
    /// Quality value of a `RelativeNamedInterval`
    /// (`diminished`, `minor`, `perfect`, `major`, `augmented`).
    public let quality: Quality
    
    // MARK: - Initializers

    public init(_ quality: Quality.PerfectQuality, _ ordinal: RelativeOrdinal.PerfectOrdinal) {
        self.quality = .perfect(.perfect)
        self.ordinal = ordinal.ordinal
    }

    public init(_ quality: Quality.ImperfectQuality, _ ordinal: RelativeOrdinal.ImperfectOrdinal) {
        self.quality = .imperfect(quality)
        self.ordinal = ordinal.ordinal
    }

    public init(_ quality: Quality.AugmentedOrDiminishedQuality.AugmentedOrDiminished, _ ordinal: RelativeOrdinal.ImperfectOrdinal) {
        self.quality = .augmentedOrDiminished(.init(.single, quality))
        self.ordinal = ordinal.ordinal
    }

    public init(_ quality: Quality.AugmentedOrDiminishedQuality.AugmentedOrDiminished, _ ordinal: RelativeOrdinal.PerfectOrdinal) {
        self.quality = .augmentedOrDiminished(.init(.single, quality))
        self.ordinal = ordinal.ordinal
    }

    public init(
        _ degree: Quality.AugmentedOrDiminishedQuality.Degree,
        _ quality: Quality.AugmentedOrDiminishedQuality.AugmentedOrDiminished,
        _ ordinal: RelativeOrdinal.ImperfectOrdinal
    )
    {
        self.quality = .augmentedOrDiminished(.init(degree, quality))
        self.ordinal = ordinal.ordinal
    }

    public init(
        _ degree: Quality.AugmentedOrDiminishedQuality.Degree,
        _ quality: Quality.AugmentedOrDiminishedQuality.AugmentedOrDiminished,
        _ ordinal: RelativeOrdinal.PerfectOrdinal
    )
    {
        self.quality = .augmentedOrDiminished(.init(degree, quality))
        self.ordinal = ordinal.ordinal
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

