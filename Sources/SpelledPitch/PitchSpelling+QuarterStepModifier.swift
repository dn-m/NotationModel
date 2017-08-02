//
//  Pitch.Spelling+QuarterStepModifier.swift
//  SpelledPitch
//
//  Created by James Bean on 5/3/16.
//
//

import Pitch

// temp: use collections api
extension RawRepresentable where RawValue: Comparable {

    // MARK: - `Comparable`

    /// - returns: `true` if the `rawValue` of the left value is less than the `rawValue`
    /// of the right value. Otherwise, `nil`.
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

