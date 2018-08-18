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

public struct SpelledPitch <Temperament: PitchTemperament>  {

    // MARK: - Instance Properties

    /// The `Pitch.Spelling` defining a `SpelledPitch`.
    public let spelling: Pitch.Spelling<Temperament>

    /// The `octave` defining a `SpelledPitch`
    public let octave: Int
}

extension SpelledPitch where Temperament == EDO12 {

    // MARK: - Type Properties

    /// The `.c` `.natural` nearest to the middle of an 88-key piano.
    public static var middleC: SpelledPitch<EDO12> {
        return .init(Pitch.Spelling(.c), 4)
    }
}

extension SpelledPitch where Temperament == EDO24 {

    // MARK: - Type Properties

    /// The `.c` `.natural` nearest to the middle of an 88-key piano.
    public static var middleC: SpelledPitch<EDO24> {
        return .init(Pitch.Spelling(.c), 4)
    }
}

extension SpelledPitch where Temperament == EDO48 {

    // MARK: - Type Properties

    /// The `.c` `.natural` nearest to the middle of an 88-key piano.
    public static var middleC: SpelledPitch<EDO48> {
        return .init(Pitch.Spelling(.c), 4)
    }
}

extension SpelledPitch {

    // MARK: - Initializers

    /// Create a `SpelledPitch` with a given `spelling` in displaced by the given `octave`.
    public init(_ spelling: Pitch.Spelling<Temperament>, _ octave: Int = 4) {
        self.spelling = spelling
        self.octave = octave
    }
}

extension SpelledPitch where Temperament == EDO12 {
    public var pitch: Pitch {
        let noteNumber = NoteNumber(spelling.pitchClass.noteNumber.value + Double(octave + 1) * 12)
        return .init(noteNumber: noteNumber)
    }
}

extension SpelledPitch where Temperament == EDO24 {

    public var pitch: Pitch {
        let pitchClass = spelling.pitchClass
        let octave = self.octave + reachAroundAdjustment(for: spelling)
        let octaveDisplacement = Double(octave + 1) * 12
        return .init(noteNumber: NoteNumber(pitchClass.noteNumber.value + octaveDisplacement))
    }
}

extension SpelledPitch where Temperament == EDO48 {

    // MARK: - Computed Properties

    /// The `Pitch` value of this `SpelledPitch`.
    public var pitch: Pitch {
        let pitchClass = spelling.pitchClass
        let octave = self.octave + reachAroundAdjustment(for: spelling)
        let octaveDisplacement = Double(octave + 1) * 12
        return .init(noteNumber: NoteNumber(pitchClass.noteNumber.value + octaveDisplacement))
    }
}

/// - Returns: The amount to update the octave when calculating the `pitch` value of a
/// `SpelledPitch`, in the case that a `b sharp up` or `c quarter flat down`.
func reachAroundAdjustment <T: PitchTemperament> (for spelling: Pitch.Spelling<T>) -> Int {
    if spelling.letterName == .c && spelling.modifier.adjustment < 0 { return -1 }
    if spelling.letterName == .b && spelling.modifier.adjustment >= 1 { return 1 }
    return 0
}

extension SpelledPitch: Equatable where Temperament.Modifier: Equatable { }
extension SpelledPitch: Hashable where Temperament.Modifier: Hashable { }

extension SpelledPitch: Comparable where Temperament.Modifier: Comparable {

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

extension SpelledPitch where Temperament == EDO48 {
    public init(_ edo12: SpelledPitch<EDO12>) {
        self.init(spelling: Pitch.Spelling(edo12.spelling), octave: edo12.octave)
    }

    public init(_ edo24: SpelledPitch<EDO24>) {
        self.init(spelling: Pitch.Spelling(edo24.spelling), octave: edo24.octave)
    }
}
