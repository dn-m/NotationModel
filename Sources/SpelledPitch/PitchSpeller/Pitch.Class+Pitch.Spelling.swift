//
//  Pitch.Class+Pitch.Spelling.swift
//  SpelledPitch
//
//  Created by James Bean on 5/26/16.
//
//

import Pitch

extension Pitch.Class {

    /// All `Pitch.Spelling` structures available for this `PitchClass`.
    public var spellings: [Pitch.Spelling<EDO48>] {
        return EDO48.spellings(forPitchClass: self) ?? []
    }

    /// Spelling priority of a `PitchClass`. Lower values indicate higher priority.
    public var spellingPriority: Int? {
        return UnorderedInterval<Pitch.Class>(noteNumber: noteNumber).spellingPriority
    }
}
