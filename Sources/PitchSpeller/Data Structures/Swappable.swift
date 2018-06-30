//
//  Swappable.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 6/30/18.
//

protocol Swappable: Symmetric {
    var elput: (A,A) { get }
    var swapped: Self { get }
}

extension Swappable {
    var elput: (A,A) { get { return (tuple.1, tuple.0) } }
}
