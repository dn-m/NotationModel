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

        static let flat: Modifier = .flat(count: 1)
        static let sharp: Modifier = .sharp(count: 1)

        // MARK: - Cases

        /// Natural modifier.
        case natural

        /// Sharp modifier with degree of sharpness (e.g., double sharp)
        case sharp(count: Int)

        /// Flat modifier with degree of sharpness (e.g., triple flat)
        case flat(count: Int)

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

public struct LineOfFifths {

    public typealias Position = Int
    public typealias Distance = Int

    // FIXME: Implement with an `OrderedSet`.
    private static let positionByPitchSpelling: [Pitch.Spelling<EDO12>: Position] = [
        Pitch.Spelling(.f, .flat): -14,
        Pitch.Spelling(.c, .flat): -13,
        Pitch.Spelling(.g, .flat): -12,
        Pitch.Spelling(.d, .flat): -11,
        Pitch.Spelling(.a, .flat): -10,
        Pitch.Spelling(.e, .flat): -9,
        Pitch.Spelling(.b, .flat): -8,
        Pitch.Spelling(.f, .flat): -7,
        Pitch.Spelling(.c, .flat): -6,
        Pitch.Spelling(.g, .flat): -5,
        Pitch.Spelling(.d, .flat): -4,
        Pitch.Spelling(.a, .flat): -3,
        Pitch.Spelling(.e, .flat): -2,
        Pitch.Spelling(.b, .flat): -1,
        Pitch.Spelling(.f, .sharp(count: 1)): 1,
        Pitch.Spelling(.c, .sharp(count: 1)): 2,
        Pitch.Spelling(.g, .sharp(count: 1)): 3,
        Pitch.Spelling(.d, .sharp(count: 1)): 4,
        Pitch.Spelling(.a, .sharp(count: 1)): 5,
        Pitch.Spelling(.e, .sharp(count: 1)): 6,
        Pitch.Spelling(.b, .sharp(count: 1)): 7,
        Pitch.Spelling(.f, .sharp(count: 2)): 8,
        Pitch.Spelling(.c, .sharp(count: 2)): 9,
        Pitch.Spelling(.g, .sharp(count: 2)): 10,
        Pitch.Spelling(.d, .sharp(count: 2)): 11,
        Pitch.Spelling(.a, .sharp(count: 2)): 12,
        Pitch.Spelling(.e, .sharp(count: 2)): 13,
        Pitch.Spelling(.b, .sharp(count: 2)): 14
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
