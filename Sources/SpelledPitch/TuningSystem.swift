//
//  TuningSystem.swift
//  SpelledPitch
//
//  Created by James Bean on 8/18/18.
//

/// Interface for types which implement a tuning system.
///
/// - Note: Consider pushing into `Music/Pitch` module.
public protocol TuningSystem {

    // MARK: - Associated Types

    /// The type which is the model layer of an `Accidental`.
    associatedtype Modifier: PitchSpellingModifier
}

/// Interface for types which modify a `LetterName` value. Graphically repesented as components of
/// an `Accidental`.
public protocol PitchSpellingModifier: Comparable, Hashable, CustomStringConvertible {

    // MARK: - Instance Properties

    /// A `PitchSpellingModifier` which does not apply any modification.
    static var identity: Self { get }

    /// The amount that a `PitchSpellingModifier` modifies the base `Pitch.Class` of a `LetterName`
    /// (in percentage of a `NoteNumber`).
    var adjustment: Double { get }
}

extension PitchSpellingModifier {

    // MARK: - Equatable

    /// - Returns: `true` if the `adjustment` property of the `lhs` value is equal to the
    /// `adjustment` property of the `rhs` value. Otherwise `false`.
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.adjustment == rhs.adjustment
    }
}

extension PitchSpellingModifier {

    // MARK: - Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(adjustment)
    }
}

extension PitchSpellingModifier {

    // MARK: - Comparable

    /// - Returns: `true` if the `adjustment` property of the `lhs` value is less than the
    /// `adjustment` property of the `rhs` value. Otherwise `false`.
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.adjustment < rhs.adjustment
    }
}
