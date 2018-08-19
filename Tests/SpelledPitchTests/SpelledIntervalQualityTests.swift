//
//  SpelledIntervalQualityTests.swift
//  SpelledPitch
//
//  Created by James Bean on 1/8/17.
//
//

import XCTest
import Pitch
import SpelledPitch

class SpelledIntervalQualityTests: XCTestCase {

    func testInverseDimAug() {
        let dim = SpelledIntervalQuality.extended(.init(.single, .diminished))
        let aug = SpelledIntervalQuality.extended(.init(.single, .augmented))
        XCTAssertEqual(dim.inverse, aug)
        XCTAssertEqual(aug.inverse, dim)
    }

    func testInverseMinorMajor() {
        let maj = SpelledIntervalQuality.imperfect(.major)
        let min = SpelledIntervalQuality.imperfect(.minor)
        XCTAssertEqual(maj.inverse, min)
        XCTAssertEqual(min.inverse, maj)
    }

    func testInversePerfect() {
        let perfect = SpelledIntervalQuality.perfect(.perfect)
        XCTAssertEqual(perfect.inverse, perfect)
    }
}
