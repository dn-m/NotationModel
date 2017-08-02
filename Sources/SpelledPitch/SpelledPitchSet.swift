//
//  SpelledPitchSet.swift
//  SpelledPitch
//
//  Created by James Bean on 5/28/16.
//
//

import Pitch

/// Unordered set of unique `SpelledPitch` values.
///
/// - TODO: Conform to `AnySequenceWrapping`.
public struct SpelledPitchSet {
    
    fileprivate let pitches: Set<SpelledPitch>
    
    // MARK: - Initializers
    
    /// Create a `SpelledPitchSet` with an array of `SpelledPitch` values.
    public init<S: Sequence>(_ pitches: S) where S.Iterator.Element == SpelledPitch {
        self.pitches = Set(pitches)
    }
}

extension SpelledPitchSet: ExpressibleByArrayLiteral {
    
    public typealias Element = SpelledPitch
    
    public init(arrayLiteral elements: Element...) {
        self.pitches = Set(elements)
    }
}

extension SpelledPitchSet: Sequence {
    
    // MARK: - SequenceType
    
    /// Generate `Pitches` for iteration.
    public func makeIterator() -> AnyIterator<SpelledPitch> {
        var generator = pitches.makeIterator()
        return AnyIterator { return generator.next() }
    }
}

extension SpelledPitchSet: Equatable {

    public static func == (lhs: SpelledPitchSet, rhs: SpelledPitchSet) -> Bool {
        return lhs.pitches == rhs.pitches
    }
}

