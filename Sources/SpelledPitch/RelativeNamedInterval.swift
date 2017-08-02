//
//  RelativeNamedInterval.swift
//  SpelledPitch
//
//  Created by James Bean on 1/8/17.
//
//

import Structure // use Bitwise
import Math
import Pitch

/// Named intervals between two `SpelledPitch` values that does not honor order between
/// `SpelledPitch` values.
public struct RelativeNamedInterval: NamedInterval {
    
    // MARK: - Associated Types
    
    /// `PitchType` with level of ordering necessary to construct a `RelativeNamedInterval`.
    public typealias PitchType = Pitch.Class
    
    /// Type describing the quality of a `NamedInterval`-conforming type.
    public typealias Quality = NamedIntervalQuality
    
    // MARK: - Nested Types
    
    /// Type describing ordinality of a `RelativeNamedInterval`.
    public struct Ordinal: NamedIntervalOrdinal {
        
        // MARK: - Cases
        
        // MARK: Ordinal classes
        
        /// Set of `perfect` interval ordinals (`unison`, `fourth`)
        public static let perfects: Ordinal = [unison, fourth]
        
        /// Set of `imperfect` interval ordinals (`second`, `third`)
        public static var imperfects: Ordinal = [second, third]
        
        // MARK: Ordinal instances
        
        /// Unison.
        public static var unison = Ordinal(rawValue: 1 << 0)
        
        /// Second.
        public static var second = Ordinal(rawValue: 1 << 1)
        
        /// Third.
        public static var third = Ordinal(rawValue: 1 << 2)
        
        /// Fourth.
        public static var fourth = Ordinal(rawValue: 1 << 3)
        
        // MARK: - Instance Properties
        
        /// Amount of options contained herein.
        public var optionsCount: Int {
            return 4
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
        
        /// Raw value.
        public let rawValue: Int
        
        /// Create a `RelativeNamedInterval` with a given `rawValue`.
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
    
    // MARK: - Instance Properties
    
    /// Ordinal value of a `RelativeNamedInterval` (`unison`, `second`, `third`, `fourth`).
    public let ordinal: Ordinal
    
    /// Quality value of a `RelativeNamedInterval`
    /// (`diminished`, `minor`, `perfect`, `major`, `augmented`).
    public let quality: Quality
    
    // MARK: - Initializers
    
    /// Create a `RelativeNamedInterval` with a given `quality` and `ordinal`.
    ///
    /// **Example:**
    /// ```Swift
    /// let minorSecond = RelativeNamedInterval(.minor, .second)
    /// let augmentedSixth = RelativeNamedInterval(.relative, .sixth)
    /// ```
    public init(_ quality: Quality, _ ordinal: Ordinal) {
        
        guard areValid(quality, ordinal) else {
            fatalError("Cannot create an RelativeNamedInterval with \(quality) and \(ordinal)")
        }
        
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
        let ordinal = Ordinal(steps: steps)
        let quality = Quality(sanitizedIntervalClass: sanitizedInterval, ordinal: ordinal)
        
        // Init
        self.init(quality, ordinal)
    }
}

// FIXME: Get rid of `_ =` with update in Collections API
private func ordered (_ a: SpelledPitchClass, _ b: SpelledPitchClass)
    -> (SpelledPitchClass, SpelledPitchClass)
{
    let (a,b,_) = swapped(a, b, if: { mod(steps(a,b), 7) > mod(steps(b,a), 7) })
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

/// Wraps around 7
private func steps(_ a: SpelledPitchClass, _ b: SpelledPitchClass) -> Int {
    return mod(b.spelling.letterName.steps - a.spelling.letterName.steps, 7)
}

