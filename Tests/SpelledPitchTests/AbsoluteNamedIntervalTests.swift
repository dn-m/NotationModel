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

    func testAPI() {
        let _: AbsoluteNamedInterval = .unison
        let _: AbsoluteNamedInterval = .init(.minor, .second)
        let _: AbsoluteNamedInterval = .init(.perfect, .fifth)
        let _: AbsoluteNamedInterval = .init(.perfect, .fourth)
        let _: AbsoluteNamedInterval = .init(.augmented, .fifth)
        let _: AbsoluteNamedInterval = .init(.diminished, .fifth)
        let _: AbsoluteNamedInterval = .init(.augmented, .third)
        let _: AbsoluteNamedInterval = .init(.minor, .seventh)
        let _: AbsoluteNamedInterval = .init(.triple, .augmented, .seventh)
        let _: AbsoluteNamedInterval = .init(.double, .diminished, .fifth)
    }

    func testAPIShouldNotCompile() {
        //let _: AbsoluteNamedInterval = .init(.minor, .fifth)
        //let _: AbsoluteNamedInterval = .init(.perfect, .second)
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

    func testAbsoluteNamedIntervalOrdinalInversion() {
        let sixth = AbsoluteNamedInterval.Ordinal.sixth
        let expected = AbsoluteNamedInterval.Ordinal.third
        XCTAssertEqual(sixth.inverse, expected)
    }

    func testDoubleAugmentedThirdDoubleDiminishedSixth() {
        let AA3 = AbsoluteNamedInterval(.double, .augmented, .third)
        let dd6 = AbsoluteNamedInterval(.double, .diminished, .sixth)
        XCTAssertEqual(AA3.inverse, dd6)
        XCTAssertEqual(dd6.inverse, AA3)
    }
}
