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
    private static let positionByPitchSpelling: [Pitch.Spelling<EDO12>: Position] = [
        Pitch.Spelling(.f, .flats(count: 2)): -14,
        Pitch.Spelling(.c, .flats(count: 2)): -13,
        Pitch.Spelling(.g, .flats(count: 2)): -12,
        Pitch.Spelling(.d, .flats(count: 2)): -11,
        Pitch.Spelling(.a, .flats(count: 2)): -10,
        Pitch.Spelling(.e, .flats(count: 2)): -9,
        Pitch.Spelling(.b, .flats(count: 2)): -8,
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
        Pitch.Spelling(.f, .sharps(count: 2)): 8,
        Pitch.Spelling(.c, .sharps(count: 2)): 9,
        Pitch.Spelling(.g, .sharps(count: 2)): 10,
        Pitch.Spelling(.d, .sharps(count: 2)): 11,
        Pitch.Spelling(.a, .sharps(count: 2)): 12,
        Pitch.Spelling(.e, .sharps(count: 2)): 13,
        Pitch.Spelling(.b, .sharps(count: 2)): 14
    ]

    static func position(ofPitchSpelling spelling: Pitch.Spelling<EDO12>) -> Position {
        return positionByPitchSpelling[spelling] ?? 0
    }

    static func distance(ofPitchSpelling pitchSpelling: Pitch.Spelling<EDO12>) -> Position {
        return abs(position(ofPitchSpelling: pitchSpelling))
    }

    static func distance(between a: Pitch.Spelling<EDO12>, and b: Pitch.Spelling<EDO12>) -> Distance {
        return position(ofPitchSpelling: a) - position(ofPitchSpelling: b)
    }
}
