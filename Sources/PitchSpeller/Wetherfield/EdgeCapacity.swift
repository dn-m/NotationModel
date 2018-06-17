//
//  EdgeCapacity.swift
//  NotationModel
//
//  Created by Ben Wetherfield on .
//  Copyright © 2018 Ben Wetherfield. All rights reserved.
//
enum EdgeCapacity:
    Comparable
{
    case real(Float)
    case bigM(Int)
}

// MARK: - Comparable
func < (lhs: EdgeCapacity, rhs: EdgeCapacity) -> Bool {
    switch lhs {
    case .real(let lval):
        switch rhs {
        case .real(let rval):
            return lval < rval
        case .bigM:
            return true
        }
    case .bigM(let lmult):
        switch rhs {
        case .real:
            return false
        case .bigM(let rmult):
            return lmult < rmult
        }
    default:
        return false
    }
}

func < (lhs: EdgeCapacity, rhs: Float) -> Bool {
    return lhs < EdgeCapacity.real(rhs)
}

func < (lhs: Float, rhs: EdgeCapacity) -> Bool {
    return EdgeCapacity.real(lhs) < rhs
}

// - TODO: implement basic math operations on EdgeCapacities
