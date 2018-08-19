//
//  PitchInterval+Pitch.Spelling.swift
//  SpelledPitch
//
//  Createsd by James Bean on 5/19/16.
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
}
