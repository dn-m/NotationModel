//
//  SpelledChord.swift
//  SpelledPitch
//
//  Created by James Bean on 10/23/18.
//

import DataStructures
import Pitch

public struct SpelledChord {

    // MARK: - Instance Properties

    /// The `SpelledPitch` values which comprise this `SpelledChord`.
    let pitches: [SpelledPitch]
}

extension SpelledChord {

    // MARK: - Initializers

    /// Creates a `SpelledChord` with the given `pitches.
    public init(_ pitches: [SpelledPitch]) {
        self.pitches = pitches
    }

    /// Creates a `SpelledChord` with the given `bass` pitch and the given `chordDescriptor`.
    public init(_ bass: SpelledPitch, _ chordDescriptor: ChordDescriptor) {
        self.pitches = [bass] + chordDescriptor.map { bass + $0 }
    }
}

extension SpelledChord: RandomAccessCollectionWrapping {

    // MARK: - RandomAccessCollectionWrapping

    /// The `RandomAccessCollection` base of a `SpelledChord`.
    public var base: [SpelledPitch] {
        return pitches
    }
}

extension SpelledChord: ExpressibleByArrayLiteral {

    // MARK: - ExpressibleByArrayLiteral

    /// Creates a `SpelledChord` with the array literal of `SpelledPitch` values.
    public init(arrayLiteral pitches: SpelledPitch...) {
        self.init(pitches)
    }
}
