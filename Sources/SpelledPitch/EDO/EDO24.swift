//
//  EDO24.swift
//  SpelledPitch
//
//  Created by James Bean on 8/18/18.
//

/// Namespace for the `EDO24` (24 equal divisions of the octave) `TuningSystem`.
public struct EDO24: EDO {

    /// The modifer (represented graphically as an `Accidental`) for a `SpelledPitch` in the
    /// `EDO24` `TuningSystem`.
    public struct Modifier: PitchSpellingModifier {

        // MARK: - Nested Types

        /// The modifer (represented graphically as an `Accidental`) for a `SpelledPitch` in the
        /// `EDO24` `TuningSystem`.
        public enum QuarterTone: Double, PitchSpellingModifier {

            // MARK: - Cases

            /// Quarter modifier.
            case quarter = 0.5

            /// None modifier (`EDO12` `sharp`, `flat`, `natural` remain unchanged).
            case none = 1

            /// Three-quarter modifier.
            case threeQuarter = 1.5

            // MARK: - Static Properties

            /// A `Modifier` which does not apply any modification.
            public static var identity: EDO24.Modifier.QuarterTone {
                return .none
            }

            // MARK: - Computed Properties

            /// The amount that a `EDO24.Modifier.Modifier` modifies the base `Pitch.Class` of a
            /// `LetterName` (in percentage of a `NoteNumber`).
            public var adjustment: Double {
                return rawValue
            }
        }

        // MARK: - Static Properties

        /// A `Modifier` which does not apply any modification.
        public static var identity: EDO24.Modifier {
            return .init(edo12: .identity, quarterTone: QuarterTone.identity)
        }

        // MARK: - Instance Properties

        /// The `EDO12` subsystem modifier.
        public let edo12: EDO12.Modifier

        /// The `Modifier` which modifies the `adjustment` value `edo12` modifier.
        public let quarterTone: QuarterTone

        /// The amount that a `EDO24.Modifier` modifies the base `Pitch.Class` of a
        /// `LetterName` (in percentage of a `NoteNumber`).
        public var adjustment: Double { return edo12.adjustment * quarterTone.rawValue }
    }
}

extension EDO24.Modifier: CustomStringConvertible {

    // MARK: - CustomStringConvertible

    /// Printable description of `EDO24.Modifier`.
    public var description: String {
        return [quarterTone.description, edo12.description]
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }
}

extension EDO24.Modifier.QuarterTone: CustomStringConvertible {

    /// Printable description of `EDO24.Modifier.Modifier`.
    public var description: String {
        switch self {
        case .quarter: return "quarter"
        case .none: return ""
        case .threeQuarter: return "three quarter"
        }
    }
}
