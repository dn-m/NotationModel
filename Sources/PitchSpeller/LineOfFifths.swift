//
//  LineOfFifths.swift
//  PitchSpeller
//
//  Created by James Bean on 5/19/16.
//
//

import Pitch

public struct LineOfFifths {
    
    public typealias Position = Int
    public typealias Distance = Int
    
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
    
    public static func position(ofPitchSpelling pitchSpelling: Pitch.Spelling) -> Position {
        return positionByPitchSpelling[pitchSpelling.quantized(to: .halfStep)] ?? 0
    }
    
    public static func distance(ofPitchSpelling pitchSpelling: Pitch.Spelling)
        -> Position
    {
        return abs(position(ofPitchSpelling: pitchSpelling))
    }
    
    public static func distance(between a: Pitch.Spelling, and b: Pitch.Spelling) -> Distance {
        return position(ofPitchSpelling: a) - position(ofPitchSpelling: b)
    }
}

extension Pitch.Spelling {

    // MARK: - Spelling Distance

    public var spellingDistance: LineOfFifths.Distance {
        return LineOfFifths.distance(ofPitchSpelling: self)
    }
}
