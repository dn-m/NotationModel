//
//  WeightLabel.swift
//  SpelledPitch
//
//  Created by Benjamin Wetherfield on 09/11/2018.
//

import DataStructures
import Pitch

protocol WeightLabelProtocol: _AdditiveGroup {
    
    associatedtype Edge: SymmetricPair
    
    static func build (_ edge: Edge) -> Self
}

struct WeightLabel<Edge>: WeightLabelProtocol where
    Edge: SymmetricPair & Hashable
{

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

extension WeightLabel: ExpressibleByIntegerLiteral {
    
    // Hack so that `0` -- (or any `IntegerLiteral`) -- evaluates to `.zero`
    init (integerLiteral _: IntegerLiteralType) {
        self = .zero
    }
}

extension WeightLabel: Equatable where Edge: Equatable { }
extension WeightLabel: Comparable where Edge.A: Assigned {
    static func < (lhs: WeightLabel<Edge>, rhs: WeightLabel<Edge>) -> Bool {
        return lhs.edge.flatMap { left in
            rhs.edge.map { right in
                left.a.assignment.rawValue < left.b.assignment.rawValue &&
                !(right.a.assignment.rawValue < right.b.assignment.rawValue)
            }
        } ?? false
    }
}

protocol Assigned {
    var assignment: Tendency { get }
}

protocol _AdditiveGroup {
    
    static var zero: Self { get }
    
    static prefix func - (_ invert: Self) -> Self
    static func + (lhs: Self, rhs: Self) -> Self
    static func - (lhs: Self, rhs: Self) -> Self
}
