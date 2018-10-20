//
//  Pitch+Pitch.Spelling.swift
//  SpelledPitch
//
//  Created by James Bean on 5/2/16.
//
//

#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

import Pitch

extension Pitch {

    /// Things that can go wrong while applying a `Pitch.Spelling` to a `Pitch`.
    public enum Error: Swift.Error {
        case incompatibleSpelling(Pitch.Spelling,Pitch)
    }

    /// All `Pitch.Spelling` structures available for this `Pitch`.
    public var spellings: [Pitch.Spelling] {
        return self.class.spellings
    }

    /// The first available `Pitch.Spelling` for this `Pitch`, if present. Otherwise `nil`.
    public var defaultSpelling: Pitch.Spelling {
        return Pitch.defaultSpelling(forPitchClass: self.class)!
    }

    /// - Returns: `SpelledPitch` with the given `Pitch.Spelling`,
    /// if the given `Pitch.Spelling` is valid for the `PitchClass` of the given `pitch`.
    ///
    /// - Throws: `Pitch.Spelling.Error.incompatibleSpelling` if the given `spelling` is not
    /// appropriate for this `Pitch`.
    ///
    public func spelled(with spelling: Pitch.Spelling) throws -> SpelledPitch {
        guard spelling.pitchClass == self.class else {
            throw Error.incompatibleSpelling(spelling, self)
        }
        let currentOctave = Int(floor(value.value / 12.0)) - 1
        let octave = currentOctave - reachAroundAdjustment(for: spelling)
        return SpelledPitch(spelling, octave)
    }

    /// - Returns: `SpelledPitch` with the default spelling for this `Pitch`.
    public var spelledWithDefaultSpelling: SpelledPitch {
        return try! spelled(with: defaultSpelling)
    }
}
