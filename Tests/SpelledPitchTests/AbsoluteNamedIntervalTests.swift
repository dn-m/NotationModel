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
        let M2 = AbsoluteNamedInterval(.imperfect(.major), .second)
        let m7 = AbsoluteNamedInterval(.imperfect(.minor), .seventh)
        XCTAssertEqual(M2.inverse, m7)
        XCTAssertEqual(m7.inverse, M2)
    }

    func testInversionMajorThirdMinorSixth() {
        let M3 = AbsoluteNamedInterval(.imperfect(.major), .third)
        let m6 = AbsoluteNamedInterval(.imperfect(.minor), .sixth)
        XCTAssertEqual(M3.inverse, m6)
        XCTAssertEqual(m6.inverse, M3)
    }

    func testAbsoluteNamedIntervalOrdinalInversion() {
        let sixth = AbsoluteNamedInterval.Ordinal.sixth
        let expected = AbsoluteNamedInterval.Ordinal.third
        XCTAssertEqual(sixth.inverse, expected)
    }

    func testDoubleAugmentedThirdDoubleDiminishedSixth() {
        let AA3 = AbsoluteNamedInterval(.augmentedOrDiminished(.init(.double, .augmented)), .third)
        let dd6 = AbsoluteNamedInterval(.augmentedOrDiminished(.init(.double, .diminished)), .sixth)
        print("AA3.inverse: \(AA3.inverse)")
        XCTAssertEqual(AA3.inverse, dd6)
        XCTAssertEqual(dd6.inverse, AA3)
    }
}
