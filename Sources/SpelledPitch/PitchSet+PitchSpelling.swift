//
//  PitchSet+Pitch.Spelling.swift
//  SpelledPitch
//
//  Created by James Bean on 1/19/17.
//
//

import Pitch

extension Set where Element == Pitch {
    
    /// - returns: A `SpelledPitchSet` with the values of self spelled with the default
    /// `Pitch.Spelling` value.
    public func spelledWithDefaultSpelling() -> Set<SpelledPitch> {
        return Set<SpelledPitch>(map { $0.spelledWithDefaultSpelling() })
    }
}

