//
//  Spelled.swift
//  SpelledPitch
//
//  Created by James Bean on 1/9/17.
//
//

import Pitch

/// Interface for single `Pitch`-like types that can have a `Pitch.Spelling`.
public protocol Spelled {
    
    /// The `Pitch.Spelling` value for a `Spelled` type.
    var spelling: Pitch.Spelling { get }
}
