//
//  PitchSpelling.swift
//  Pitch
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Pitch

/**
 Spelled representation of a `Pitch`.
 
 - TODO: Conform to `StringLiteralConvertible`.
 */
public struct PitchSpelling {
    
    // MARK: - Errors
    
    /**
     Errors possible when attempting to spell a `Pitch`.
     */
    public enum SpellingError: Error {
        
        /**
         If the given `PitchSpelling` is not applicable to the given `Pitch`.
         */
        case invalidSpelling(Pitch, PitchSpelling)
        
        /**
         If there is no `PitchSpelling` found for the given `Pitch`.
         */
        case noSpellingForPitch(Pitch)
    }
    
    // MARK: - Instance Properties
    
    /// LetterName of a `PitchSpelling`.
    public let letterName: LetterName
    
    /// Fine resolution of a `PitchSpelling`.
    public let eighthStep: EighthStepModifier
    
    /// Coarse resolution of a `PitchSpelling`.
    public let quarterStep: QuarterStepModifier
    
    /// `PitchClass` represented by this `PitchSpelling` value.
    ///
    /// - TODO: Refactor to `PitchClass`.
    public var pitchClass: Pitch.Class {
        let nn = NoteNumber(letterName.pitchClass + quarterStep.rawValue + eighthStep.rawValue)
        return Pitch.Class(noteNumber: nn)
    }
    
    // MARK: - Initializers
    
    /**
     Create a `PitchSpelling` (with argument labels).

     **Example:**
     
     ```
     let cNatural = PitchSpelling(letterName: .c)
     let aFlat = PitchSpelling(letterName: .a, quarterStep: .flat)
     let gQuarterSharp = PitchSpelling(letterName: .g, quarterStep: .quarterSharp)
     let dQuarterFlatDown = PitchSpelling(letterName: .d, quarterStep: .quarterFlat, eighthStep: .down)
     let bDoubleSharp = PitchSpelling(letterName: .b, quarterStep: .doubleSharp)
     ```
     */
    public init(
        letterName: LetterName,
        quarterStep: QuarterStepModifier = .natural,
        eighthStep: EighthStepModifier = .none
    )
    {
        self.letterName = letterName
        self.quarterStep = quarterStep
        self.eighthStep = eighthStep
    }
    
    /**
     Create a `PitchSpelling` (without argument labels).
     
     **Example:**
     
     ```
     let cNatural = PitchSpelling(.c)
     let aFlat = PitchSpelling(.a, .flat)
     let gQuarterSharp = PitchSpelling(.g, .quarterSharp)
     let dQuarterFlatDown = PitchSpelling(.d, .quarterFlat, .down)
     let bDoubleSharp = PitchSpelling(.b, .doubleSharp)
     ```
     */
    public init(
        _ letterName: LetterName,
        _ quarterStep: QuarterStepModifier = .natural,
        _ eighthStep: EighthStepModifier = .none
    )
    {
        self.letterName = letterName
        self.quarterStep = quarterStep
        self.eighthStep = eighthStep
    }

    // MARK: - Instance Methods
    
    /**
     - returns: `true` if this `PitchSpelling` can be applied to the given `Pitch`.
     Otherwise, `false`.
     */
    public func isValid(for pitch: Pitch) -> Bool {
        return pitch.spellings.contains(self)
    }
}

extension PitchSpelling: Hashable {
    
    // MARK: - Hashable
    
    /// Hash value of `PitchSpelling`.
    public var hashValue: Int {
        return "\(letterName),\(quarterStep),\(eighthStep)".hashValue
    }
}

// MARK: - Equatable

/**
 - returns: `true` if `letterName`, `quarterStep`, and `eighthStep` values for both 
 `PitchSpelling` values are equivalent. Otherwise, `false`.
 */
public func == (lhs: PitchSpelling, rhs: PitchSpelling) -> Bool {
    return (
        lhs.letterName == rhs.letterName &&
        lhs.quarterStep == rhs.quarterStep &&
        lhs.eighthStep == rhs.eighthStep
    )
}
