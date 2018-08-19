//
//  LineOfFifths.swift
//  PitchSpeller
//
//  Createsd by James Bean on 5/19/16.
//
//

import Pitch

public struct LineOfFifths {

    public typealias Position = Int
    public typealias Distance = Int

    // FIXME: Implement with an `OrderedSet`.
    private static let positionByPitchSpelling: [Pitch.Spelling<EDO12>: Position] = [
        Pitch.Spelling(.f, .flat(2)): -14,
        Pitch.Spelling(.c, .flat(2)): -13,
        Pitch.Spelling(.g, .flat(2)): -12,
        Pitch.Spelling(.d, .flat(2)): -11,
        Pitch.Spelling(.a, .flat(2)): -10,
        Pitch.Spelling(.e, .flat(2)): -9,
        Pitch.Spelling(.b, .flat(2)): -8,
        Pitch.Spelling(.f, .flat(1)): -7,
        Pitch.Spelling(.c, .flat(1)): -6,
        Pitch.Spelling(.g, .flat(1)): -5,
        Pitch.Spelling(.d, .flat(1)): -4,
        Pitch.Spelling(.a, .flat(1)): -3,
        Pitch.Spelling(.e, .flat(1)): -2,
        Pitch.Spelling(.b, .flat(1)): -1,
        Pitch.Spelling(.f, .sharp(1)): 1,
        Pitch.Spelling(.c, .sharp(1)): 2,
        Pitch.Spelling(.g, .sharp(1)): 3,
        Pitch.Spelling(.d, .sharp(1)): 4,
        Pitch.Spelling(.a, .sharp(1)): 5,
        Pitch.Spelling(.e, .sharp(1)): 6,
        Pitch.Spelling(.b, .sharp(1)): 7,
        Pitch.Spelling(.f, .sharp(2)): 8,
        Pitch.Spelling(.c, .sharp(2)): 9,
        Pitch.Spelling(.g, .sharp(2)): 10,
        Pitch.Spelling(.d, .sharp(2)): 11,
        Pitch.Spelling(.a, .sharp(2)): 12,
        Pitch.Spelling(.e, .sharp(2)): 13,
        Pitch.Spelling(.b, .sharp(2)): 14
    ]

    public static func position(ofPitchSpelling spelling: Pitch.Spelling<EDO12>) -> Position {
        return positionByPitchSpelling[spelling] ?? 0
    }

    public static func distance(ofPitchSpelling pitchSpelling: Pitch.Spelling<EDO12>)
        -> Position
    {
        return abs(position(ofPitchSpelling: pitchSpelling))
    }

    public static func distance(between a: Pitch.Spelling<EDO12>, and b: Pitch.Spelling<EDO12>) -> Distance {
        return position(ofPitchSpelling: a) - position(ofPitchSpelling: b)
    }
}

extension Pitch.Spelling where Tuning == EDO12 {

    // MARK: - Spelling Distance

    public var spellingDistance: LineOfFifths.Distance {
        return LineOfFifths.distance(ofPitchSpelling: self)
    }
}
