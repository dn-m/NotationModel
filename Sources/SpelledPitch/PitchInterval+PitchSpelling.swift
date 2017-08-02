//
//  PitchInterval+PitchSpelling.swift
//  SpelledPitch
//
//  Created by James Bean on 5/19/16.
//
//

import Pitch

extension UnorderedInterval where Element == Pitch {
    
    /** 
     `IntervalClass` representation of `Interval`.
     
     - TODO: Move to up `Pitch` framework
    */
    public var intervalClass: UnorderedInterval<Pitch.Class> {
        return UnorderedInterval<Pitch.Class>(
            noteNumber: NoteNumber(noteNumber.value.truncatingRemainder(dividingBy: 12))
        )
    }
    
    /// Priority for this `Interval` to be spelled. Lower value is higher priority.
    public var spellingPriority: UnorderedInterval<Pitch.Class>.SpellingPriority? {
        return intervalClass.spellingPriority
    }
}
