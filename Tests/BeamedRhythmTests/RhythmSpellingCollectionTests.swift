//
//  RhythmSpellingCollectionTests.swift
//  RhythmSpellingTools
//
//  Created by James Bean on 6/15/17.
//
//

import XCTest
import Rhythm
import MetricalDuration
import BeamedRhythm

class RhythmSpellingCollectionTests: XCTestCase {
    
    func testCollection() {
        let spelling = RhythmSpelling(4/>4 * [1,3,2,1,1,4,1])
        for item in spelling {
            print(item)
        }
    }
}
