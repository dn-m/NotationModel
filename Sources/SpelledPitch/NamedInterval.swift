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

/// Interface for types describing intervals between `SpelledPitch` values.
internal protocol NamedInterval: Invertible {

    // MARK: - Associated Types

    /// Type with level of ordering necessary to construct a `RelativeNamedInterval`.
    associatedtype SpelledPitchType

    /// Type describing ordinality of an `AbsoluteNamedInterval`.
    associatedtype Ordinal: NamedIntervalOrdinal

    /// Unison interval.
    static var unison: Self { get }

    /// MARK: - Instance Properties

    /// Ordinal of a `NamedInterval`.
    var ordinal: Ordinal { get }

    /// Quality of a `NamedInterval`
    var quality: NamedIntervalQuality { get }

    // MARK: - Initializers

    /// Create a `NamedInterval` with a given `quality` and `ordinal`.
    init(_ quality: NamedIntervalQuality, _ ordinal: Ordinal)

    // Instead, use `PitchType` associatedtype
    /// Create a `NamedInterval` with two `SpelledPitch` values.
    init(_ a: SpelledPitchType, _ b: SpelledPitchType)
}

extension NamedInterval {

    // MARK: - `Invertible`

    public var inverse: Self {
        return .init(quality.inverse, ordinal.inverse)
    }
}
