//
//  PitchSpellingGraph.swift
//  SpelledPitch
//
//  Created by James Bean on 9/6/16.
//
//

import SpelledPitch

// MARK: - Typealiases

/// Single `PitchSpelling` value.
typealias Node = PitchSpelling

/// Pair of `PitchSpelling` values.
typealias Edge = (PitchSpelling, PitchSpelling)

/// All `PitchSpelling` values comprising a graph.
typealias Graph = [PitchSpelling]
