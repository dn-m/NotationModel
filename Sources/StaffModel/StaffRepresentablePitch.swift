//
//  StaffRepresentablePitch.swift
//  StaffModel
//
//  Created by James Bean on 1/15/17.
//
//

import Pitch
import SpelledPitch

public struct StaffRepresentablePitch {
    
    public let spelledPitch: SpelledPitch
    public let notehead: Notehead
    public let accidental: Pitch.Spelling.Modifier
    
    /// Creates a `StaffRepresentablePitch` with a `SpelledPitch` and `Notehead`.
    public init(_ spelledPitch: SpelledPitch, _ notehead: Notehead = .ord) {
        self.spelledPitch = spelledPitch
        self.notehead = notehead
        self.accidental = spelledPitch.spelling.modifier
    }
}

extension StaffRepresentablePitch: Equatable { }
extension StaffRepresentablePitch: Hashable { }

extension StaffRepresentablePitch: Comparable {
    
    public static func < (lhs: StaffRepresentablePitch, rhs: StaffRepresentablePitch) -> Bool {
        return lhs.spelledPitch < rhs.spelledPitch
    }
}
