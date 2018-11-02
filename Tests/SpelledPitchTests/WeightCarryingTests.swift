//
//  WeightCarryingTests.swift
//  SpelledPitchTests
//
//  Created by Benjamin Wetherfield on 31/10/2018.
//

import XCTest
import DataStructures
@testable import SpelledPitch

class WeightCarryingTests: XCTestCase {
    
    func testPullback() {
        var g = WeightedGraph<Int, Double>()
        g.insert(3)
        g.insert(5)
        g.insertEdge(from: 3, to: 5, weight: 2.0)
        let intEdgeCheck = WeightCarrying.build(from: g)
        let f: (Float) -> Int = { f in Int(f) }
        let floatEdgeCheck: WeightCarrying<WeightedGraph<Float, Double>> = intEdgeCheck.pullback(f)
        XCTAssertEqual(floatEdgeCheck.weight(UnorderedPair(3.14, 5.6)), 2.0)
    }
    
    func testConvenienceConstructor() {
        let g = WeightedGraph<Int, Double>([1,2,3])
        let gWeights = WeightCarrying.build(from: g)
        XCTAssertNil(gWeights.weight(UnorderedPair(1,2)))
    }
    
    func testMultiplicationInitializationFreeze() {
        var g = WeightedDirectedGraph<Int, Double>([1,2,3])
        var h = WeightedGraph<Int, Double>([1,2,3])
        let gWeights = WeightCarrying.build(from: g)
        let hWeights = WeightCarrying.build(from: g)
        g.insertEdge(from: 1, to: 2, weight: 2.0)
        h.insertEdge(from: 2, to: 1, weight: 3.0)
        g.insertEdge(from: 3, to: 1, weight: 1.0)
        h.insertEdge(from: 2, to: 3, weight: 1.0)
        let masked = gWeights * hWeights
        XCTAssertNil(masked.weight(from: 1, to: 2))
        XCTAssertNil(masked.weight(from: 3, to: 1))
        XCTAssertNil(masked.weight(from: 2, to: 3))
    }
    
    func testMultiplicationDirectedH() {
        var g = WeightedDirectedGraph<Int, Double>([1,2,3])
        var h = WeightedDirectedGraph<Int, Double>([1,2,3])
        g.insertEdge(from: 1, to: 2, weight: 2.0)
        h.insertEdge(from: 1, to: 2, weight: 3.0)
        g.insertEdge(from: 3, to: 1, weight: 1.0)
        h.insertEdge(from: 2, to: 3, weight: 1.0)
        let gWeights = WeightCarrying.build(from: g)
        let hWeights = WeightCarrying.build(from: h)
        let masked = gWeights * hWeights
        XCTAssertEqual(masked.weight(from: 1, to: 2), 6.0)
        XCTAssertNil(masked.weight(from: 3, to: 1))
        XCTAssertNil(masked.weight(from: 2, to: 3))
    }
    
    func testMultiplicationDirectedBuildOrderMatters() {
        var g = WeightedDirectedGraph<Int, Double>([1,2,3])
        var h = WeightedDirectedGraph<Int, Double>([1,2,3])
        let gWeights = WeightCarrying.build(from: g)
        let hWeights = WeightCarrying.build(from: h)
        g.insertEdge(from: 1, to: 2, weight: 2.0)
        h.insertEdge(from: 1, to: 2, weight: 3.0)
        g.insertEdge(from: 3, to: 1, weight: 1.0)
        h.insertEdge(from: 2, to: 3, weight: 1.0)
        let masked = gWeights * hWeights
        XCTAssertNil(masked.weight(from: 1, to: 2))
        XCTAssertNil(masked.weight(from: 3, to: 1))
        XCTAssertNil(masked.weight(from: 2, to: 3))
    }
    
    func testAddition() {
        var g = WeightedDirectedGraph<Int, Double>([1,2,3])
        var h = WeightedDirectedGraph<Int, Double>([1,2,3])
        g.insertEdge(from: 1, to: 2, weight: 2.0)
        h.insertEdge(from: 1, to: 2, weight: 3.0)
        g.insertEdge(from: 3, to: 1, weight: 1.0)
        h.insertEdge(from: 2, to: 3, weight: 1.0)
        let gWeights = WeightCarrying.build(from: g)
        let hWeights = WeightCarrying.build(from: h)
        let combined = gWeights + hWeights
        XCTAssertEqual(combined.weight(from: 1, to: 2), 5.0)
        XCTAssertEqual(combined.weight(from: 3, to: 1), 1.0)
    }
}
