//
//  WeightLabel.swift
//  SpelledPitch
//
//  Created by Benjamin Wetherfield on 09/11/2018.
//

import Algebra
import DataStructures
import Pitch

struct WeightLabel <Edge: SymmetricPair & Hashable>: AdditiveGroup {

    var inverse: WeightLabel<Edge> {
        return -self
    }

    init (edge: Edge? = nil, plus plusColumn: Set<Edge> = [], minus minusColumn: Set<Edge> = []) {
        self.edge = edge
        self.plusColumn = plusColumn
        self.minusColumn = minusColumn
    }
    
    static var zero: WeightLabel {
        return .init()
    }
    
    static func build(_ edge: Edge) -> WeightLabel {
        return .init(edge: edge, plus: [edge])
    }
    
    static prefix func - (_ invert: WeightLabel) -> WeightLabel {
        return .init(edge: invert.edge, plus: invert.minusColumn, minus: invert.plusColumn)
    }

    static func + (lhs: WeightLabel, rhs: WeightLabel) -> WeightLabel {
        return
            .init(
                edge: lhs.edge,
                plus: lhs.plusColumn.union(rhs.plusColumn)
                    .subtracting(lhs.minusColumn.union(rhs.minusColumn)),
                minus: lhs.minusColumn.union(rhs.minusColumn)
                    .subtracting(lhs.plusColumn.intersection(rhs.plusColumn))
        )
    }
    
    static func - (lhs: WeightLabel, rhs: WeightLabel) -> WeightLabel {
        return lhs + -rhs
    }
    
    let edge: Edge?
    private let plusColumn: Set<Edge>
    private let minusColumn: Set<Edge>
}

extension WeightLabel: Equatable where Edge: Equatable {
    
    static func == (lhs: WeightLabel, rhs: WeightLabel) -> Bool {
        return lhs.plusColumn.subtracting(lhs.minusColumn) == rhs.plusColumn.subtracting(rhs.minusColumn)
    }
}

extension WeightLabel: Comparable where Edge.A: Assigned {
    static func < (lhs: WeightLabel<Edge>, rhs: WeightLabel<Edge>) -> Bool {
        return lhs.edge.flatMap { left in
            rhs.edge.map { right in
                left.a.assignment < left.b.assignment &&
                !(right.a.assignment < right.b.assignment)
            }
        } ?? false
    }
}

protocol Assigned {
    var assignment: Tendency { get }
}
