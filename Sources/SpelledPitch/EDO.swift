//
//  EDO.swift
//  SpelledPitch
//
//  Created by James Bean on 8/18/18.
//

/// Interface for the `EDO` (equal divisions of the octave) `TuningSystem` types.
public protocol EDO: TuningSystem { }

/// Interface for `Modifier` types within an `EDO` `TuningSystem`.
protocol EDOModifier {

    // MARK: - Static Properties

    /// A `Modifier` which does not apply any modification.
    static var identity: Self { get }
}

/// Namespace for the `EDO12` (12 equal divisions of the octave) `TuningSystem`.
public enum EDO12: EDO {

    // MARK: - Nested Types

    /// The modifer (represented graphically as an `Accidental`) for a `SpelledPitch` in the
    /// `EDO12` `TuningSystem`.
    public enum Modifier: PitchSpellingModifier {

        // MARK: - Cases

        /// Natural modifier.
        case natural

        /// Sharp modifier with degree of sharpness (e.g., double sharp)
        case sharp(Int)

        /// Flat modifier with degree of sharpness (e.g., triple flat)
        case flat(Int)

        // MARK: - Static Properties

        /// A `Modifier` which does not apply any modification.
        public static var identity: Modifier {
            return .natural
        }

        /// The amount that a `EDO12.Modifier` modifies the base `Pitch.Class` of a
        /// `LetterName` (in percentage of a `NoteNumber`).
        public var adjustment: Double {
            switch self {
            case .natural: return 0
            case .sharp(let count): return Double(count)
            case .flat(let count): return -Double(count)
            }
        }
    }
}

extension EDO12.Modifier: CustomStringConvertible {

    // MARK: - CustomStringConvertible

    /// Printable description of `EDO12.Modifier`.
    public var description: String {
        switch self {
        case .natural: return "natural"
        case .sharp(let count): return "sharp \(count)"
        case .flat(let count): return "flat: \(count)"
        }
    }
}

/// Namespace for the `EDO24` (24 equal divisions of the octave) `TuningSystem`.
public struct EDO24: EDO {

    /// The modifer (represented graphically as an `Accidental`) for a `SpelledPitch` in the
    /// `EDO24` `TuningSystem`.
    public struct Modifier: PitchSpellingModifier {

        // MARK: - Nested Types

        /// The modifer (represented graphically as an `Accidental`) for a `SpelledPitch` in the
        /// `EDO24` `TuningSystem`.
        public enum Modifier: Double, PitchSpellingModifier {

            // MARK: - Cases

            /// Quarter modifier.
            case quarter = 0.5

            /// None modifier (`EDO12` `sharp`, `flat`, `natural` remain unchanged).
            case none = 1

            /// Three-quarter modifier.
            case threeQuarter = 1.5

            // MARK: - Static Properties

            /// A `Modifier` which does not apply any modification.
            public static var identity: EDO24.Modifier.Modifier {
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
            return .init(edo12: .identity, modifier: Modifier.identity)
        }

        // MARK: - Instance Properties

        /// The `EDO12` subsystem modifier.
        public let edo12: EDO12.Modifier

        /// The `Modifier` which modifies the `adjustment` value `edo12` modifier.
        public let modifier: Modifier

        /// The amount that a `EDO24.Modifier` modifies the base `Pitch.Class` of a
        /// `LetterName` (in percentage of a `NoteNumber`).
        public var adjustment: Double { return edo12.adjustment * modifier.rawValue }
    }
}

extension EDO24.Modifier: CustomStringConvertible {

    // MARK: - CustomStringConvertible

    /// Printable description of `EDO24.Modifier`.
    public var description: String {
        return [modifier.description, edo12.description]
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }
}

extension EDO24.Modifier.Modifier: CustomStringConvertible {

    /// Printable description of `EDO24.Modifier.Modifier`.
    public var description: String {
        switch self {
        case .quarter: return "quarter"
        case .none: return ""
        case .threeQuarter: return "three quarter"
        }
    }
}


/// Namespace for the `EDO48` (48 equal divisions of the octave) `TuningSystem`.
public enum EDO48: EDO {

    // MARK: - Nested Types

    /// The modifer (represented graphically as an `Accidental`) for a `SpelledPitch` in the
    /// `EDO48` `TuningSystem`.
    public struct Modifier: PitchSpellingModifier {

        // MARK: - Nested Types

        /// The modifer (represented graphically as an `Accidental`) for a `SpelledPitch` in the
        /// `EDO48` `TuningSystem`.
        public enum Modifier: Double, PitchSpellingModifier {

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
            public static var identity: Modifier {
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
            return .init(edo24: .identity, modifier: Modifier.identity)
        }

        // MARK: - Instance Properties

        /// The `EDO24` subsystem modifier.
        public let edo24: EDO24.Modifier

        /// The `Modifier` which modifies the `adjustment` value `edo24` modifier.
        public let modifier: Modifier

        // MARK: - Computed Properties

        /// The amount that a `EDO48.Modifier` modifies the base `Pitch.Class` of a
        /// `LetterName` (in percentage of a `NoteNumber`).
        public var adjustment: Double { return edo24.adjustment + modifier.rawValue }
    }
}

extension EDO48.Modifier: CustomStringConvertible {

    // MARK: - CustomStringConvertible

    /// Printable description of `EDO48.Modifier`.
    public var description: String {
        return [modifier.description, edo24.description]
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }
}

extension EDO48.Modifier.Modifier: CustomStringConvertible {

    /// Printable description of `EDO48.Modifier.Modifier`.
    public var description: String {
        switch self {
        case .down: return "down"
        case .none: return ""
        case .up: return "up"
        }
    }
}
