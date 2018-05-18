//
//  NamedIntervalQualityTests.swift
//  SpelledPitch
//
//  Created by James Bean on 1/8/17.
//
//

import XCTest
import Pitch
import SpelledPitch

class NamedIntervalQualityTests: XCTestCase {

    func testInverseDimAug() {
        let dim = NamedIntervalQuality.augmentedOrDiminished(.init(.single, .diminished))
        let aug = NamedIntervalQuality.augmentedOrDiminished(.init(.single, .augmented))
        XCTAssertEqual(dim.inverse, aug)
        XCTAssertEqual(aug.inverse, dim)
    }

    func testInverseMinorMajor() {
        let maj = NamedIntervalQuality.imperfect(.major)
        let min = NamedIntervalQuality.imperfect(.minor)
        XCTAssertEqual(maj.inverse, min)
        XCTAssertEqual(min.inverse, maj)
    }

    func testInversePerfect() {
        let perfect = NamedIntervalQuality.perfect(.perfect)
        XCTAssertEqual(perfect.inverse, perfect)
    }
}
