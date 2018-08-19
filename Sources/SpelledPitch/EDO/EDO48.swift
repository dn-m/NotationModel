//
//  EDO48.swift
//  SpelledPitch
//
//  Created by James Bean on 8/18/18.
//

/// Namespace for the `EDO48` (48 equal divisions of the octave) `TuningSystem`.
public enum EDO48: EDO {

    // MARK: - Nested Types

    /// The modifer (represented graphically as an `Accidental`) for a `SpelledPitch` in the
    /// `EDO48` `TuningSystem`.
    public struct Modifier: PitchSpellingModifier {

        // MARK: - Nested Types

        /// The modifer (represented graphically as an `Accidental`) for a `SpelledPitch` in the
        /// `EDO48` `TuningSystem`.
        public enum EighthTone: Double, PitchSpellingModifier {

            // MARK: - Cases

            /// Eighth-step up.
            case up = 0.25

            /// None modifier (`EDO24` `quarter sharp`, `three quarter flat`, `natural`, etc. remain
            /// unchanged).
            case none = 0

            /// Eighth-step down.
            case down = -0.25

            // MARK: - Static Properties

            /// A `Modifier` which does not apply any modification.
            public static var identity: EighthTone {
                return .none
            }

            // MARK: - Computed Properties

            /// The amount that a `EDO48.Modifier.Modifier` modifies the base `Pitch.Class` of a
            /// `LetterName` (in percentage of a `NoteNumber`).
            public var adjustment: Double {
                return rawValue
            }
        }

        // MARK: - Static Properties

        /// A `Modifier` which does not apply any modification.
        public static var identity: EDO48.Modifier {
            return .init(edo24: .identity, eighthTone: EighthTone.identity)
        }

        // MARK: - Instance Properties

        /// The `EDO24` subsystem modifier.
        public let edo24: EDO24.Modifier

        /// The `Modifier` which modifies the `adjustment` value `edo24` modifier.
        public let eighthTone: EighthTone

        // MARK: - Computed Properties

        /// The amount that a `EDO48.Modifier` modifies the base `Pitch.Class` of a
        /// `LetterName` (in percentage of a `NoteNumber`).
        public var adjustment: Double { return edo24.adjustment + eighthTone.rawValue }
    }
}

extension EDO48.Modifier: CustomStringConvertible {

    // MARK: - CustomStringConvertible

    /// Printable description of `EDO48.Modifier`.
    public var description: String {
        return [eighthTone.description, edo24.description]
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }
}

extension EDO48.Modifier.EighthTone: CustomStringConvertible {

    /// Printable description of `EDO48.Modifier.Modifier`.
    public var description: String {
        switch self {
        case .down: return "down"
        case .none: return ""
        case .up: return "up"
        }
    }
}
