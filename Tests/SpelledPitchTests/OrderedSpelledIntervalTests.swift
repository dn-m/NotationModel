//
//  OrderedSpelledIntervalTests.swift
//  SpelledPitch
//
//  Createsd by James Bean on 1/8/17.
//
//

import XCTest
import SpelledPitch

class OrderedSpelledIntervalTests: XCTestCase {

    typealias Ordinal = OrderedSpelledInterval.Ordinal

    func testSecondOrdinalInverseSeventh() {
        XCTAssertEqual(Ordinal.imperfect(.second).inverse, Ordinal.imperfect(.seventh))
    }

    func testAPI() {
        let _: OrderedSpelledInterval = .unison
        let _: OrderedSpelledInterval = .init(.minor, .second)
        let _: OrderedSpelledInterval = .init(.perfect, .fifth)
        let _: OrderedSpelledInterval = .init(.perfect, .fourth)
        let _: OrderedSpelledInterval = .init(.augmented, .fifth)
        let _: OrderedSpelledInterval = .init(.diminished, .fifth)
        let _: OrderedSpelledInterval = .init(.augmented, .third)
        let _: OrderedSpelledInterval = .init(.minor, .seventh)
        let _: OrderedSpelledInterval = .init(.triple, .augmented, .seventh)
        let _: OrderedSpelledInterval = .init(.double, .diminished, .fifth)
    }

    func testAPIShouldNotCompile() {
        //let _: OrderedSpelledInterval = .init(.minor, .fifth)
        //let _: OrderedSpelledInterval = .init(.perfect, .second)
    }

    func testInversionPerfectFifthPerfectFourth() {
        let P5 = OrderedSpelledInterval(.perfect, .fifth)
        let P4 = OrderedSpelledInterval(.descending, .perfect, .fourth)
        XCTAssertEqual(P5.inverse, P4)
        XCTAssertEqual(P4.inverse, P5)
    }

    func testInversionMajorSecondMinorSeventh() {
        let M2 = OrderedSpelledInterval(.major, .second)
        let m7 = OrderedSpelledInterval(.descending, .minor, .seventh)
        XCTAssertEqual(M2.inverse, m7)
        XCTAssertEqual(m7.inverse, M2)
    }

    func testInversionMajorThirdMinorSixth() {
        let M3 = OrderedSpelledInterval(.descending, .major, .third)
        let m6 = OrderedSpelledInterval(.ascending, .minor, .sixth)
        XCTAssertEqual(M3.inverse, m6)
        XCTAssertEqual(m6.inverse, M3)
    }

    func testAbsoluteNamedIntervalOrdinalInversion() {
        let sixth = OrderedSpelledInterval.Ordinal.imperfect(.sixth)
        let expected = OrderedSpelledInterval.Ordinal.imperfect(.third)
        XCTAssertEqual(sixth.inverse, expected)
    }

    func testDoubleAugmentedThirdDoubleDiminishedSixth() {
        let AA3 = OrderedSpelledInterval(.ascending, .double, .augmented, .third)
        let dd6 = OrderedSpelledInterval(.descending, .double, .diminished, .sixth)
        XCTAssertEqual(AA3.inverse, dd6)
        XCTAssertEqual(dd6.inverse, AA3)
    }

    func testPerfectOrdinalUnisonInverse() {
        let unison = OrderedSpelledInterval.Ordinal.perfect(.unison)
        let expected = OrderedSpelledInterval.Ordinal.perfect(.unison)
        XCTAssertEqual(unison.inverse, expected)
    }

    func testPerfectOrdinalFourthFifthInverse() {
        let fourth = OrderedSpelledInterval.Ordinal.perfect(.fourth)
        let fifth = OrderedSpelledInterval.Ordinal.perfect(.fifth)
        XCTAssertEqual(fourth.inverse, fifth)
        XCTAssertEqual(fifth.inverse, fourth)
    }
}
