//
//  UnspelledPitchItem.swift
//  PitchSpeller
//
//  Created by James Bean on 6/6/18.
//

import Pitch

/// A `Pitch.Class` wrapped up with an identifier.
struct UnspelledPitchItem: Hashable {
    let identifier: Int
    let pitchClass: Pitch.Class
}
