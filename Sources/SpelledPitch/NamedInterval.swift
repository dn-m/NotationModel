//
//  NamedInterval.swift
//  SpelledPitch
//
//  Created by James Bean on 8/9/16.
//
//

import DataStructures
import Pitch

/// Move to `DataStructures` or `Algebra`?
public protocol Invertible {
    var inverse: Self { get }
}
