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

    typealias Name = NamedOrderedInterval.Size

    func testSecondOrdinalInverseSeventh() {
        XCTAssertEqual(Name.imperfect(.second).inverse, Name.imperfect(.seventh))
    }

    func testAPI() {
        let _: NamedOrderedInterval = .unison
        let _: NamedOrderedInterval = .init(.minor, .second)
        let _: NamedOrderedInterval = .init(.perfect, .fifth)
        let _: NamedOrderedInterval = .init(.perfect, .fourth)
        let _: NamedOrderedInterval = .init(.augmented, .fifth)
        let _: NamedOrderedInterval = .init(.diminished, .fifth)
        let _: NamedOrderedInterval = .init(.augmented, .third)
        let _: NamedOrderedInterval = .init(.minor, .seventh)
        let _: NamedOrderedInterval = .init(.triple, .augmented, .seventh)
        let _: NamedOrderedInterval = .init(.double, .diminished, .fifth)
    }

    func testAPIShouldNotCompile() {
        //let _: NamedOrderedInterval = .init(.minor, .fifth)
        //let _: NamedOrderedInterval = .init(.perfect, .second)
    }

    func testInversionPerfectFifthPerfectFourth() {
        let P5 = NamedOrderedInterval(.perfect, .fifth)
        let P4 = NamedOrderedInterval(.descending, .perfect, .fourth)
        XCTAssertEqual(P5.inverse, P4)
        XCTAssertEqual(P4.inverse, P5)
    }

    func testInversionMajorSecondMinorSeventh() {
        let M2 = NamedOrderedInterval(.major, .second)
        let m7 = NamedOrderedInterval(.descending, .minor, .seventh)
        XCTAssertEqual(M2.inverse, m7)
        XCTAssertEqual(m7.inverse, M2)
    }

    func testInversionMajorThirdMinorSixth() {
        let M3 = NamedOrderedInterval(.descending, .major, .third)
        let m6 = NamedOrderedInterval(.ascending, .minor, .sixth)
        XCTAssertEqual(M3.inverse, m6)
        XCTAssertEqual(m6.inverse, M3)
    }

    func testAbsoluteNamedIntervalOrdinalInversion() {
        let sixth = NamedOrderedInterval.Size.imperfect(.sixth)
        let expected = NamedOrderedInterval.Size.imperfect(.third)
        XCTAssertEqual(sixth.inverse, expected)
    }

    func testDoubleAugmentedThirdDoubleDiminishedSixth() {
        let AA3 = NamedOrderedInterval(.ascending, .double, .augmented, .third)
        let dd6 = NamedOrderedInterval(.descending, .double, .diminished, .sixth)
        XCTAssertEqual(AA3.inverse, dd6)
        XCTAssertEqual(dd6.inverse, AA3)
    }

    func testPerfectOrdinalUnisonInverse() {
        let unison = NamedOrderedInterval.Size.perfect(.unison)
        let expected = NamedOrderedInterval.Size.perfect(.unison)
        XCTAssertEqual(unison.inverse, expected)
    }

    func testPerfectOrdinalFourthFifthInverse() {
        let fourth = NamedOrderedInterval.Size.perfect(.fourth)
        let fifth = NamedOrderedInterval.Size.perfect(.fifth)
        XCTAssertEqual(fourth.inverse, fifth)
        XCTAssertEqual(fifth.inverse, fourth)
    }
}
