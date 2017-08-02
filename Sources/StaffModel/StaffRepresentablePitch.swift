//
//  StaffRepresentablePitch.swift
//  StaffModel
//
//  Created by James Bean on 1/15/17.
//
//

import SpelledPitch

public struct StaffRepresentablePitch {
    
    public let spelledPitch: SpelledPitch
    public let notehead: Notehead
    public let accidental: Accidental
    
    /// Create a `StaffRepresentablePitch` with a `SpelledPitch` and `Notehead`.
    public init(_ spelledPitch: SpelledPitch, _ notehead: Notehead = .ord) {
        self.spelledPitch = spelledPitch
        self.notehead = notehead
        self.accidental = Accidental(spelling: spelledPitch.spelling)!
    }
}

extension StaffRepresentablePitch: Equatable {
    
    public static func == (lhs: StaffRepresentablePitch, rhs: StaffRepresentablePitch)
        -> Bool
    {
        return (
            lhs.spelledPitch == rhs.spelledPitch &&
            lhs.notehead == rhs.notehead &&
            lhs.accidental == rhs.accidental
        )
    }
}

extension StaffRepresentablePitch: Hashable {
    
    public var hashValue: Int {
        return spelledPitch.hashValue ^ notehead.hashValue ^ accidental.hashValue
    }
}

extension StaffRepresentablePitch: Comparable {
    
    public static func < (lhs: StaffRepresentablePitch, rhs: StaffRepresentablePitch) -> Bool {
        return lhs.spelledPitch < rhs.spelledPitch
    }
}
