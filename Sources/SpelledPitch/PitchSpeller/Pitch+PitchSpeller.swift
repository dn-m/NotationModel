//
//  Pitch+PitchSpeller.swift
//  PitchSpeller
//
//  Created by James Bean on 8/2/17.
//

import Pitch

extension Pitch {

    // MARK: - Instance Properties

    /// `true` for `n    atural` spellable `Pitches`. Otherwise `false`.
    ///
    ///     Pitch(noteNumber: 60) // => true (.c, .natural)
    ///     Pitch(noteNumber: 68) // => false (.a, .flat) / (.g, .sharp)
    ////
    public var canBeSpelledObjectively: Bool {
        return spellings.contains { $0.quarterStep == .natural && $0.eighthStep == .none }
    }


    /// - TODO: Encapsulate this logic within `PitchSpellings` `struct`.
    // FIXME: Move to PitchSpeller
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
}
