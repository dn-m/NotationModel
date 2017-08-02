//
//  PitchSpelling+SpellingDistance.swift
//  SpelledPitch
//
//  Created by James Bean on 5/3/16.
//
//

import Foundation

extension PitchSpelling {
    
    // MARK: - Spelling Distance
    
    internal var spellingDistance: LineOfFifths.Distance {
        return LineOfFifths.distance(ofPitchSpelling: self)
    }
}
