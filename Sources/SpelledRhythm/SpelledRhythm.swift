//
//  SpelledRhythm.swift
//  SpelledRhythm
//
//  Created by James Bean on 6/18/18.
//

import DataStructures
import Rhythm

/// A `Rhythm` and its abstract representation.
public struct SpelledRhythm <T> {

    public struct Item {
        /// Offset proportion within `MetricalDurationTree`.
        let offset: Double
        /// Metrical info (`MetricalDuration` and tie, rest, event context)
        let metricalContext: Rhythm<T>.Leaf
        /// Beaming, tie status, dot count info
        let spelling: Rhythm<T>.Spelling.Item
    }

    let rhythm: Rhythm<T>
    let spelling: Rhythm<T>.Spelling
}

extension SpelledRhythm {

    public var base: [Item] {
        let offsets = rhythm.metricalDurationTree.offsets.map { $0.doubleValue }
        let items = spelling.map { $0 }
        return zip(offsets, rhythm.leaves, items).map(Item.init)
    }
}
