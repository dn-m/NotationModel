//
//  PitchSpellings.swift
//  SpelledPitch
//
//  Created by James Bean on 5/1/16.
//
//

import Pitch

// FIXME: Implement with `enum` to avoid initialization
internal struct PitchSpellings {
    
    /// - FIXME: Ensure this is exhaustive and correct!
    fileprivate static let spellingsByPitchClass: [Pitch.Class: [PitchSpelling]] = [
        
        00.00: [
            PitchSpelling(.c),
            PitchSpelling(.b, .sharp),
            PitchSpelling(.d, .doubleFlat)
        ],
        
        00.25: [
            PitchSpelling(.c, .natural, .up),
            PitchSpelling(.c, .quarterSharp, .down),
            PitchSpelling(.d, .threeQuarterFlat, .down)
        ],
        
        00.50: [
            PitchSpelling(.c, .quarterSharp),
            PitchSpelling(.d, .threeQuarterFlat)
        ],
        
        00.75: [
            PitchSpelling(.c, .sharp, .down),
            PitchSpelling(.d, .flat, .down),
            PitchSpelling(.c, .quarterSharp, .up),
            PitchSpelling(.d, .threeQuarterFlat, .up)
        ],
        
        01.00: [
            PitchSpelling(.c, .sharp),
            PitchSpelling(.d, .flat)
        ],
        
        01.25: [
            PitchSpelling(.c, .sharp, .up),
            PitchSpelling(.d, .flat, .up),
            PitchSpelling(.d, .quarterFlat, .down),
            PitchSpelling(.c, .threeQuarterSharp, .down)
        ],
        
        01.50: [
            PitchSpelling(.d, .quarterFlat),
            PitchSpelling(.c, .threeQuarterSharp)
        ],
        
        01.75: [
            PitchSpelling(.d, .natural, .down),
            PitchSpelling(.d, .quarterFlat, .up)
        ],
        
        02.00: [
            PitchSpelling(.d),
            PitchSpelling(.c, .doubleSharp),
            PitchSpelling(.e, .doubleFlat)
        ],
        
        02.25: [
            PitchSpelling(.d, .natural, .up),
            PitchSpelling(.d, .quarterSharp, .down),
            PitchSpelling(.e, .threeQuarterFlat, .down)
        ],
        
        02.50: [
            PitchSpelling(.d, .quarterSharp),
            PitchSpelling(.e, .threeQuarterFlat)
        ],
        
        02.75: [
            PitchSpelling(.e, .flat, .down),
            PitchSpelling(.d, .sharp, .down),
            PitchSpelling(.d, .quarterSharp, .up),
            PitchSpelling(.e, .threeQuarterFlat, .up)
        ],
        
        03.00: [
            PitchSpelling(.e, .flat),
            PitchSpelling(.d, .sharp),
            PitchSpelling(.f, .doubleFlat)
        ],
        
        03.25: [
            PitchSpelling(.e, .flat, .up),
            PitchSpelling(.d, .sharp, .up),
            PitchSpelling(.e, .quarterFlat, .down),
            PitchSpelling(.d, .threeQuarterSharp, .down)
        ],
        
        03.50: [
            PitchSpelling(.e, .quarterFlat),
            PitchSpelling(.d, .threeQuarterSharp)
        ],
        
        03.75: [
            PitchSpelling(.e, .natural, .down),
            PitchSpelling(.e, .quarterFlat, .up),
            PitchSpelling(.d, .threeQuarterSharp, .up)
        ],
        
        04.00: [
            PitchSpelling(.e),
            PitchSpelling(.f, .flat),
            PitchSpelling(.d, .doubleSharp)
        ],
        
        04.25: [
            PitchSpelling(.e, .natural, .up),
            PitchSpelling(.e, .quarterSharp, .down),
            PitchSpelling(.f, .quarterFlat, .down)
        ],
        
        04.50: [
            PitchSpelling(.e, .quarterSharp),
            PitchSpelling(.f, .quarterFlat)
        ],
        
        04.75: [
            PitchSpelling(.f, .natural, .down),
            PitchSpelling(.e, .quarterSharp, .up),
            PitchSpelling(.f, .quarterFlat, .up)
        ],
        
        05.00: [
            PitchSpelling(.f),
            PitchSpelling(.e, .sharp),
            PitchSpelling(.g, .doubleFlat)
        ],
        
        05.25: [
            PitchSpelling(.f, .natural, .up),
            PitchSpelling(.f, .quarterSharp, .down),
            PitchSpelling(.g, .threeQuarterFlat, .down)
        ],
        
        05.50: [
            PitchSpelling(.f, .quarterSharp),
            PitchSpelling(.g, .threeQuarterFlat)
        ],
        
        05.75: [
            PitchSpelling(.f, .sharp, .down),
            PitchSpelling(.g, .flat, .down),
            PitchSpelling(.f, .quarterSharp, .up),
            PitchSpelling(.g, .threeQuarterSharp, .up)
        ],
        
        06.00: [
            PitchSpelling(.f, .sharp),
            PitchSpelling(.g, .flat)
        ],
        
        06.25: [
            PitchSpelling(.f, .sharp, .up),
            PitchSpelling(.g, .flat, .up),
            PitchSpelling(.g, .quarterFlat, .down),
            PitchSpelling(.f, .threeQuarterSharp, .down)
        ],
        
        06.50: [
            PitchSpelling(.g, .quarterFlat),
            PitchSpelling(.f, .threeQuarterSharp)
        ],
        
        06.75: [
            PitchSpelling(.g, .natural, .down),
            PitchSpelling(.g, .quarterFlat, .up),
            PitchSpelling(.f, .threeQuarterSharp, .up)
        ],
        
        07.00: [
            PitchSpelling(.g),
            PitchSpelling(.f, .doubleSharp),
            PitchSpelling(.a, .doubleFlat)
        ],
        
        07.25: [
            PitchSpelling(.g, .natural, .up),
            PitchSpelling(.g, .quarterSharp, .down),
            PitchSpelling(.a, .threeQuarterFlat, .down)
        ],
        
        07.50: [
            PitchSpelling(.g, .quarterSharp),
            PitchSpelling(.a, .threeQuarterFlat)
        ],
        
        07.75: [
            PitchSpelling(.g, .sharp, .down),
            PitchSpelling(.a, .flat, .down),
            PitchSpelling(.g, .quarterSharp, .up),
            PitchSpelling(.a, .threeQuarterFlat, .up),
        ],
        
        08.00: [
            PitchSpelling(.a, .flat),
            PitchSpelling(.g, .sharp)
        ],
        
        08.25: [
            PitchSpelling(.g, .sharp, .up),
            PitchSpelling(.a, .flat, .up),
            PitchSpelling(.a, .quarterFlat, .down),
            PitchSpelling(.g, .threeQuarterSharp, .down)
        ],
        
        08.50: [
            PitchSpelling(.a, .quarterFlat),
            PitchSpelling(.g, .threeQuarterSharp)
        ],
        
        08.75: [
            PitchSpelling(.a, .natural, .down),
            PitchSpelling(.a, .quarterFlat, .up),
            PitchSpelling(.g, .threeQuarterSharp, .up)
        ],
        
        09.00: [
            PitchSpelling(.a),
            PitchSpelling(.g, .doubleSharp),
            PitchSpelling(.b, .doubleFlat)
        ],
        
        09.25: [
            PitchSpelling(.a, .natural, .up),
            PitchSpelling(.a, .quarterSharp, .down),
            PitchSpelling(.b, .threeQuarterFlat, .down)
        ],
        
        09.50: [
            PitchSpelling(.a, .quarterSharp)
        ],
        
        09.75: [
            PitchSpelling(.b, .flat, .down),
            PitchSpelling(.a, .sharp, .down),
            PitchSpelling(.b, .threeQuarterFlat, .up),
            PitchSpelling(.a, .quarterSharp, .up),
        ],
        
        10.00: [
            PitchSpelling(.b, .flat),
            PitchSpelling(.a, .sharp),
            PitchSpelling(.c, .doubleFlat)
        ],
        
        10.25: [
            PitchSpelling(.b, .flat, .up),
            PitchSpelling(.a, .sharp, .up),
            PitchSpelling(.b, .quarterFlat, .down),
            PitchSpelling(.a, .threeQuarterSharp, .down)
        ],
        
        10.50: [
            PitchSpelling(.b, .quarterFlat),
            PitchSpelling(.a, .threeQuarterSharp)
        ],
        
        10.75: [
            PitchSpelling(.b, .natural, .down),
            PitchSpelling(.b, .quarterFlat, .up),
            PitchSpelling(.a, .threeQuarterSharp, .up)
        ],
        
        11.00: [
            PitchSpelling(.b),
            PitchSpelling(.c, .flat),
            PitchSpelling(.a, .doubleSharp)
        ],
        
        11.25: [
            PitchSpelling(.b, .natural, .up),
            PitchSpelling(.b, .quarterSharp, .down),
            PitchSpelling(.c, .quarterFlat, .down)
        ],
        
        11.50: [
            PitchSpelling(.b, .quarterSharp),
            PitchSpelling(.c, .quarterFlat)
        ],
        
        11.75: [
            PitchSpelling(.c, .natural, .down),
            PitchSpelling(.b, .quarterSharp, .up),
            PitchSpelling(.c, .quarterFlat, .up),
        ]
    ]
    
    internal static func spellings(forPitchClass pitchClass: Pitch.Class) -> [PitchSpelling]? {
        return PitchSpellings.spellingsByPitchClass[pitchClass]
    }
    
    internal static func defaultSpelling(forPitchClass pitchClass: Pitch.Class)
        -> PitchSpelling?
    {
        return spellings(forPitchClass: pitchClass)?.first
    }
}
