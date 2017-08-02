//
//  SpelledPitch.swift
//  SpelledPitch
//
//  Created by James Bean on 5/1/16.
//
//

import Darwin
import Pitch

/// Structure that wraps a `Pitch` with a `Pitch.Spelling`.
public struct SpelledPitch: Spelled {
    
    // MARK: - Instance Properties
    
    /// `Pitch`.
    public let pitch: Pitch
    
    /// `Pitch.Spelling`.
    public let spelling: Pitch.Spelling
    
    /// `Octave`.
    public var octave: Int {
        
        let unadjusted = Int(floor(pitch.noteNumber.value / 12.0))
        
        var mustAdjustForC: Bool {
            guard spelling.letterName == .c else { return false }
            if spelling.quarterStep.direction == .down { return true }
            return spelling.quarterStep == .natural && spelling.eighthStep == .down
        }
        
        var mustAdjustForB: Bool {
            guard spelling.letterName == .b else { return false }
            return spelling.quarterStep == .sharp && spelling.eighthStep.rawValue >= 0
        }
        
        return mustAdjustForC ? unadjusted + 1 : mustAdjustForB ? unadjusted - 1 : unadjusted
    }
    
    // MARK: - Initializers
    
    /**
     Create a `SpelledPitch` with a given `pitch` and `spelling`.
     
     - TODO: ensure `Pitch.Spelling` is valid for given `pitch`.
     */
    public init(pitch: Pitch, spelling: Pitch.Spelling) {
        self.pitch = pitch
        self.spelling = spelling
    }
    
    /// Create a `SpelledPitch` with a given `pitch` and `spelling`, without argument labels.
    public init(_ pitch: Pitch, _ spelling: Pitch.Spelling) {
        self.pitch = pitch
        self.spelling = spelling
    }
}

extension SpelledPitch: CustomStringConvertible {
    
    // MARK: - CustomStringConvertible
    
    /// Printed description.
    public var description: String {
        return "\(pitch): \(spelling)"
    }
}

extension SpelledPitch: Hashable {
    
    // MARK: - Hashable
    
    /// Hash value.
    public var hashValue: Int {
        return "\(pitch)\(spelling)".hashValue
    }
}

// MARK: - Equatable

/**
 - returns: `true` if the `pitch` and `spelling` values are equivalent. Otherwise, `false`.
 */
public func == (lhs: SpelledPitch, rhs: SpelledPitch) -> Bool {
    return lhs.pitch == rhs.pitch && lhs.spelling == rhs.spelling
}

extension SpelledPitch: Comparable {

    /**
     - returns: `true` if the `pitch` value of the `SpelledPitch` value on the left is less than
     that of the `SpelledPitch` value on the right. Otherwise, `false`.

     - note: In the case that both values are in the same octave, `true` is returned if the
     spelling of the `SpelledPitch` value on the left is less than that of the `SpelledPitch` on
     the right. This manages extreme scenarios such as (c#, dbb), which should have a named
     interval of a double diminished second, not a double augmented seventh.
     */
    public static func < (lhs: SpelledPitch, rhs: SpelledPitch) -> Bool {
        // manage extreme reacharound scenarios (c#, ddoubleflat) => double diminished second
        if lhs.octave == rhs.octave { return lhs.spelling < rhs.spelling }
        return lhs.pitch < rhs.pitch
    }
}
