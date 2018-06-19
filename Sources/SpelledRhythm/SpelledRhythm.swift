//
//  SpelledRhythm.swift
//  SpelledRhythm
//
//  Created by James Bean on 6/18/18.
//

import Rhythm

/// A `Rhythm` and its abstract representation.
public struct SpelledRhythm <T> {
    let rhythm: Rhythm<T>
    let spelling: Rhythm<T>.Spelling
}
