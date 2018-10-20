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

extension UnorderedIntervalDescriptor {

    /// Creates a `UnorderedSpelledInterval` with two `SpelledPitch` values.
    public init(_ a: Pitch.Spelling, _ b: Pitch.Spelling) {
        let (a,b) = ordered(a,b)
        let (interval, steps) = intervalAndSteps(a,b)
        self.init(interval: interval, steps: steps)
    }
}

/// - Returns: The two `Pitch.Spelling` values such that the difference between `b` and `a` is less
/// that the difference between `a` and `b`.
private func ordered (_ a: Pitch.Spelling, _ b: Pitch.Spelling)
    -> (Pitch.Spelling,Pitch.Spelling)
{
    let (a,b,_) = swapped(a, b) { mod(steps(a,b), 7) > mod(steps(b,a), 7) }
    return (a,b)
}

/// - Returns: The steps and interval between the two given `Pitch.Spelling` values.
private func intervalAndSteps(_ a: Pitch.Spelling, _ b: Pitch.Spelling) -> (Double,Int) {
    return (interval(a,b), steps(a,b))
}

/// - Returns: The amount of semitones between the two given `Pitch.Spelling` values.
private func interval(_ a: Pitch.Spelling, _ b: Pitch.Spelling) -> Double {
    return OrderedInterval(a.pitchClass,b.pitchClass).value.value
}

/// - Returns: The amount of steps between the two given `Pitch.Spelling` values.
private func steps(_ a: Pitch.Spelling, _ b: Pitch.Spelling) -> Int {
    return mod(b.letterName.steps - a.letterName.steps, 7)
}

extension UnorderedIntervalDescriptor.Ordinal: SpelledPitchConvertingIntervalOrdinal {

    /// - Returns: The distance in semitones from an iedal interval at which point an interval
    /// quality becomes diminished or augmented for a given `Ordinal`.
    public var platonicThreshold: Double {
        switch self {
        case .perfect:
            return 1
        case .imperfect:
            return 1.5
        }
    }

    /// - Returns: The "ideal" interval for the given amount of scalar steps between two
    /// `SpelledPitch` values.
    ///
    /// For example, perfect intervals have a single ideal spelling, whereas imperfect intervals
    /// could be spelled two different ways.
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
