//
//  PitchSpellingRules.swift
//  SpelledPitch
//
//  Created by James Bean on 9/6/16.
//
//

/*
/// Rule that takes a cost multiplier, and a given input (either a single pitch spelling, or
/// a pair of pitch spellings), and returns a penalty.
typealias Rule<Input> = (Float) -> (Input) -> Float

// MARK: - Node-level rules

/// Avoid double sharp or double flat pitch spellings.
let doubleSharpOrDoubleFlat: Rule<Node> = { costMultiplier in
    return { spelling in abs(spelling.quarterStep.rawValue) == 2 ? 1 : 0 }
}

/// Avoid three quarter sharp and three quarter flat pitch spellings.
let threeQuarterSharpOrThreeQuarterFlat: Rule<Node> = { costMultiplier in
    return { spelling in abs(spelling.quarterStep.rawValue) == 1.5 ? 1 : 0 }
}

/// Avoid b sharp, e sharp, c flat, and f flat pitch spellings.
let badEnharmonic: Rule<Node> = { costMultiplier in
    return { spelling in
        switch (spelling.letterName, spelling.quarterStep) {
        case (.b, .sharp), (.e, .sharp), (.c, .flat), (.f, .flat): return 1 * costMultiplier
        default: return 0
        }
    }
}

/// Avoid pitch spellings that have quarter step and eighth step resolutions.
let quarterStepEighthStepCombination: Rule<Node> = { costMultiplier in
    return { spelling in
        switch (spelling.quarterStep.resolution, abs(spelling.eighthStep.rawValue)) {
        case (.quarterStep, 0.25): return 1
        default: return 0
        }
    }
}

// MARK: - Edge-level rules

/// Avoid unison intervals (this assumes that a unique set of pitch classes in the input).
let unison: Rule<Edge> = { costMultiplier in
    return { (a,b) in a.letterName == b.letterName ? 1 : 0 }
}

/// Avoid augmented or diminished intervals.
let augmentedOrDiminished: Rule<Edge> = { costMultiplier in
    return { (a,b) in
        switch NamedInterval(a,b).quality {
        case NamedInterval.Quality.augmented, NamedInterval.Quality.diminished: return 1
        default: return 0
        }
    }
}

/// Avoid circumstances where the letter name value relationship is not equivalent to the
/// pitch class relationship (e.g., b sharp up, c natural)
let crossover: Rule<Edge> = { costMultiplier in
    return { (a,b) in
        return (a.letterName.steps < b.letterName.steps) != (a.pitchClass < b.pitchClass)
            ? 1
            : 0
    }
}


/// Avoid dyads with sharps and flats.
///
/// - TODO: Consider merging this into augmented / diminished.
let flatSharpIncompatibility: Rule<Edge> = { costMultiplier in
    return { (a,b) in
        return a.quarterStep.direction.rawValue * b.quarterStep.direction.rawValue == -1
            ? 1
            : 0
    }
}

// MARK: - Graph-level rules

/// Avoid up and down eighth step value mixtures.
let eighthStepDirectionIncompatibility: Rule<Edge> = { costMultiplier in
    return { (a,b) in
        switch (a.eighthStep.rawValue, b.eighthStep.rawValue) {
        case (0, _), (_, 0), (-0.25, -0.25), (0.25, 0.25): return 0
        default: return 1
        }
    }
}
*/
