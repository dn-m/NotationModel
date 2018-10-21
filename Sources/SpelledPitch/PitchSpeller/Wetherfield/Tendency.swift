//
//  Tendency.swift
//  PitchSpeller
//
//  Created by James Bean on 5/22/18.
//

import Pitch

/// One of two values encoded in a Wetherfield `FlowNetwork`. Each provides a tendency `up`, or
/// `down` for the purposes of spelling an unspelled pitch in a given musical context.
internal enum Tendency: Int {
    case down = 0
    case up = 1
}

/// A pair of `Tendency` values. Wrapped up here for the purposes of `Equatable` and `Hashable`
/// synthesizing.
struct TendencyPair: Hashable {

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

    /// Creates a `Pitch.Spelling` value with the given `pitchClass` and the given `tendencies`,
    /// which are resultant from the Wetherfield-encoded and -decoded `FlowNetwork`, if it is
    /// possible. Otherwise, returns `nil`.
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
