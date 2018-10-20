//
//  EDO48PitchSpellings.swift
//  SpelledPitch
//
//  Created by James Bean on 5/1/16.
//
//

import Pitch

extension Pitch {

    /// Collection of `Pitch.Spelling` values stored by `Pitch.Class`.
    // FIXME: Reintroduce eighth-tone spelling conversion when a more refine conversion to/from
    // Helmhotz-Ellis can be made.
    private static let spellingsByPitchClass: [Pitch.Class: [Pitch.Spelling]] = [

        00.00: [
            Pitch.Spelling(.c),
            Pitch.Spelling(.b, .sharp),
            Pitch.Spelling(.d, .flat)
        ],

//        00.25: [
//            Pitch.Spelling(.c, .natural, .up),
//            Pitch.Spelling(.c, .quarter, .sharp, .down),
//            Pitch.Spelling(.d, .threeQuarter, .flat, .down)
//        ],

        00.50: [
            Pitch.Spelling(.c, .quarterSharp),
            Pitch.Spelling(.d, .threeQuarterFlat)
        ],
//
//        00.75: [
//            Pitch.Spelling(.c, .sharp, .down),
//            Pitch.Spelling(.d, .flat, .down),
//            Pitch.Spelling(.c, .quarter, .sharp, .up),
//            Pitch.Spelling(.d, .threeQuarter, .flat, .up)
//        ],
//
        01.00: [
            Pitch.Spelling(.c, .sharp),
            Pitch.Spelling(.d, .flat)
        ],
//
//        01.25: [
//            Pitch.Spelling(.c, .sharp, .up),
//            Pitch.Spelling(.d, .flat, .up),
//            Pitch.Spelling(.d, .quarter, .flat, .down),
//            Pitch.Spelling(.c, .threeQuarter, .sharp, .down)
//        ],
//
        01.50: [
            Pitch.Spelling(.d, .quarterFlat),
            Pitch.Spelling(.c, .threeQuarterSharp)
        ],
//
//        01.75: [
//            Pitch.Spelling(.d, .natural, .down),
//            Pitch.Spelling(.d, .quarter, .flat, .up)
//        ],
//
        02.00: [
            Pitch.Spelling(.d),
            Pitch.Spelling(.c, .doubleSharp),
            Pitch.Spelling(.e, .doubleFlat)
        ],
//
//        02.25: [
//            Pitch.Spelling(.d, .natural, .up),
//            Pitch.Spelling(.d, .quarter, .sharp, .down),
//            Pitch.Spelling(.e, .threeQuarter, .flat, .down)
//        ],
//
        02.50: [
            Pitch.Spelling(.d, .quarterSharp),
            Pitch.Spelling(.e, .threeQuarterFlat)
        ],
//
//        02.75: [
//            Pitch.Spelling(.e, .flat, .down),
//            Pitch.Spelling(.d, .sharp, .down),
//            Pitch.Spelling(.d, .quarter, .sharp, .up),
//            Pitch.Spelling(.e, .threeQuarter, .flat, .up)
//        ],
//
        03.00: [
            Pitch.Spelling(.e, .flat),
            Pitch.Spelling(.d, .sharp),
            Pitch.Spelling(.f, .flat)
        ],
//
//        03.25: [
//            Pitch.Spelling(.e, .flat, .up),
//            Pitch.Spelling(.d, .sharp, .up),
//            Pitch.Spelling(.e, .quarter, .flat, .down),
//            Pitch.Spelling(.d, .threeQuarter, .sharp, .down)
//        ],
//
        03.50: [
            Pitch.Spelling(.e, .quarterFlat),
            Pitch.Spelling(.d, .threeQuarterSharp)
        ],
//
//        03.75: [
//            Pitch.Spelling(.e, .natural, .down),
//            Pitch.Spelling(.e, .quarter, .flat, .up),
//            Pitch.Spelling(.d, .threeQuarter, .sharp, .up)
//        ],
//
        04.00: [
            Pitch.Spelling(.e),
            Pitch.Spelling(.f, .flat),
            Pitch.Spelling(.d, .doubleSharp)
        ],
//
//        04.25: [
//            Pitch.Spelling(.e, .natural, .up),
//            Pitch.Spelling(.e, .quarter, .sharp, .down),
//            Pitch.Spelling(.f, .quarter, .flat, .down)
//        ],
//
        04.50: [
            Pitch.Spelling(.e, .quarterSharp),
            Pitch.Spelling(.f, .quarterFlat)
        ],
//
//        04.75: [
//            Pitch.Spelling(.f, .natural, .down),
//            Pitch.Spelling(.e, .quarter, .sharp, .up),
//            Pitch.Spelling(.f, .quarter, .flat, .up)
//        ],
//
        05.00: [
            Pitch.Spelling(.f),
            Pitch.Spelling(.e, .sharp),
            Pitch.Spelling(.g, .doubleFlat)
        ],
//
//        05.25: [
//            Pitch.Spelling(.f, .natural, .up),
//            Pitch.Spelling(.f, .quarter, .sharp, .down),
//            Pitch.Spelling(.g, .threeQuarter, .flat, .down)
//        ],
//
        05.50: [
            Pitch.Spelling(.f, .quarterSharp),
            Pitch.Spelling(.g, .threeQuarterFlat)
        ],
//
//        05.75: [
//            Pitch.Spelling(.f, .sharp, .down),
//            Pitch.Spelling(.g, .flat, .down),
//            Pitch.Spelling(.f, .quarter, .sharp, .up),
//            Pitch.Spelling(.g, .threeQuarter, .sharp, .up)
//        ],
//
        06.00: [
            Pitch.Spelling(.f, .sharp),
            Pitch.Spelling(.g, .flat)
        ],
//
//        06.25: [
//            Pitch.Spelling(.f, .sharp, .up),
//            Pitch.Spelling(.g, .flat, .up),
//            Pitch.Spelling(.g, .quarter, .flat, .down),
//            Pitch.Spelling(.f, .threeQuarter, .sharp, .down)
//        ],
//
        06.50: [
            Pitch.Spelling(.g, .quarterFlat),
            Pitch.Spelling(.f, .threeQuarterSharp)
        ],
//
//        06.75: [
//            Pitch.Spelling(.g, .natural, .down),
//            Pitch.Spelling(.g, .quarter, .flat, .up),
//            Pitch.Spelling(.f, .threeQuarter, .sharp, .up)
//        ],
//
        07.00: [
            Pitch.Spelling(.g),
            Pitch.Spelling(.f, .doubleSharp),
            Pitch.Spelling(.a, .doubleFlat)
        ],
//
//        07.25: [
//            Pitch.Spelling(.g, .natural, .up),
//            Pitch.Spelling(.g, .quarter, .sharp, .down),
//            Pitch.Spelling(.a, .threeQuarter, .flat, .down)
//        ],
//
        07.50: [
            Pitch.Spelling(.g, .quarterSharp),
            Pitch.Spelling(.a, .threeQuarterFlat)
        ],
//
//        07.75: [
//            Pitch.Spelling(.g, .sharp, .down),
//            Pitch.Spelling(.a, .flat, .down),
//            Pitch.Spelling(.g, .quarter, .sharp, .up),
//            Pitch.Spelling(.a, .threeQuarter, .flat, .up),
//        ],
//
        08.00: [
            Pitch.Spelling(.a, .flat),
            Pitch.Spelling(.g, .sharp)
        ],
//
//        08.25: [
//            Pitch.Spelling(.g, .sharp, .up),
//            Pitch.Spelling(.a, .flat, .up),
//            Pitch.Spelling(.a, .quarter, .flat, .down),
//            Pitch.Spelling(.g, .threeQuarter, .sharp, .down)
//        ],
//
        08.50: [
            Pitch.Spelling(.a, .quarterFlat),
            Pitch.Spelling(.g, .threeQuarterSharp)
        ],
//
//        08.75: [
//            Pitch.Spelling(.a, .natural, .down),
//            Pitch.Spelling(.a, .quarter, .flat, .up),
//            Pitch.Spelling(.g, .threeQuarter, .sharp, .up)
//        ],
//
        09.00: [
            Pitch.Spelling(.a),
            Pitch.Spelling(.g, .doubleSharp),
            Pitch.Spelling(.b, .doubleFlat)
        ],
//
//        09.25: [
//            Pitch.Spelling(.a, .natural, .up),
//            Pitch.Spelling(.a, .quarter, .sharp, .down),
//            Pitch.Spelling(.b, .threeQuarter, .flat, .down)
//        ],
//
        09.50: [
            Pitch.Spelling(.b, .threeQuarterFlat),
            Pitch.Spelling(.a, .quarterSharp)
        ],
//
//        09.75: [
//            Pitch.Spelling(.b, .flat, .down),
//            Pitch.Spelling(.a, .sharp, .down),
//            Pitch.Spelling(.b, .threeQuarter, .flat, .up),
//            Pitch.Spelling(.a, .quarter, .sharp, .up),
//        ],
//
        10.00: [
            Pitch.Spelling(.b, .flat),
            Pitch.Spelling(.a, .sharp),
            Pitch.Spelling(.c, .flat)
        ],
//
//        10.25: [
//            Pitch.Spelling(.b, .flat, .up),
//            Pitch.Spelling(.a, .sharp, .up),
//            Pitch.Spelling(.b, .quarter, .flat, .down),
//            Pitch.Spelling(.a, .threeQuarter, .sharp, .down)
//        ],
//
        10.50: [
            Pitch.Spelling(.b, .quarterFlat),
            Pitch.Spelling(.a, .threeQuarterSharp)
        ],
//
//        10.75: [
//            Pitch.Spelling(.b, .natural, .down),
//            Pitch.Spelling(.b, .quarter, .flat, .up),
//            Pitch.Spelling(.a, .threeQuarter, .sharp, .up)
//        ],
//
        11.00: [
            Pitch.Spelling(.b),
            Pitch.Spelling(.c, .flat),
            Pitch.Spelling(.a, .doubleSharp)
        ],
//
//        11.25: [
//            Pitch.Spelling(.b, .natural, .up),
//            Pitch.Spelling(.b, .quarter, .sharp, .down),
//            Pitch.Spelling(.c, .quarter, .flat, .down)
//        ],
//
        11.50: [
            Pitch.Spelling(.b, .quarterSharp),
            Pitch.Spelling(.c, .quarterFlat)
        ],
//
//        11.75: [
//            Pitch.Spelling(.c, .natural, .down),
//            Pitch.Spelling(.b, .quarter, .sharp, .up),
//            Pitch.Spelling(.c, .quarter, .flat, .up),
//        ]
    ]

    public static func spellings(forPitchClass pitchClass: Pitch.Class) -> [Pitch.Spelling]? {
        return Pitch.spellingsByPitchClass[pitchClass]
    }

    public static func defaultSpelling(forPitchClass pitchClass: Pitch.Class) -> Pitch.Spelling? {
        return spellings(forPitchClass: pitchClass)?.first
    }
}

extension Pitch.Class {

    /// All `Pitch.Spelling` structures available for this `PitchClass`.
    public var spellings: [Pitch.Spelling] {
        return Pitch.spellings(forPitchClass: self) ?? []
    }
}
