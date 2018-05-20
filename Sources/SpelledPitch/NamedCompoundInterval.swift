//
//  NamedCompoundInterval.swift
//  SpelledPitch
//
//  Created by James Bean on 5/20/18.
//

/// A `NamedOrderedInterval` that can be more than an octave displaced.
public struct NamedCompoundInterval {
    public let interval: NamedOrderedInterval
    public let octaveDisplacement: UInt
}
