//
//  EDO12.swift
//  SpelledPitch
//
//  Created by James Bean on 8/18/18.
//

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
