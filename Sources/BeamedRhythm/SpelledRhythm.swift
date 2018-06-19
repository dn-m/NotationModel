//
//  SpelledRhythm.swift
//  RhythmSpellingTools
//
//  Created by James Bean on 6/15/17.
//
//

import StructureWrapping
import DataStructures
import Rhythm

public struct SpelledRhythm <T> {
    
    // MARK: - Instance Properties
    
    // Constrain to `Int` for now.
    public let rhythm: Rhythm<T>
    public let spelling: RhythmSpelling
    
    // MARK: - Initializers
    
    public init(rhythm: Rhythm<T>, spelling: RhythmSpelling) {
        self.rhythm = rhythm
        self.spelling = spelling
    }
}

extension SpelledRhythm: CollectionWrapping {
    
    // MARK: - Collection
    
    /// - Returns: A collection of triples containing the offset, rhythm leaf, and rhythm 
    /// spelling item for each leaf of the spelled rhythm.
    public var base: [(Double,Rhythm<T>.Leaf,RhythmSpelling.Item)] {
        let offsets = rhythm.metricalDurationTree.offsets.map { $0.doubleValue }
        let items = spelling.map { $0 }
        return Array(zip(offsets, rhythm.leaves, items))
    }
}
