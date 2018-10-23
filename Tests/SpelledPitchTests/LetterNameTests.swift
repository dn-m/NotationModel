//
//  LetterNameTests.swift
//  SpelledPitchTests
//
//  Created by James Bean on 10/21/18.
//

import XCTest
import SpelledPitch

class LetterNameTests: XCTestCase {

    func testDisplacedUnison() {
        for letterName in LetterName.allCases {
            XCTAssertEqual(letterName.displaced(by: 0), letterName)
        }
    }

    func testLetterNameSimplePositive() {
        let letterName = LetterName.f
        XCTAssertEqual(letterName.displaced(by: 2), .a)
    }

    func testLetterNameSimpleNegative() {
        let letterName = LetterName.a
        XCTAssertEqual(letterName.displaced(by: -3), .e)
    }

    func testLetterNameWrapping() {
        let letterName = LetterName.a
        XCTAssertEqual(letterName.displaced(by: 3), .d)
    }
}
