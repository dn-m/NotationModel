//
//  EDO.swift
//  SpelledPitch
//
//  Created by James Bean on 8/18/18.
//

/// Namespace for the `EDO12` (12 equal divisions of the octave) `TuningSystem`.
public enum EDO12: TuningSystem {

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
public struct EDO24: TuningSystem {

    /// The modifer (represented graphically as an `Accidental`) for a `SpelledPitch` in the
    /// `EDO24` `TuningSystem`.
    public struct Modifier: PitchSpellingModifier {

        // MARK: - Nested Types

        /// The modifer (represented graphically as an `Accidental`) for a `SpelledPitch` in the
        /// `EDO24` `TuningSystem`.
        public enum Modifier: Double {

            // MARK: - Cases

            /// Quarter modifier.
            case quarter = 0.5

            /// None modifier (`EDO12` `sharp`, `flat`, `natural` remain unchanged).
            case none = 1

            /// Three-quarter modifier.
            case threeQuarter = 1.5
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
        var string: String? {
            switch self.modifier {
            case .quarter: return "quarter"
            case .none: return nil
            case .threeQuarter: return "three quarter"
            }
        }
        return [string, edo12.description].compactMap { $0 }.joined(separator: " ")
    }
}

/// Namespace for the `EDO48` (48 equal divisions of the octave) `TuningSystem`.
public enum EDO48: TuningSystem {

    // MARK: - Nested Types

    /// The modifer (represented graphically as an `Accidental`) for a `SpelledPitch` in the
    /// `EDO48` `TuningSystem`.
    public struct Modifier: PitchSpellingModifier {

        // MARK: - Nested Types

        /// The modifer (represented graphically as an `Accidental`) for a `SpelledPitch` in the
        /// `EDO48` `TuningSystem`.
        public enum Modifier: Double {

            // MARK: - Cases

            /// Eighth-step up.
            case up = 0.25

            /// None modifier (`EDO24` `quarter sharp`, `three quarter flat`, `natural`, etc. remain
            /// unchanged).
            case none = 0

            /// Eighth-step down.
            case down = -0.25

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
        var string: String? {
            switch self.modifier {
            case .down: return "down"
            case .none: return nil
            case .up: return "up"
            }
        }
        return [string, edo24.description].compactMap { $0 }.joined(separator: " ")
    }
}
