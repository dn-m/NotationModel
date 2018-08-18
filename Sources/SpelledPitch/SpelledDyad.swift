//
//  SpelledDyad.swift
//  SpelledPitch
//
//  Created by James Bean on 5/12/16.
//
//

import Algorithms

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

    /// Create a `SpelledDyad` with two `SpelledPitch` values.
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
    public var unorderedInterval: UnorderedSpelledInterval {
        return UnorderedSpelledInterval(lower.spelling, higher.spelling)
    }

    /// - Returns: `OrderedSpelledInterval`, which retains the objective order of this
    /// `SpelledDyad`, though not its octave displacement.
    //
    // FIXME: Return `CompoundSpelledInterval`.
    public var orderedInterval: OrderedSpelledInterval {
        fatalError()
    }
}

extension SpelledDyad: Equatable, Hashable { }
