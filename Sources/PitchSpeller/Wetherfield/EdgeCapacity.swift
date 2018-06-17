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
    }
}

func < (lhs: EdgeCapacity, rhs: Float) -> Bool {
    return lhs < EdgeCapacity.real(rhs)
}

func < (lhs: Float, rhs: EdgeCapacity) -> Bool {
    return EdgeCapacity.real(lhs) < rhs
}

// MARK: - Math
func + (augend: EdgeCapacity, addend: EdgeCapacity) -> EdgeCapacity {
    switch augend {
    case .real(let lval):
        switch addend {
        case .real(let rval):
            return .real(lval + rval)
        case .bigM:
            return addend
        }
    case .bigM(let lmult):
        switch addend {
        case .real:
            return augend
        case .bigM(let rmult):
            return .bigM(lmult + rmult)
        }
    }
}
