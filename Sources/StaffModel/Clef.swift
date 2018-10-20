//
//  Clef.swift
//  StaffModel
//
//  Created by James Bean on 1/15/17.
//
//

import SpelledPitch
import PlotModel

public struct Clef: Axis {
    
    public enum Kind: StaffSlot {
        case bass = 6
        case tenor = 2
        case alto = 0
        case treble = -6
    }
    
    public let kind: Kind
    public let coordinate: (SpelledPitch) -> StaffSlot
    
    public init(_ kind: Kind) {
        self.kind = kind
        self.coordinate = { spelledPitch in slot(kind, spelledPitch) }
    }
}

internal func slot(_ clef: Clef.Kind, _ spelledPitch: SpelledPitch) -> StaffSlot {
    let slotsPerOctave = 7
    let normalizedOctave = 4 - spelledPitch.octave
    let octaveDisplacement = slotsPerOctave * normalizedOctave
    let steps = spelledPitch.spelling.letterName.steps
    let middleCSlot = clef.rawValue
    return middleCSlot - octaveDisplacement + steps
}
