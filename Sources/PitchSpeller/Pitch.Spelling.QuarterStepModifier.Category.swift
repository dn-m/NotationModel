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

    /// Creates a `Pitch.Spelling` values with the given `pitchClass` and the given `tendencies`,
    /// if it is possible. Otherwise, fails as `nil`.
    init?(pitchClass: Pitch.Class, tendencies: TendencyPair) {
        guard
            let category = Pitch.Spelling.Category.category(for: pitchClass),
            let tendencyConverter = category as? TendencyConverting.Type,
            let modifierDirection = tendencyConverter.modifierDirection(for: tendencies)
        else {
            return nil
        }
        self.init(pitchClass: pitchClass, modifierDirection: modifierDirection)
    }
}
