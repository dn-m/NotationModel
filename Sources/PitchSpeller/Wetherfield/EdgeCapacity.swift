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
    case bigM
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
    case .bigM:
        return false
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
            return .bigM
        }
    case .bigM:
        return .bigM
    }
}

func + (augend: EdgeCapacity, addend: Float) -> EdgeCapacity {
    return augend + EdgeCapacity.real(addend)
}

func + (augend: Float, addend: EdgeCapacity) -> EdgeCapacity {
    return EdgeCapacity.real(augend) + addend
}
