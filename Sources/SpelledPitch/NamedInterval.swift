//
//  NamedInterval.swift
//  SpelledPitch
//
//  Created by James Bean on 8/9/16.
//
//

import Structure
import Pitch

/// Interface for types describing intervals between `SpelledPitch` values.
public protocol NamedInterval: Invertible, Equatable {

    // MARK: - Associated Types

    /// Type with level of ordering necessary to construct a `RelativeNamedInterval`.
    associatedtype SpelledPitchType

    /// Type describing ordinality of an `AbsoluteNamedInterval`.
    associatedtype Ordinal: NamedIntervalOrdinal

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

/// - returns: `true` if the given `quality` and `ordinal` can be paired to create a valid
/// `NamedInterval`. Otherwise, `false`.
///
/// **Example:**
/// ```
/// areValid(.major, .third) // true
/// areValid(.augmented, .second) // true
/// areValid(.perfect, .fourth) // true
/// areValid(.perfect, .second) // false
/// areValid(.major, .second) // false
/// ```
public func areValid <O> (_ quality: NamedIntervalQuality, _ ordinal: O) -> Bool
    where O: NamedIntervalOrdinal
{

    if ordinal.isPerfect && quality.isPerfect || ordinal.isImperfect && quality.isImperfect {
        return true
    }

    return false
}

extension NamedInterval {

    // MARK: - `Equatable`

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return (
            lhs.ordinal == rhs.ordinal &&
            lhs.quality == rhs.quality &&
            lhs.quality.degree == rhs.quality.degree
        )
    }
}

extension NamedInterval {

    // MARK: - `Invertible`

    public var inverse: Self {
        return .init(quality.inverse, ordinal.inverse)
    }
}


