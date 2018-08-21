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

/// A `Pitch.Spelling` in a specific octave.
public struct SpelledPitch <Tuning: TuningSystem> {

    // MARK: - Instance Properties

    /// The `Pitch.Spelling` defining a `SpelledPitch`.
    public let spelling: Pitch.Spelling<Tuning>

    /// The `octave` defining a `SpelledPitch`
    public let octave: Int
}

extension SpelledPitch where Tuning: EDO {

    /// The `c natural` nearest to the middle of an 88-key piano.
    public static var middleC: SpelledPitch<Tuning> {
        return .init(Pitch.Spelling.middleC, 4)
    }
}

extension SpelledPitch {

    // MARK: - Initializers

    /// Creates a `SpelledPitch` with a given `spelling` in displaced by the given `octave`.
    public init(_ spelling: Pitch.Spelling<Tuning>, _ octave: Int = 4) {
        self.spelling = spelling
        self.octave = octave
    }
}

extension SpelledPitch where Tuning == EDO12 {

    /// - Returns: The `Pitch` value represented by this `SpelledPitch`.
    public var pitch: Pitch {
        let octaves = Pitch(NoteNumber(value: Double((octave + 1) * 12)))
        return Pitch(spelling.pitchClass) + octaves
    }
}

extension SpelledPitch where Tuning == EDO24 {

    /// - Returns: The `Pitch` value represented by this `SpelledPitch`.
    public var pitch: Pitch {
        let pitchClass = spelling.pitchClass
        let octave = self.octave + reachAroundAdjustment(for: spelling)
        let octaveDisplacement = Double(octave + 1) * 12
        return Pitch(NoteNumber(value: pitchClass.value.value + octaveDisplacement))
    }
}

extension SpelledPitch where Tuning == EDO48 {

    // MARK: - Computed Properties

    /// - Returns: The `Pitch` value represented by this `SpelledPitch`.
    public var pitch: Pitch {
        let octave = self.octave + reachAroundAdjustment(for: spelling)
        let octaveDisplacement = Double(octave + 1) * 12
        return Pitch(spelling.pitchClass) + Pitch(octaveDisplacement)
    }
}

extension SpelledPitch: Equatable where Tuning.Modifier: Equatable { }
extension SpelledPitch: Hashable where Tuning.Modifier: Hashable { }

extension SpelledPitch: Comparable where Tuning.Modifier: Comparable {

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
func reachAroundAdjustment <T: TuningSystem> (for spelling: Pitch.Spelling<T>) -> Int {
    if spelling.letterName == .c && spelling.modifier.adjustment < 0 { return -1 }
    if spelling.letterName == .b && spelling.modifier.adjustment >= 1 { return 1 }
    return 0
}

extension SpelledPitch where Tuning == EDO48 {

    // MARK: - EDO48

    /// Creates a `SpelledPitch` in the `EDO48` `TuningSystem` with a `SpelledPitch` from the
    /// `EDO12` `TuningSystem`.
    public init(_ edo12: SpelledPitch<EDO12>) {
        self.init(spelling: Pitch.Spelling(edo12.spelling), octave: edo12.octave)
    }

    /// Creates a `SpelledPitch` in the `EDO24` `TuningSystem` with a `SpelledPitch` from the
    /// `EDO12` `TuningSystem`.
    public init(_ edo24: SpelledPitch<EDO24>) {
        self.init(spelling: Pitch.Spelling(edo24.spelling), octave: edo24.octave)
    }
}
