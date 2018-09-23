//
//  Symmetric.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 6/30/18.
//

protocol SymmetricPair: Pair where A == B { }

extension SymmetricPair where A: Equatable {

    func contains(_ value: A) -> Bool {
        return a == value || b == value
    }
}
