//
//  SpelledDyad.swift
//  SpelledPitch
//
//  Created by James Bean on 5/12/16.
//
//

import Algorithms
import Pitch

/// Dyad of `SpelledPitch` values.
public struct SpelledDyad {
    
    // MARK: - Instance Properties
    
    /// Lower of the two `SpelledPitch` values.
    public let lower: SpelledPitch
    
    /// Higher of the two `SpelledPitch` values.
    public let higher: SpelledPitch
}

extension SpelledDyad {

    // MARK: - Initializers

    /// Creates a `SpelledDyad` with two `SpelledPitch` values.
    public init(_ lower: SpelledPitch, _ higher: SpelledPitch) {
        let (lower, higher) = ordered(lower, higher)
        self.lower = lower
        self.higher = higher
    }
}

extension SpelledDyad {

    // MARK: - Computed Properties

    /// - Returns: `UnorderedSpelledInterval`, which does not retain the objective order of this
    /// `SpelledDyad` nor its octave displacement.
    public var unorderedInterval: UnorderedIntervalDescriptor {
        return UnorderedIntervalDescriptor(lower.spelling, higher.spelling)
    }

    /// - Returns: `CompoundSpelledInterval`, which retains the objective order of this
    /// `SpelledDyad`, though not its octave displacement.
    public var orderedInterval: CompoundIntervalDescriptor {
        return CompoundIntervalDescriptor(lower, higher)
    }
}

extension SpelledDyad: Equatable { }
extension SpelledDyad: Hashable { }
