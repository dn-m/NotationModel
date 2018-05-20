//
//  Invertible.swift
//  SpelledPitch
//
//  Created by James Bean on 5/20/18.
//

/// Move to `DataStructures` or `Algebra`?
public protocol Invertible {
    var inverse: Self { get }
}
