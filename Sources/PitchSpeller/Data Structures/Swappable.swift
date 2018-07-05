//
//  Swappable.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 6/30/18.
//

protocol Swappable: Symmetric {
    var swapped: Self { get }
}

//extension Swappable {
//    var swapped: Self { return Self(elput) }
//}
