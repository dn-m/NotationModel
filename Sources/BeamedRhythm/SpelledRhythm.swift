////
////  SpelledRhythm.swift
////  RhythmSpellingTools
////
////  Created by James Bean on 6/15/17.
////
////
//
//import StructureWrapping
//import DataStructures
//import Rhythm
//
///// A `Rhythm` which has been "spelled" (i.e., beamed, tied, dotted).
//public struct SpelledRhythm <T> {
//
//    public struct Item {
//        /// Offset proportion within `MetricalDurationTree`.
//        let offset: Double
//        /// Metrical info (`MetricalDuration` and tie, rest, event context)
//        let metricalContext: Rhythm<T>.Leaf
//        /// Beaming, tie status, dot count info
//        let spelling: RhythmSpelling.Item
//    }
//
//    // MARK: - Instance Properties
//
//    public let rhythm: Rhythm<T>
//    public let spelling: RhythmSpelling
//
//    // MARK: - Initializers
//
//    public init(rhythm: Rhythm<T>, spelling: RhythmSpelling) {
//        self.rhythm = rhythm
//        self.spelling = spelling
//    }
//}
//
//extension SpelledRhythm: CollectionWrapping {
//
//    // MARK: - Collection
//
//    /// - Returns: A collection of triples containing the offset, rhythm leaf, and rhythm
//    /// spelling item for each leaf of the spelled rhythm.
//    public var base: [Item] {
//        let offsets = rhythm.metricalDurationTree.offsets.map { $0.doubleValue }
//        let items = spelling.map { $0 }
//        return zip(offsets, rhythm.leaves, items).map(Item.init)
//    }
//}
