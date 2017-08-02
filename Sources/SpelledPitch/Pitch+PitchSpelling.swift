//
//  Pitch+Pitch.Spelling.swift
//  SpelledPitch
//
//  Created by James Bean on 5/2/16.
//
//

import Pitch

extension Pitch {
    
    // MARK: - Instance Properties
    
    /**
     `true` for `n	atural` spellable `Pitches`. Otherwise `false`.
     
     ```
     Pitch(noteNumber: 60) // => true (.c, .natural)
     Pitch(noteNumber: 68) // => false (.a, .flat) / (.g, .sharp)
     ```
     */
    public var canBeSpelledObjectively: Bool {
        return spellings.any { $0.quarterStep == .natural && $0.eighthStep == .none }
    }
 
    /// All `Pitch.Spelling` structures available for this `Pitch`.
    public var spellings: [Pitch.Spelling] {
        return self.class.spellings
    }
    
    /// - TODO: Encapsulate this logic within `PitchSpellings` `struct`.
    // FIXME: Use single chain of `.filter`s
    public var spellingsWithoutUnconventionalEnharmonics: [Pitch.Spelling] {

        return spellings.lazy
            // c flat
            .filter { !($0.letterName == .c && $0.quarterStep == .flat) }
            // f flat
            .filter { !($0.letterName == .f && $0.quarterStep == .flat) }
            // e sharp
            .filter { !($0.letterName == .e && $0.quarterStep == .sharp) }
            // b sharp
            .filter { !($0.letterName == .b && $0.quarterStep == .sharp) }
            // double flats and sharps
            .filter { !($0.quarterStep == .doubleSharp || $0.quarterStep == .doubleFlat) }
    }
    
    /// The first available `Pitch.Spelling` for this `Pitch`, if present. Otherwise `nil`.
    public var defaultSpelling: Pitch.Spelling {
        return PitchSpellings.defaultSpelling(forPitchClass: self.class)!
    }
    
    /**
     Fineness of `Pitch`.
     - 1.00: half-tone (e.g., c natural, g sharp, etc.)
     - 0.50: quarter-tone (e.g., c quarterShap, g quarterFlat, etc.)
     - 0.25: eighth-tone (e.g., c natural up, q quarterflat down, etc.)
     
     - TODO: make `throw` in the case of a strange resolution (e.g., 60.81356)
     */
    public var resolution: Float {
        if noteNumber.value.truncatingRemainder(dividingBy: 1.0) == 0.0 { return 1.0 }
        else if noteNumber.value.truncatingRemainder(dividingBy: 0.5) == 0.0 { return 0.5 }
        else if noteNumber.value.truncatingRemainder(dividingBy: 0.25) == 0.0 { return 0.25 }
        return 0.0
    }
    
    // MARK: - Instance Methods
    
    
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
    public func spelledWithDefaultSpelling() -> SpelledPitch {
        return try! spelled(with: defaultSpelling)
    }
}
