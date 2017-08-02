////
////  Pitch+Pitch.Spelling.swift
////  SpelledPitch
////
////  Created by James Bean on 5/2/16.
////
////

import Pitch

extension Pitch {

    /// All `Pitch.Spelling` structures available for this `Pitch`.
    public var spellings: [Pitch.Spelling] {
        return self.class.spellings
    }

    /// The first available `Pitch.Spelling` for this `Pitch`, if present. Otherwise `nil`.
    public var defaultSpelling: Pitch.Spelling {
        return PitchSpellings.defaultSpelling(forPitchClass: self.class)!
    }

    /// - returns: `SpelledPitch` with the given `Pitch.Spelling`,
    /// if the given `Pitch.Spelling` is valid for the `PitchClass` of the given `pitch`.
    ///
    /// - throws: `Pitch.Spelling.Error.InvalidPitchSpellingForPitch` if the given `spelling` is
    /// not appropriate for this `Pitch`.
    ///
    public func spelled(with spelling: Pitch.Spelling) throws -> SpelledPitch {

        guard spelling.isValid(for: self) else {
            throw Pitch.Spelling.Error.invalidSpelling(self, spelling)
        }

        return SpelledPitch(pitch: self, spelling: spelling)
    }

    /// - returns: `SpelledPitch` with the default spelling for this `Pitch`.
    public var spelledWithDefaultSpelling: SpelledPitch {
        return try! spelled(with: defaultSpelling)
    }
}
