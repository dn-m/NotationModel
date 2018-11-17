//
//  SpelledPitch.swift
//  SpelledPitch
//
//  Created by James Bean on 5/1/16.
//
//

import Pitch

/// A `Pitch.Spelling` in a specific octave.
public struct SpelledPitch {

    // MARK: - Instance Properties

    /// The `Pitch.Spelling` defining a `SpelledPitch`.
    public let spelling: Pitch.Spelling

    /// The `octave` defining a `SpelledPitch`
    public let octave: Int
}

extension SpelledPitch {

    // MARK: - Static Properties

    /// The `c natural` nearest to the middle of an 88-key piano.
    public static var middleC: SpelledPitch {
        return .init(.c, 4)
    }
}

extension SpelledPitch {

    // MARK: - Initializers

    /// Creates a `SpelledPitch` with a given `spelling` in displaced by the given `octave`.
    public init(_ spelling: Pitch.Spelling, _ octave: Int = 4) {
        self.spelling = spelling
        self.octave = octave
    }
}

extension SpelledPitch {

    // MARK: - Computed Properties

    /// - Returns: The `Pitch` value represented by this `SpelledPitch`.
    public var pitch: Pitch {
        let octave = self.octave + reachAroundAdjustment(for: spelling)
        let octaveDisplacement = Double(octave + 1) * 12
        return Pitch(spelling.pitchClass) + Pitch(octaveDisplacement)
    }
}

extension OrderedIntervalDescriptor.Ordinal {

    // FIXME: Harmonize with `platonic` universe.
    var idealInterval: Double {
        switch self {
        case .perfect(let perfect):
            switch perfect {
            case .unison: return 0
            case .fourth: return 5
            case .fifth: return 7
            }
        case .imperfect(let imperfect):
            switch imperfect {
            case .second: return 1.5
            case .third: return 3.5
            case .sixth: return 8.5
            case .seventh: return 10.5
            }
        }
    }
}

extension OrderedIntervalDescriptor {
    public var semitones: Double {
        return ordinal.idealInterval + quality.adjustment
    }
}

extension OrderedIntervalDescriptor.Direction {
    // FIXME: Add to actual definition
    var rawValue: Int {
        return self == .ascending ? 1 : -1
    }
}

extension SpelledPitch {

    // MARK: - Instance Methods

    /// - Returns: A `SpelledPitch` which is displaced by the given `interval`.
    public func displaced(by interval: OrderedIntervalDescriptor) -> SpelledPitch {

        // If descending, solve the problem for the inverse interval, then correct after
        let originalInterval = interval
        let interval = originalInterval.direction == .descending
            ? originalInterval.inverse
            : originalInterval

        let realSpellingSemitones = spelling.pitchClass.value.value
        let idealSpellingSteps = spelling.letterName.steps
        let realIntervalSemitones = interval.semitones
        let idealIntervalSteps = interval.ordinal.steps
        let realSemitonesSum = realSpellingSemitones + realIntervalSemitones
        let idealStepsSum = Double((idealSpellingSteps + idealIntervalSteps) % 7)
        let idealStepsPosition = semitonesBySteps[idealStepsSum]!
        let offset = (Int(realSemitonesSum) % 12) - idealStepsPosition
        let modifier = Pitch.Spelling.Modifier.Pythagorean(offset)
        let letterName = spelling.letterName.displaced(by: interval.ordinal.steps)

        // Manage octave
        let octaveDelta = Int(realSemitonesSum / 12)
        let octave = self.octave + octaveAdjustment(octaveDelta, for: originalInterval.direction)
        return SpelledPitch(Pitch.Spelling(letterName, modifier), octave)
    }

    /// - Returns: A `SpelledPitch` which is displaced by the given `interval`.
    public func displaced(by interval: CompoundIntervalDescriptor) -> SpelledPitch {
        let result = self.displaced(by: interval.interval)
        let octaveDelta = interval.interval.direction.rawValue * interval.octaveDisplacement
        return SpelledPitch(result.spelling, result.octave + octaveDelta)
    }
}

/// - Returns: A `SpelledPitch` which resultant from displacing the left-hand value by the right-
/// hand value.
public func + (lhs: SpelledPitch, rhs: CompoundIntervalDescriptor) -> SpelledPitch {
    return lhs.displaced(by: rhs)
}

/// - Returns: A `SpelledPitch` which resultant from displacing the right-hand value by the left-
/// hand value.
public func + (lhs: CompoundIntervalDescriptor, rhs: SpelledPitch) -> SpelledPitch {
    return rhs.displaced(by: lhs)
}

func octaveAdjustment(_ delta: Int, for direction: OrderedIntervalDescriptor.Direction) -> Int {
    return direction == .ascending ? delta : delta - 1
}

extension SpelledPitch: Equatable { }
extension SpelledPitch: Hashable { }

extension SpelledPitch: Comparable {

    /// - Returns: `true` if the `pitch` value of the `SpelledPitch` value on the left is less than
    /// that of the `SpelledPitch` value on the right. Otherwise, `false`.
    ///
    /// - Note: In the case that both values are in the same octave, `true` is returned if the
    /// spelling of the `SpelledPitch` value on the left is less than that of the `SpelledPitch` on
    /// the right. This manages extreme scenarios such as (c#, dbb), which should have a named
    /// interval of a double diminished second, not a double augmented seventh.
    ///
    public static func < (lhs: SpelledPitch, rhs: SpelledPitch) -> Bool {
        if lhs.octave == rhs.octave { return lhs.spelling < rhs.spelling }
        return lhs.octave < rhs.octave
    }
}

/// - Returns: The amount to update the octave when calculating the `pitch` value of a
/// `SpelledPitch`, in the case that a `b sharp up` or `c quarter flat down`.
func reachAroundAdjustment (for spelling: Pitch.Spelling) -> Int {
    if spelling.letterName == .c && spelling.modifier.adjustment < 0 { return -1 }
    if spelling.letterName == .b && spelling.modifier.adjustment >= 1 { return 1 }
    return 0
}

let semitonesBySteps = [
    0.0: 0,
    0.5: 1,
    1.0: 2,
    1.5: 3,
    2.0: 4,
    3.0: 5,
    3.5: 6,
    4.0: 7,
    4.5: 8,
    5.0: 9,
    5.5: 10,
    6.0: 11
]
