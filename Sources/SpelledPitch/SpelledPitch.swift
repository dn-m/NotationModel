//
//  SpelledPitch.swift
//  SpelledPitch
//
//  Created by James Bean on 5/1/16.
//
//

#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

import Pitch

public struct SpelledPitch {

    // MARK: - Instance Properties

    /// The `Pitch.Spelling` defining a `SpelledPitch`.
    public let spelling: Pitch.Spelling

    /// The `octave` defining a `SpelledPitch`
    public let octave: Int
}

extension SpelledPitch {

    // MARK: - Type Properties

    /// The `.c` `.natural` nearest to the middle of an 88-key piano.
    public static var middleC: SpelledPitch {
        return .init(Pitch.Spelling(.c), 4)
    }
}

extension SpelledPitch {

    // MARK: - Initializers

    /// Create a `SpelledPitch` with a given `spelling` in displaced by the given `octave`.
    public init(_ spelling: Pitch.Spelling, _ octave: Int = 4) {
        self.spelling = spelling
        self.octave = octave
    }
}

extension SpelledPitch {

    // MARK: - Computed Properties

    /// The `Pitch` value of this `SpelledPitch`.
    public var pitch: Pitch {

        let pitchClass = spelling.pitchClass

        // TODO: Break out function
        var octave: Int {

            let unadjusted = self.octave

            var mustAdjustForC: Bool {
                guard spelling.letterName == .c else { return false }
                if spelling.quarterStep.direction == .down { return true }
                return spelling.quarterStep == .natural && spelling.eighthStep == .down
            }

            var mustAdjustForB: Bool {
                guard spelling.letterName == .b else { return false }
                return spelling.quarterStep == .sharp && spelling.eighthStep.rawValue >= 0
            }

            return mustAdjustForC ? unadjusted - 1 : mustAdjustForB ? unadjusted + 1 : unadjusted
        }

        let octaveDisplacement = Double(octave + 1) * 12

        return .init(noteNumber: NoteNumber(pitchClass.noteNumber.value + octaveDisplacement))
    }
}

extension SpelledPitch: Equatable, Hashable { }

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
        if lhs.octave < rhs.octave { return true }
        if lhs.octave > rhs.octave { return false }
        return lhs.spelling < rhs.spelling
    }
}
