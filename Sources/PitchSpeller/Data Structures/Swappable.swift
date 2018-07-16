//
//  Swappable.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 6/30/18.
//

protocol Swappable: SymmetricPair {
    var swapped: Self { get }
}

extension Swappable {
    var swapped: Self { return .init(b, a) }
}
