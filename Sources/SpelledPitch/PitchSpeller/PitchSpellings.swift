//
//  PitchSpellings.swift
//  SpelledPitch
//
//  Created by James Bean on 5/1/16.
//
//

import Pitch

/// Collection of `Pitch.Spelling` values stored by `Pitch.Class`.
public enum PitchSpellings {
    
    private static let spellingsByPitchClass: [Pitch.Class: [Pitch.Spelling]] = [
        
        00.00: [
            Pitch.Spelling(.c),
            Pitch.Spelling(.b, .sharp),
            Pitch.Spelling(.d, .doubleFlat)
        ],
        
        00.25: [
            Pitch.Spelling(.c, .natural, .up),
            Pitch.Spelling(.c, .quarterSharp, .down),
            Pitch.Spelling(.d, .threeQuarterFlat, .down)
        ],
        
        00.50: [
            Pitch.Spelling(.c, .quarterSharp),
            Pitch.Spelling(.d, .threeQuarterFlat)
        ],
        
        00.75: [
            Pitch.Spelling(.c, .sharp, .down),
            Pitch.Spelling(.d, .flat, .down),
            Pitch.Spelling(.c, .quarterSharp, .up),
            Pitch.Spelling(.d, .threeQuarterFlat, .up)
        ],
        
        01.00: [
            Pitch.Spelling(.c, .sharp),
            Pitch.Spelling(.d, .flat)
        ],
        
        01.25: [
            Pitch.Spelling(.c, .sharp, .up),
            Pitch.Spelling(.d, .flat, .up),
            Pitch.Spelling(.d, .quarterFlat, .down),
            Pitch.Spelling(.c, .threeQuarterSharp, .down)
        ],
        
        01.50: [
            Pitch.Spelling(.d, .quarterFlat),
            Pitch.Spelling(.c, .threeQuarterSharp)
        ],
        
        01.75: [
            Pitch.Spelling(.d, .natural, .down),
            Pitch.Spelling(.d, .quarterFlat, .up)
        ],
        
        02.00: [
            Pitch.Spelling(.d),
            Pitch.Spelling(.c, .doubleSharp),
            Pitch.Spelling(.e, .doubleFlat)
        ],
        
        02.25: [
            Pitch.Spelling(.d, .natural, .up),
            Pitch.Spelling(.d, .quarterSharp, .down),
            Pitch.Spelling(.e, .threeQuarterFlat, .down)
        ],
        
        02.50: [
            Pitch.Spelling(.d, .quarterSharp),
            Pitch.Spelling(.e, .threeQuarterFlat)
        ],
        
        02.75: [
            Pitch.Spelling(.e, .flat, .down),
            Pitch.Spelling(.d, .sharp, .down),
            Pitch.Spelling(.d, .quarterSharp, .up),
            Pitch.Spelling(.e, .threeQuarterFlat, .up)
        ],
        
        03.00: [
            Pitch.Spelling(.e, .flat),
            Pitch.Spelling(.d, .sharp),
            Pitch.Spelling(.f, .doubleFlat)
        ],
        
        03.25: [
            Pitch.Spelling(.e, .flat, .up),
            Pitch.Spelling(.d, .sharp, .up),
            Pitch.Spelling(.e, .quarterFlat, .down),
            Pitch.Spelling(.d, .threeQuarterSharp, .down)
        ],
        
        03.50: [
            Pitch.Spelling(.e, .quarterFlat),
            Pitch.Spelling(.d, .threeQuarterSharp)
        ],
        
        03.75: [
            Pitch.Spelling(.e, .natural, .down),
            Pitch.Spelling(.e, .quarterFlat, .up),
            Pitch.Spelling(.d, .threeQuarterSharp, .up)
        ],
        
        04.00: [
            Pitch.Spelling(.e),
            Pitch.Spelling(.f, .flat),
            Pitch.Spelling(.d, .doubleSharp)
        ],
        
        04.25: [
            Pitch.Spelling(.e, .natural, .up),
            Pitch.Spelling(.e, .quarterSharp, .down),
            Pitch.Spelling(.f, .quarterFlat, .down)
        ],
        
        04.50: [
            Pitch.Spelling(.e, .quarterSharp),
            Pitch.Spelling(.f, .quarterFlat)
        ],
        
        04.75: [
            Pitch.Spelling(.f, .natural, .down),
            Pitch.Spelling(.e, .quarterSharp, .up),
            Pitch.Spelling(.f, .quarterFlat, .up)
        ],
        
        05.00: [
            Pitch.Spelling(.f),
            Pitch.Spelling(.e, .sharp),
            Pitch.Spelling(.g, .doubleFlat)
        ],
        
        05.25: [
            Pitch.Spelling(.f, .natural, .up),
            Pitch.Spelling(.f, .quarterSharp, .down),
            Pitch.Spelling(.g, .threeQuarterFlat, .down)
        ],
        
        05.50: [
            Pitch.Spelling(.f, .quarterSharp),
            Pitch.Spelling(.g, .threeQuarterFlat)
        ],
        
        05.75: [
            Pitch.Spelling(.f, .sharp, .down),
            Pitch.Spelling(.g, .flat, .down),
            Pitch.Spelling(.f, .quarterSharp, .up),
            Pitch.Spelling(.g, .threeQuarterSharp, .up)
        ],
        
        06.00: [
            Pitch.Spelling(.f, .sharp),
            Pitch.Spelling(.g, .flat)
        ],
        
        06.25: [
            Pitch.Spelling(.f, .sharp, .up),
            Pitch.Spelling(.g, .flat, .up),
            Pitch.Spelling(.g, .quarterFlat, .down),
            Pitch.Spelling(.f, .threeQuarterSharp, .down)
        ],
        
        06.50: [
            Pitch.Spelling(.g, .quarterFlat),
            Pitch.Spelling(.f, .threeQuarterSharp)
        ],
        
        06.75: [
            Pitch.Spelling(.g, .natural, .down),
            Pitch.Spelling(.g, .quarterFlat, .up),
            Pitch.Spelling(.f, .threeQuarterSharp, .up)
        ],
        
        07.00: [
            Pitch.Spelling(.g),
            Pitch.Spelling(.f, .doubleSharp),
            Pitch.Spelling(.a, .doubleFlat)
        ],
        
        07.25: [
            Pitch.Spelling(.g, .natural, .up),
            Pitch.Spelling(.g, .quarterSharp, .down),
            Pitch.Spelling(.a, .threeQuarterFlat, .down)
        ],
        
        07.50: [
            Pitch.Spelling(.g, .quarterSharp),
            Pitch.Spelling(.a, .threeQuarterFlat)
        ],
        
        07.75: [
            Pitch.Spelling(.g, .sharp, .down),
            Pitch.Spelling(.a, .flat, .down),
            Pitch.Spelling(.g, .quarterSharp, .up),
            Pitch.Spelling(.a, .threeQuarterFlat, .up),
        ],
        
        08.00: [
            Pitch.Spelling(.a, .flat),
            Pitch.Spelling(.g, .sharp)
        ],
        
        08.25: [
            Pitch.Spelling(.g, .sharp, .up),
            Pitch.Spelling(.a, .flat, .up),
            Pitch.Spelling(.a, .quarterFlat, .down),
            Pitch.Spelling(.g, .threeQuarterSharp, .down)
        ],
        
        08.50: [
            Pitch.Spelling(.a, .quarterFlat),
            Pitch.Spelling(.g, .threeQuarterSharp)
        ],
        
        08.75: [
            Pitch.Spelling(.a, .natural, .down),
            Pitch.Spelling(.a, .quarterFlat, .up),
            Pitch.Spelling(.g, .threeQuarterSharp, .up)
        ],
        
        09.00: [
            Pitch.Spelling(.a),
            Pitch.Spelling(.g, .doubleSharp),
            Pitch.Spelling(.b, .doubleFlat)
        ],
        
        09.25: [
            Pitch.Spelling(.a, .natural, .up),
            Pitch.Spelling(.a, .quarterSharp, .down),
            Pitch.Spelling(.b, .threeQuarterFlat, .down)
        ],
        
        09.50: [
            Pitch.Spelling(.a, .quarterSharp)
        ],
        
        09.75: [
            Pitch.Spelling(.b, .flat, .down),
            Pitch.Spelling(.a, .sharp, .down),
            Pitch.Spelling(.b, .threeQuarterFlat, .up),
            Pitch.Spelling(.a, .quarterSharp, .up),
        ],
        
        10.00: [
            Pitch.Spelling(.b, .flat),
            Pitch.Spelling(.a, .sharp),
            Pitch.Spelling(.c, .doubleFlat)
        ],
        
        10.25: [
            Pitch.Spelling(.b, .flat, .up),
            Pitch.Spelling(.a, .sharp, .up),
            Pitch.Spelling(.b, .quarterFlat, .down),
            Pitch.Spelling(.a, .threeQuarterSharp, .down)
        ],
        
        10.50: [
            Pitch.Spelling(.b, .quarterFlat),
            Pitch.Spelling(.a, .threeQuarterSharp)
        ],
        
        10.75: [
            Pitch.Spelling(.b, .natural, .down),
            Pitch.Spelling(.b, .quarterFlat, .up),
            Pitch.Spelling(.a, .threeQuarterSharp, .up)
        ],
        
        11.00: [
            Pitch.Spelling(.b),
            Pitch.Spelling(.c, .flat),
            Pitch.Spelling(.a, .doubleSharp)
        ],
        
        11.25: [
            Pitch.Spelling(.b, .natural, .up),
            Pitch.Spelling(.b, .quarterSharp, .down),
            Pitch.Spelling(.c, .quarterFlat, .down)
        ],
        
        11.50: [
            Pitch.Spelling(.b, .quarterSharp),
            Pitch.Spelling(.c, .quarterFlat)
        ],
        
        11.75: [
            Pitch.Spelling(.c, .natural, .down),
            Pitch.Spelling(.b, .quarterSharp, .up),
            Pitch.Spelling(.c, .quarterFlat, .up),
        ]
    ]
    
    public static func spellings(forPitchClass pitchClass: Pitch.Class) -> [Pitch.Spelling]? {
        return PitchSpellings.spellingsByPitchClass[pitchClass]
    }
    
    public static func defaultSpelling(forPitchClass pitchClass: Pitch.Class) -> Pitch.Spelling? {
        return spellings(forPitchClass: pitchClass)?.first
    }
}

