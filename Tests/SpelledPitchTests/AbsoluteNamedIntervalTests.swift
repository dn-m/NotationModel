//
//  AbsoluteNamedIntervalTests.swift
//  SpelledPitch
//
//  Created by James Bean on 1/8/17.
//
//

import XCTest
import SpelledPitch

class AbsoluteNamedIntervalTests: XCTestCase {

    typealias Ordinal = AbsoluteNamedInterval.Ordinal

    func testUnisonPerfectNotImperfect() {
        let unison = Ordinal.unison
        XCTAssert(Ordinal.perfects.contains(unison))
        XCTAssertFalse(Ordinal.imperfects.contains(unison))
    }

    func testSecondImperfectNotImperfect() {
        let second = Ordinal.second
        XCTAssert(Ordinal.imperfects.contains(second))
        XCTAssertFalse(Ordinal.perfects.contains(second))
    }

    func testSecondOrdinalInverseSeventh() {
        XCTAssertEqual(Ordinal.second.inverse, Ordinal.seventh)
    }

    func testInversionPerfectFifthPerfectFourth() {
        let P5 = AbsoluteNamedInterval(.perfect, .fifth)
        let P4 = AbsoluteNamedInterval(.perfect, .fourth)
        XCTAssertEqual(P5.inverse, P4)
        XCTAssertEqual(P4.inverse, P5)
    }

    func testInversionMajorSecondMinorSeventh() {
        let M2 = AbsoluteNamedInterval(.major, .second)
        let m7 = AbsoluteNamedInterval(.minor, .seventh)
        XCTAssertEqual(M2.inverse, m7)
        XCTAssertEqual(m7.inverse, M2)
    }

    func testInversionMajorThirdMinorSixth() {
        let M3 = AbsoluteNamedInterval(.major, .third)
        let m6 = AbsoluteNamedInterval(.minor, .sixth)
        XCTAssertEqual(M3.inverse, m6)
        XCTAssertEqual(m6.inverse, M3)
    }

    func testDoubleAugmentedThirdDoubleDiminishedSixth() {
        let AA3 = AbsoluteNamedInterval(.augmented, .third)
        let dd6 = AbsoluteNamedInterval(.diminished, .sixth)
        XCTAssertEqual(AA3.inverse, dd6)
        XCTAssertEqual(dd6.inverse, AA3)
    }
}

