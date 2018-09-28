//
//  Swappable.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 6/30/18.
//

//// - TODO: Move to `dn-m/Structure/DataStructures`
protocol SwappablePair: SymmetricPair { }

extension SwappablePair {
    var swapped: Self { return .init(b,a) }
}
