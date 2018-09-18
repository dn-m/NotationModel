//
//  Swappable.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 6/30/18.
//

protocol SwappablePair: SymmetricPair {
    var swapped: Self { get }
}

extension SwappablePair {
    var swapped: Self { return .init(b, a) }
}
