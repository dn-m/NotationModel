//
//  LookupTable.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 6/26/18.
//

import Foundation
import Pitch

struct LookupIndex: Hashable {
    
    let pitchClass: Pitch.Class
    let tendency: Tendency
    
    init(_ pitchClass: Pitch.Class, _ tendency: Tendency) {
        self.pitchClass = pitchClass
        self.tendency = tendency
    }
    
    init(_ tuple: (Pitch.Class, Tendency)) {
        self.pitchClass = tuple.0
        self.tendency = tuple.1
    }
}
