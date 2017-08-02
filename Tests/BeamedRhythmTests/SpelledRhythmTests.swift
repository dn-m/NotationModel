//
//  SpelledRhythmTests.swift
//  RhythmSpellingTools
//
//  Created by James Bean on 6/24/17.
//
//

import XCTest
import Rhythm
import BeamedRhythm

class SpelledRhythmTests: XCTestCase {
    
    func testCollection() {
        let durations = 4/>4 * [1,3,2,1,1,4,1]
        let contexts = durations.leaves.map { _ in MetricalContext.instance(.event(0)) }
        let rhythm = Rhythm(durations, contexts)
        let spelling = RhythmSpelling(rhythm)
        let spelledRhythm = SpelledRhythm(rhythm: rhythm, spelling: spelling)
        for (offset, leaf, item) in spelledRhythm {
            print("offset: \(offset); item: \(item)")
        }
    }
}
