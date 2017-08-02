//
//  PitchClassInterval+Pitch.Spelling.swift
//  SpelledPitch
//
//  Created by James Bean on 5/19/16.
//
//

import Pitch

extension UnorderedInterval where Element == Pitch.Class {
    
    // MARK: - Associated Types

    /// Priority for a given `IntervalClass` to be spelled. Lower value is higher priority.
    public typealias SpellingPriority = Int

    /// Priority for this `IntervalClass` to be spelled. Lower value is higher priority.
    public var spellingPriority: SpellingPriority? {
        return intervalClassOrderedBySpellingPriority.index(of: self)
    }
}

private let intervalClassOrderedBySpellingPriority: [UnorderedInterval<Pitch.Class>] = [

    // minor second, major seventh 1/8th tone neighborood
    00.75, 01.25, 11.25, 10.75,

    // perfectable intervals 1/4 tone neighborhood
    00.50, 11.50, 07.50, 06.50, 05.50, 04.50,

    // minor second, major seventh
    01.00, 11.00,

    // perfectable intervals
    00.00, 07.00, 05.00,

    // perfectable intervals 1/8th tone neighborhood
    11.75, 00.25, 06.75, 07.25, 04.75, 05.25,

    // second, minor seventh
    02.00, 10.00,

    // major third, major sixth
    04.00, 09.00,

    // minor third, minor sixth
    03.00, 08.00,

    // major second, minor seventh 1/8th tone neighborhood
    01.75, 02.25, 09.75, 10.25,

    // major third, major sixth 1/8th tone neighborhood
    03.75, 04.25, 08.75, 09.25,

    // minor third, minor sixth 1/8th tone neighborhood
    02.75, 03.25, 07.75, 08.25,

    // tritone
    06.00,

    // tritone 1/8th tone neighborhood
    06.25, 05.75,

    // neutral second up / down
    01.50, 10.50,

    // large second up / down
    02.50, 09.50,

    // neutral third up / down
    03.50, 08.50,
]
