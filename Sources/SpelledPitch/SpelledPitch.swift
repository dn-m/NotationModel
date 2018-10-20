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

    /// The `c natural` nearest to the middle of an 88-key piano.
    public static var middleC: SpelledPitch {
        return .init(Pitch.Spelling.middleC, 4)
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

//extension SpelledPitch {
//
//    /// - Returns: The `Pitch` value represented by this `SpelledPitch`.
//    public var pitch: Pitch {
//        let octaves = Pitch(NoteNumber(value: Double((octave + 1) * 12)))
//        return Pitch(spelling.pitchClass) + octaves
//    }
//}
//
//extension SpelledPitch {
//
//    /// - Returns: The `Pitch` value represented by this `SpelledPitch`.
//    public var pitch: Pitch {
//        let pitchClass = spelling.pitchClass
//        let octave = self.octave + reachAroundAdjustment(for: spelling)
//        let octaveDisplacement = Double(octave + 1) * 12
//        return Pitch(NoteNumber(value: pitchClass.value.value + octaveDisplacement))
//    }
//}

extension SpelledPitch {

    // MARK: - Computed Properties

    /// - Returns: The `Pitch` value represented by this `SpelledPitch`.
    public var pitch: Pitch {
        let octave = self.octave + reachAroundAdjustment(for: spelling)
        let octaveDisplacement = Double(octave + 1) * 12
        return Pitch(spelling.pitchClass) + Pitch(octaveDisplacement)
    }
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

//extension SpelledPitch {
//
//    // MARK: - EDO12
//
//    /// Creates a `SpelledPitch` in the `EDO12` `TuningSystem` with a `SpelledPitch` from the
//    /// `EDO24` `TuningSystem`.
//    public init(_ edo24: SpelledPitch<EDO24>) {
//        self.init(spelling: Pitch.Spelling(edo24.spelling), octave: edo24.octave)
//    }
//
//    /// Creates a `SpelledPitch` in the `EDO12` `TuningSystem` with a `SpelledPitch` from the
//    /// `EDO48` `TuningSystem`.
//    public init(_ edo48: SpelledPitch<EDO48>) {
//        self.init(spelling: Pitch.Spelling(edo48.spelling), octave: edo48.octave)
//    }
//}
//
//extension SpelledPitch where Tuning == EDO24 {
//
//    // MARK: - EDO24
//
//    /// Creates a `SpelledPitch` in the `EDO24` `TuningSystem` with a `SpelledPitch` from the
//    /// `EDO12` `TuningSystem`.
//    public init(_ edo12: SpelledPitch<EDO12>) {
//        self.init(spelling: Pitch.Spelling(edo12.spelling), octave: edo12.octave)
//    }
//
//    /// Creates a `SpelledPitch` in the `EDO24` `TuningSystem` with a `SpelledPitch` from the
//    /// `EDO48` `TuningSystem`.
//    public init(_ edo48: SpelledPitch<EDO48>) {
//        self.init(spelling: Pitch.Spelling(edo48.spelling), octave: edo48.octave)
//    }
//}
//
//extension SpelledPitch where Tuning == EDO48 {
//
//    // MARK: - EDO48
//
//    /// Creates a `SpelledPitch` in the `EDO48` `TuningSystem` with a `SpelledPitch` from the
//    /// `EDO12` `TuningSystem`.
//    public init(_ edo12: SpelledPitch<EDO12>) {
//        self.init(spelling: Pitch.Spelling(edo12.spelling), octave: edo12.octave)
//    }
//
//    /// Creates a `SpelledPitch` in the `EDO24` `TuningSystem` with a `SpelledPitch` from the
//    /// `EDO12` `TuningSystem`.
//    public init(_ edo24: SpelledPitch<EDO24>) {
//        self.init(spelling: Pitch.Spelling(edo24.spelling), octave: edo24.octave)
//    }
//}
