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

struct LookupPair: Hashable {
    
    let source: LookupIndex
    let sink: LookupIndex
    
    init(_ source: LookupIndex, _ sink: LookupIndex) {
        self.source = source
        self.sink = sink
    }
    
    init(_ tuple: (LookupIndex, LookupIndex)) {
        self.source = tuple.0
        self.sink = tuple.1
    }
}

struct LookupTable<Weight: Hashable & Numeric> {
    
    private let storage: [LookupPair: Weight]
    
    init(_ dict: [LookupPair: Weight]) {
        self.storage = dict
    }
    
    func weight(at index: LookupPair) -> Weight? {
        return storage[index]
    }
}
