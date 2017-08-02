//
//  SpelledPitchClassSet.swift
//  SpelledPitch
//
//  Created by James Bean on 8/25/16.
//
//

import Pitch

/// Unordered set of `SpelledPitchClass` values.
///
/// - TODO: Conform to `AnySequenceWrapping`.
public struct SpelledPitchClassSet {
    
    fileprivate let pitches: Set<SpelledPitchClass>
    
    public init<S: Sequence>(_ pitches: S) where S.Iterator.Element == SpelledPitchClass {
        self.pitches = Set(pitches)
    }
}

extension SpelledPitchClassSet: ExpressibleByArrayLiteral {
    
    public typealias Element = SpelledPitchClass
    
    public init(arrayLiteral elements: Element...) {
        self.pitches = Set(elements)
    }
}

extension SpelledPitchClassSet: Sequence {
    
    public func makeIterator() -> AnyIterator<SpelledPitchClass> {
        var generator = pitches.makeIterator()
        return AnyIterator { return generator.next() }
    }
}

extension SpelledPitchClassSet: Equatable {

    public static func == (lhs: SpelledPitchClassSet, rhs: SpelledPitchClassSet) -> Bool {
        return lhs.pitches == rhs.pitches
    }
}
