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

extension SpelledChord: RandomAccessCollection {

    // MARK: - RandomAccessCollection

    public typealias Base = [SpelledPitch]

    /// The `RandomAccessCollection` base of a `SpelledChord`.
    public var base: [SpelledPitch] {
        return pitches
    }

    /// Start index.
    ///
    /// - Complexity: O(1)
    ///
    public var startIndex: Base.Index {
        return base.startIndex
    }

    /// End index.
    ///
    /// - Complexity: O(1)
    ///
    public var endIndex: Base.Index {
        return base.endIndex
    }

    /// First element, if there is at least one element. Otherwise, `nil`.
    ///
    /// - Complexity: O(1)
    ///
    public var first: Base.Element? {
        return base.first
    }

    /// Last element, if there is at least one element. Otherwise, `nil`.
    ///
    /// - Complexity: O(1)
    ///
    public var last: Base.Element? {
        return base.last
    }

    /// Amount of elements.
    ///
    /// - Complexity: O(1)
    ///
    public var count: Int {
        return base.count
    }

    /// - Returns: `true` if there are no elements contained herein. Otherwise, `false`.
    ///
    /// - Complexity: O(1)
    ///
    public var isEmpty: Bool {
        return base.isEmpty
    }

    /// - Returns: The element at the given `index`.
    ///
    /// - Complexity: O(1)
    ///
    public subscript(position: Base.Index) -> Base.Element {
        return base[position]
    }

    /// - Returns: Index after the given `index`.
    ///
    /// - Complexity: O(1)
    public func index(after index: Base.Index) -> Base.Index {
        return base.index(after: index)
    }

    /// - Returns: Index before the given `index`.
    ///
    /// - Complexity: O(1)
    ///
    public func index(before index: Base.Index) -> Base.Index {
        return base.index(before: index)
    }
}

extension SpelledChord: ExpressibleByArrayLiteral {

    // MARK: - ExpressibleByArrayLiteral

    /// Creates a `SpelledChord` with the array literal of `SpelledPitch` values.
    public init(arrayLiteral pitches: SpelledPitch...) {
        self.init(pitches)
    }
}
