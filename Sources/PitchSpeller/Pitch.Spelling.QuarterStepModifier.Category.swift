//
//  NamedIntervalQuality.Category.swift
//  PitchSpeller
//
//  Created by James Bean on 5/22/18.
//

import Pitch
import SpelledPitch
import DataStructures

// Wetherfield Pitch Speller, Thesis pg. 38

extension Wetherfield {

    struct PitchSpeller {
        let unspelledPitchSequence: UnspelledPitchSequence
    }
}

internal enum Tendency: Int {
    case down = 0
    case up = 1
}

internal struct TendencyPair: Equatable, Hashable {

    let up: Tendency
    let down: Tendency

    init(_ up: Tendency, _ down: Tendency) {
        self.up = up
        self.down = down
    }

    init(_ tuple: (Tendency, Tendency)) {
        self.up = tuple.0
        self.down = tuple.1
    }
}

extension Pitch.Spelling {
    init?(pitchClass: Pitch.Class, tendencies: TendencyPair) {
        guard
            let category = Pitch.Spelling.Category.category(for: pitchClass),
            let tendencyConverter = category as? TendencyConvertible.Type,
            let modifierDirection = tendencyConverter.modifierDirection(for: tendencies)
        else {
            return nil
        }
        self.init(pitchClass: pitchClass, modifierDirection: modifierDirection)
    }
}

extension Wetherfield.PitchSpeller {

    static func pitchSpelling(for pitchClass: Pitch.Class, with tendencies: TendencyPair)
        -> Pitch.Spelling?
    {
        guard
            let category = Pitch.Spelling.Category.category(for: pitchClass),
            let tendencyConverter = category as? TendencyConvertible.Type,
            let modifierDirection = tendencyConverter.modifierDirection(for: tendencies)
        else {
            return nil
        }
        return Pitch.Spelling(pitchClass: pitchClass, modifierDirection: modifierDirection)
    }


}
