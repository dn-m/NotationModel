//
//  PitchSpellingGraph.swift
//  SpelledPitch
//
//  Created by James Bean on 9/6/16.
//
//

import Pitch
import SpelledPitch

// MARK: - Typealiases

/// Single `Pitch.Spelling` value.
typealias Node = Pitch.Spelling

/// Pair of `Pitch.Spelling` values.
typealias Edge = (Pitch.Spelling, Pitch.Spelling)

/// All `Pitch.Spelling` values comprising a graph.
typealias Graph = [Pitch.Spelling]
