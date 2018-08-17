//
//  PitchDyad+Pitch.Spelling.swift
//  SpelledPitch
//
//  Created by James Bean on 5/3/16.
//
//

import Pitch

// FIXME: Move to PitchSpeller
extension Dyad where Element == Pitch {
    
    /// - returns: `true` if either `Pitch` value contained herein has a resolution of `0.25`
    public var hasEighthTone: Bool {
        return higher.resolution == 0.25 || lower.resolution == 0.25
    }
    
    /// - returns: `true` if either `Pitch` value contained herein has a resolution of `0.50`
    public var hasQuarterTone: Bool {
        return higher.resolution == 0.5 || lower.resolution == 0.5
    }
    
    /// Finest resolution of the `Pitch` values contained herein.
    public var finestResolution: Float {
        return min(higher.resolution, lower.resolution)
    }
}
