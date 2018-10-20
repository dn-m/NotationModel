//
//  EDO12.swift
//  SpelledPitch
//
//  Created by James Bean on 8/18/18.
//

import Pitch

/// Namespace for the `EDO12` (12 equal divisions of the octave) `TuningSystem`.
public enum EDO12: EDO {

    // MARK: - Nested Types

    /// The modifer (represented graphically as an `Accidental`) for a `SpelledPitch` in the
    /// `EDO12` `TuningSystem`.
    public enum Modifier: PitchSpellingModifier {

        /// Single sharp modifier.
        public static let sharp: Modifier = .sharps(count: 1)

        /// Single flat modifier.
        public static let flat: Modifier = .flats(count: 1)

        // MARK: - Cases

        /// Natural modifier.
        case natural

        /// Sharp modifier with degree of sharpness (e.g., double sharp)
        case sharps(count: Int)

        /// Flat modifier with degree of sharpness (e.g., triple flat)
        case flats(count: Int)

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
            case .sharps(let count): return Double(count)
            case .flats(let count): return -Double(count)
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
        case .sharps(let count): return "sharp \(count)"
        case .flats(let count): return "flat: \(count)"
        }
    }
}

public struct LineOfFifths {

    public typealias Position = Int
    public typealias Distance = Int

    // FIXME: Implement with an `OrderedSet`.
    private static let positionByPitchSpelling: [Pitch.Spelling: Position] = [
        Pitch.Spelling(.f, .doubleFlat): -14,
        Pitch.Spelling(.c, .doubleFlat): -13,
        Pitch.Spelling(.g, .doubleFlat): -12,
        Pitch.Spelling(.d, .doubleFlat): -11,
        Pitch.Spelling(.a, .doubleFlat): -10,
        Pitch.Spelling(.e, .doubleFlat): -9,
        Pitch.Spelling(.b, .doubleFlat): -8,
        Pitch.Spelling(.f, .flat): -7,
        Pitch.Spelling(.c, .flat): -6,
        Pitch.Spelling(.g, .flat): -5,
        Pitch.Spelling(.d, .flat): -4,
        Pitch.Spelling(.a, .flat): -3,
        Pitch.Spelling(.e, .flat): -2,
        Pitch.Spelling(.b, .flat): -1,
        Pitch.Spelling(.f, .sharp): 1,
        Pitch.Spelling(.c, .sharp): 2,
        Pitch.Spelling(.g, .sharp): 3,
        Pitch.Spelling(.d, .sharp): 4,
        Pitch.Spelling(.a, .sharp): 5,
        Pitch.Spelling(.e, .sharp): 6,
        Pitch.Spelling(.b, .sharp): 7,
        Pitch.Spelling(.f, .doubleSharp): 8,
        Pitch.Spelling(.c, .doubleSharp): 9,
        Pitch.Spelling(.g, .doubleSharp): 10,
        Pitch.Spelling(.d, .doubleSharp): 11,
        Pitch.Spelling(.a, .doubleSharp): 12,
        Pitch.Spelling(.e, .doubleSharp): 13,
        Pitch.Spelling(.b, .doubleSharp): 14
    ]

    static func position(ofPitchSpelling spelling: Pitch.Spelling) -> Position {
        return positionByPitchSpelling[spelling] ?? 0
    }

    static func distance(ofPitchSpelling pitchSpelling: Pitch.Spelling) -> Position {
        return abs(position(ofPitchSpelling: pitchSpelling))
    }

    static func distance(between a: Pitch.Spelling, and b: Pitch.Spelling) -> Distance {
        return position(ofPitchSpelling: a) - position(ofPitchSpelling: b)
    }
}
