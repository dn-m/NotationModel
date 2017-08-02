//
//  LineOfFifths.swift
//  SpelledPitch
//
//  Created by James Bean on 5/19/16.
//
//

internal struct LineOfFifths {
    
    internal typealias Position = Int
    internal typealias Distance = Int
    
    private static let positionByPitchSpelling: [PitchSpelling: Position] = [
        PitchSpelling(.f, .doubleFlat): -14,
        PitchSpelling(.c, .doubleFlat): -13,
        PitchSpelling(.g, .doubleFlat): -12,
        PitchSpelling(.d, .doubleFlat): -11,
        PitchSpelling(.a, .doubleFlat): -10,
        PitchSpelling(.e, .doubleFlat): -9,
        PitchSpelling(.b, .doubleFlat): -8,
        PitchSpelling(.f, .flat): -7,
        PitchSpelling(.c, .flat): -6,
        PitchSpelling(.g, .flat): -5,
        PitchSpelling(.d, .flat): -4,
        PitchSpelling(.a, .flat): -3,
        PitchSpelling(.e, .flat): -2,
        PitchSpelling(.b, .flat): -1,
        PitchSpelling(.f, .sharp): 1,
        PitchSpelling(.c, .sharp): 2,
        PitchSpelling(.g, .sharp): 3,
        PitchSpelling(.d, .sharp): 4,
        PitchSpelling(.a, .sharp): 5,
        PitchSpelling(.e, .sharp): 6,
        PitchSpelling(.b, .sharp): 7,
        PitchSpelling(.f, .doubleSharp): 8,
        PitchSpelling(.c, .doubleSharp): 9,
        PitchSpelling(.g, .doubleSharp): 10,
        PitchSpelling(.d, .doubleSharp): 11,
        PitchSpelling(.a, .doubleSharp): 12,
        PitchSpelling(.e, .doubleSharp): 13,
        PitchSpelling(.b, .doubleSharp): 14
    ]
    
    internal static func position(ofPitchSpelling pitchSpelling: PitchSpelling) -> Position {
        return positionByPitchSpelling[pitchSpelling.quantized(to: .halfStep)] ?? 0
    }
    
    internal static func distance(ofPitchSpelling pitchSpelling: PitchSpelling)
        -> Position
    {
        return abs(position(ofPitchSpelling: pitchSpelling))
    }
    
    internal static func distance(between a: PitchSpelling, and b: PitchSpelling) -> Distance {
        return position(ofPitchSpelling: a) - position(ofPitchSpelling: b)
    }
}
