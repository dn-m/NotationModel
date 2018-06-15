//
//  NamedCompoundInterval.swift
//  SpelledPitch
//
//  Created by James Bean on 5/20/18.
//

/// A `NamedOrderedInterval` that can be more than an octave displaced.
public struct NamedCompoundInterval: Invertible {

    /// - Returns: The inverse of `self`.
    public var inverse: NamedCompoundInterval {
        return .init(interval: interval.inverse, octaveDisplacement: octaveDisplacement)
    }

    /// Base interval.
    public let interval: NamedOrderedInterval

    /// Octaves displaced.
    public let octaveDisplacement: UInt
}
