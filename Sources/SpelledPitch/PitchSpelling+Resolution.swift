//
//  PitchSpelling+Resolution.swift
//  SpelledPitch
//
//  Created by James Bean on 5/3/16.
//
//

import Foundation

extension PitchSpelling {
    
    /**
     Resolution of a `PitchSpelling`.
     */
    public enum Resolution: Float {
        
        // chromatic
        case halfStep = 0
        
        // quartertone
        case quarterStep = 0.5
        
        // eighth-tone
        case eighthStep = 0.25
    }
    
    /// `Resolution` (e.g., halfstep (chromatic), quarter-step, or eighth-step)
    public var resolution: Resolution {
        return eighthStep != .none
            ? .eighthStep
            : quarterStep.resolution == .quarterStep ? .quarterStep
            : .halfStep
    }
    
    /**
     - returns: A `PitchSpelling` object that is quantized to the given `resolution`.
     */
    public func quantized(to resolution: Resolution) -> PitchSpelling {
        switch resolution {
        case .quarterStep:
            return PitchSpelling(letterName, quarterStep, .none)
        case .halfStep where quarterStep.resolution == .quarterStep:
            return PitchSpelling(letterName, quarterStep.quantizedToHalfStep, .none)
        default:
            return self
        }
    }
}
