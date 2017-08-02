//
//  PitchSpelling+Comparable.swift
//  SpelledPitch
//
//  Created by James Bean on 8/11/16.
//
//

import Foundation

extension PitchSpelling: Comparable { }

// MARK: - Comparable

/**
 - returns: `true` if the `PitchSpelling` value on the left has a lesser `letterName` value. In
 the case that the `letterName` values are equivalent, `true` if the `PitchSpelling` value on 
 the left has a lesser `quarterStep` value. In the case that the `quarterStep` values are
 equivalent, `true` if the `PitchSpelling` value on the left has a lesser `eighthStep` value.
 Otherwise, `false`.
 */
public func < (lhs: PitchSpelling, rhs: PitchSpelling) -> Bool {
    if lhs.letterName.steps < rhs.letterName.steps { return true }
    if lhs.letterName.steps == rhs.letterName.steps {
        if lhs.quarterStep.rawValue < rhs.quarterStep.rawValue { return true }
        if lhs.quarterStep.rawValue == rhs.quarterStep.rawValue {
            if lhs.eighthStep.rawValue < rhs.eighthStep.rawValue { return true }
        }
    }
    return false
}
