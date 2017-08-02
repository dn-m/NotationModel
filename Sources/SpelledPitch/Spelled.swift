//
//  Spelled.swift
//  SpelledPitch
//
//  Created by James Bean on 1/9/17.
//
//

/// Interface for single `Pitch`-like types that can have a `PitchSpelling`.
public protocol Spelled {
    
    /// The `PitchSpelling` value for a `Spelled` type.
    var spelling: PitchSpelling { get }
}
