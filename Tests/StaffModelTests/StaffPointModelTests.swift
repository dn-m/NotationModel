//
//  StaffPointModelTests.swift
//  StaffModel
//
//  Created by James Bean on 1/16/17.
//
//

import XCTest
import Pitch
import SpelledPitch
import PlotModel
import StaffModel
    
class StaffPointModelTests: XCTestCase {

    let treble = Clef(.treble)
    let bass = Clef(.bass)
    
    func staffPoint(_ pitchSet: Set<Pitch>) -> StaffPointModel {
        let spelled = pitchSet.map { $0.spelledWithDefaultSpelling }
        let representable = spelled.map { StaffRepresentablePitch($0) }
        return StaffPointModel(representable)
    }
    
    func testInit() {
        let pitchSet: Set<Pitch> = [60,61,62,63]
        let spelled = pitchSet.map { $0.spelledWithDefaultSpelling }
        let representable = spelled.map { StaffRepresentablePitch($0) }
        _ = StaffPointModel(representable)
    }
    
    func testLedgerLinesAboveAndBelowEmpty() {
        let staffPoint = StaffPointModel([])
        XCTAssertEqual(staffPoint.ledgerLines(treble).0, 0)
    }
    
    func testLedgerLinesAboveMonadInStaff() {
        let point = staffPoint([71])
        XCTAssertEqual(point.ledgerLines(treble).0, 0)
    }
    
    func testLedgerLinesBelowMonadInStaff() {
        let point = staffPoint([48])
        XCTAssertEqual(point.ledgerLines(bass).1, 0)
    }
    
    func testLedgerLinesAboveMonadJustAboveNoLedgerLines() {
        let point = staffPoint([79])
        XCTAssertEqual(point.ledgerLines(treble).1, 0)
    }
    
    func testLedgerLinesBelowMonadJustBelowNoLedgerLines() {
        let point = staffPoint([41])
        XCTAssertEqual(point.ledgerLines(bass).1, 0)
    }
    
    func testLedgerLinesMonadOneAbove() {
        let point = staffPoint([60])
        XCTAssertEqual(point.ledgerLines(bass).0, 1)
    }
    
    func testLedgerLinesMonadOneBelow() {
        let point = staffPoint([60])
        XCTAssertEqual(point.ledgerLines(treble).1, 1)
    }
    
    func testLedgerLinesDyadSingleAboveAndBelow() {
        let point = staffPoint([60, 81])
        XCTAssertEqual(point.ledgerLines(treble).1, 1)
        XCTAssertEqual(point.ledgerLines(treble).0, 1)
    }
    
    func testManyPitchesOnlySeveralLinesAboveDNatural() {
        let point = staffPoint([64,66,67,69,86])
        XCTAssertEqual(point.ledgerLines(treble).1, 0)
        XCTAssertEqual(point.ledgerLines(treble).0, 2)
    }
    
    func testStemConnectionPoint() {
        let point = staffPoint([57,71,84])
        let fromAbove = point.stemConnectionPoint(from: .above, axis: treble)
        let fromBelow = point.stemConnectionPoint(from: .below, axis: treble)
        XCTAssertEqual(fromAbove, -8)
        XCTAssertEqual(fromBelow, +8)
    }
}
