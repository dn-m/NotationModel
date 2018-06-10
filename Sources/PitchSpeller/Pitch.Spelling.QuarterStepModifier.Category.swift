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

extension Wetherfield.PitchSpeller {

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
}
