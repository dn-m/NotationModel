//
//  StaffPointModelTests.swift
//  StaffModel
//
//  Createsd by James Bean on 1/16/17.
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
    
    func staffPoint(_ pitchSet: [Pitch]) -> StaffPointModel {
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
        XCTAssertEqual(staffPoint.ledgerLines(treble).above, 0)
    }
    
    func testLedgerLinesAboveMonadInStaff() {
        let point = staffPoint([71])
        XCTAssertEqual(point.ledgerLines(treble).below, 0)
    }
    
    func testLedgerLinesBelowMonadInStaff() {
        let point = staffPoint([48])
        XCTAssertEqual(point.ledgerLines(bass).below, 0)
    }
    
    func testLedgerLinesAboveMonadJustAboveNoLedgerLines() {
        let point = staffPoint([79])
        XCTAssertEqual(point.ledgerLines(treble).above, 0)
    }
    
    func testLedgerLinesBelowMonadJustBelowNoLedgerLines() {
        let point = staffPoint([41])
        XCTAssertEqual(point.ledgerLines(bass).below, 0)
    }
    
    func testLedgerLinesMonadOneAbove() {
        let point = staffPoint([60])
        XCTAssertEqual(point.ledgerLines(bass).above, 1)
    }
    
    func testLedgerLinesMonadOneBelow() {
        let point = staffPoint([60])
        XCTAssertEqual(point.ledgerLines(treble).below, 1)
    }
    
    func testLedgerLinesDyadSingleAboveAndBelow() {
        let point = staffPoint([60, 81])
        XCTAssertEqual(point.ledgerLines(treble).below, 1)
        XCTAssertEqual(point.ledgerLines(treble).above, 1)
    }

    func testDoublesExtrema() {
        let values: [Double] = [64,66,67,69,86]
        XCTAssertEqual(values.min(), 64)
        XCTAssertEqual(values.max(), 86)
    }

    func testPitchesExtrema() {
        let pitches: [Pitch] = [64,66,67,69,86]
        XCTAssertEqual(pitches.min(), 64)
        XCTAssertEqual(pitches.max(), 86)
    }

    func testSpelledPitchesExtrema() {
        let originalPitches: [Pitch] = [64,66,67,69,86]
        let spelledPitches = originalPitches.map { $0.spelledWithDefaultSpelling }
        let mappedPitches = spelledPitches.map { $0.pitch }
        XCTAssertEqual(originalPitches, mappedPitches)
        XCTAssertEqual(mappedPitches.min(), 64)
        XCTAssertEqual(mappedPitches.max(), 86)
        XCTAssertEqual(spelledPitches.min()?.pitch, 64)
        XCTAssertEqual(spelledPitches.max()?.pitch, 86)
    }

    func testHighest() {
        let point = staffPoint([64,66,67,69,86])
        XCTAssertEqual(point.highest?.spelledPitch.pitch, 86)
    }

    func testLowest() {
        let point = staffPoint([64,66,67,69,86])
        XCTAssertEqual(point.lowest?.spelledPitch.pitch, 64)
    }
    
    func testManyPitchesOnlySeveralLinesAboveDNatural() {
        let point = staffPoint([64,66,67,69,86])
        XCTAssertEqual(point.ledgerLines(treble).below, 0)
        XCTAssertEqual(point.ledgerLines(treble).above, 2)
    }
    
    func testStemConnectionPoint() {
        let point = staffPoint([57,71,84])
        let fromAbove = point.stemConnectionPoint(from: .above, axis: treble)
        let fromBelow = point.stemConnectionPoint(from: .below, axis: treble)
        XCTAssertEqual(fromAbove, -8)
        XCTAssertEqual(fromBelow, +8)
    }
}
