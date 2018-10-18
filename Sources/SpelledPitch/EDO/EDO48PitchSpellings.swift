//
//  EDO48PitchSpellings.swift
//  SpelledPitch
//
//  Created by James Bean on 5/1/16.
//
//

import Pitch

extension EDO48 {

    /// Collection of `Pitch.Spelling` values stored by `Pitch.Class`.
    private static let spellingsByPitchClass: [Pitch.Class: [Pitch.Spelling<EDO48>]] = [

        00.00: [
            Pitch.Spelling(.c),
            Pitch.Spelling(.b, .sharp(count: 1)),
            Pitch.Spelling(.d, .flat)
        ],

        00.25: [
            Pitch.Spelling(.c, .natural, .up),
            Pitch.Spelling(.c, .quarter, .sharp(count: 1), .down),
            Pitch.Spelling(.d, .threeQuarter, .flat, .down)
        ],

        00.50: [
            Pitch.Spelling(.c, .quarter, .sharp(count: 1)),
            Pitch.Spelling(.d, .threeQuarter, .flat)
        ],

        00.75: [
            Pitch.Spelling(.c, .sharp(count: 1), .down),
            Pitch.Spelling(.d, .flat, .down),
            Pitch.Spelling(.c, .quarter, .sharp(count: 1), .up),
            Pitch.Spelling(.d, .threeQuarter, .flat, .up)
        ],

        01.00: [
            Pitch.Spelling(.c, .sharp(count: 1)),
            Pitch.Spelling(.d, .flat)
        ],

        01.25: [
            Pitch.Spelling(.c, .sharp(count: 1), .up),
            Pitch.Spelling(.d, .flat, .up),
            Pitch.Spelling(.d, .quarter, .flat, .down),
            Pitch.Spelling(.c, .threeQuarter, .sharp(count: 1), .down)
        ],

        01.50: [
            Pitch.Spelling(.d, .quarter, .flat),
            Pitch.Spelling(.c, .threeQuarter, .sharp(count: 1))
        ],

        01.75: [
            Pitch.Spelling(.d, .natural, .down),
            Pitch.Spelling(.d, .quarter, .flat, .up)
        ],

        02.00: [
            Pitch.Spelling(.d),
            Pitch.Spelling(.c, .sharp(count: 2)),
            Pitch.Spelling(.e, .flat)
        ],

        02.25: [
            Pitch.Spelling(.d, .natural, .up),
            Pitch.Spelling(.d, .quarter, .sharp(count: 1), .down),
            Pitch.Spelling(.e, .threeQuarter, .flat, .down)
        ],

        02.50: [
            Pitch.Spelling(.d, .quarter, .sharp(count: 1)),
            Pitch.Spelling(.e, .threeQuarter, .flat)
        ],

        02.75: [
            Pitch.Spelling(.e, .flat, .down),
            Pitch.Spelling(.d, .sharp(count: 1), .down),
            Pitch.Spelling(.d, .quarter, .sharp(count: 1), .up),
            Pitch.Spelling(.e, .threeQuarter, .flat, .up)
        ],

        03.00: [
            Pitch.Spelling(.e, .flat),
            Pitch.Spelling(.d, .sharp(count: 1)),
            Pitch.Spelling(.f, .flat)
        ],

        03.25: [
            Pitch.Spelling(.e, .flat, .up),
            Pitch.Spelling(.d, .sharp(count: 1), .up),
            Pitch.Spelling(.e, .quarter, .flat, .down),
            Pitch.Spelling(.d, .threeQuarter, .sharp(count: 1), .down)
        ],

        03.50: [
            Pitch.Spelling(.e, .quarter, .flat),
            Pitch.Spelling(.d, .threeQuarter, .sharp(count: 1))
        ],

        03.75: [
            Pitch.Spelling(.e, .natural, .down),
            Pitch.Spelling(.e, .quarter, .flat, .up),
            Pitch.Spelling(.d, .threeQuarter, .sharp(count: 1), .up)
        ],

        04.00: [
            Pitch.Spelling(.e),
            Pitch.Spelling(.f, .flat),
            Pitch.Spelling(.d, .sharp(count: 2))
        ],

        04.25: [
            Pitch.Spelling(.e, .natural, .up),
            Pitch.Spelling(.e, .quarter, .sharp(count: 1), .down),
            Pitch.Spelling(.f, .quarter, .flat, .down)
        ],

        04.50: [
            Pitch.Spelling(.e, .quarter, .sharp(count: 1)),
            Pitch.Spelling(.f, .quarter, .flat)
        ],

        04.75: [
            Pitch.Spelling(.f, .natural, .down),
            Pitch.Spelling(.e, .quarter, .sharp(count: 1), .up),
            Pitch.Spelling(.f, .quarter, .flat, .up)
        ],

        05.00: [
            Pitch.Spelling(.f),
            Pitch.Spelling(.e, .sharp(count: 1)),
            Pitch.Spelling(.g, .flat)
        ],

        05.25: [
            Pitch.Spelling(.f, .natural, .up),
            Pitch.Spelling(.f, .quarter, .sharp(count: 1), .down),
            Pitch.Spelling(.g, .threeQuarter, .flat, .down)
        ],

        05.50: [
            Pitch.Spelling(.f, .quarter, .sharp(count: 1)),
            Pitch.Spelling(.g, .threeQuarter, .flat)
        ],

        05.75: [
            Pitch.Spelling(.f, .sharp(count: 1), .down),
            Pitch.Spelling(.g, .flat, .down),
            Pitch.Spelling(.f, .quarter, .sharp(count: 1), .up),
            Pitch.Spelling(.g, .threeQuarter, .sharp(count: 1), .up)
        ],

        06.00: [
            Pitch.Spelling(.f, .sharp(count: 1)),
            Pitch.Spelling(.g, .flat)
        ],

        06.25: [
            Pitch.Spelling(.f, .sharp(count: 1), .up),
            Pitch.Spelling(.g, .flat, .up),
            Pitch.Spelling(.g, .quarter, .flat, .down),
            Pitch.Spelling(.f, .threeQuarter, .sharp(count: 1), .down)
        ],

        06.50: [
            Pitch.Spelling(.g, .quarter, .flat),
            Pitch.Spelling(.f, .threeQuarter, .sharp(count: 1))
        ],

        06.75: [
            Pitch.Spelling(.g, .natural, .down),
            Pitch.Spelling(.g, .quarter, .flat, .up),
            Pitch.Spelling(.f, .threeQuarter, .sharp(count: 1), .up)
        ],

        07.00: [
            Pitch.Spelling(.g),
            Pitch.Spelling(.f, .sharp(count: 2)),
            Pitch.Spelling(.a, .flat)
        ],

        07.25: [
            Pitch.Spelling(.g, .natural, .up),
            Pitch.Spelling(.g, .quarter, .sharp(count: 1), .down),
            Pitch.Spelling(.a, .threeQuarter, .flat, .down)
        ],

        07.50: [
            Pitch.Spelling(.g, .quarter, .sharp(count: 1)),
            Pitch.Spelling(.a, .threeQuarter, .flat)
        ],

        07.75: [
            Pitch.Spelling(.g, .sharp(count: 1), .down),
            Pitch.Spelling(.a, .flat, .down),
            Pitch.Spelling(.g, .quarter, .sharp(count: 1), .up),
            Pitch.Spelling(.a, .threeQuarter, .flat, .up),
        ],

        08.00: [
            Pitch.Spelling(.a, .flat),
            Pitch.Spelling(.g, .sharp(count: 1))
        ],

        08.25: [
            Pitch.Spelling(.g, .sharp(count: 1), .up),
            Pitch.Spelling(.a, .flat, .up),
            Pitch.Spelling(.a, .quarter, .flat, .down),
            Pitch.Spelling(.g, .threeQuarter, .sharp(count: 1), .down)
        ],

        08.50: [
            Pitch.Spelling(.a, .quarter, .flat),
            Pitch.Spelling(.g, .threeQuarter, .sharp(count: 1))
        ],

        08.75: [
            Pitch.Spelling(.a, .natural, .down),
            Pitch.Spelling(.a, .quarter, .flat, .up),
            Pitch.Spelling(.g, .threeQuarter, .sharp(count: 1), .up)
        ],

        09.00: [
            Pitch.Spelling(.a),
            Pitch.Spelling(.g, .sharp(count: 2)),
            Pitch.Spelling(.b, .flat)
        ],

        09.25: [
            Pitch.Spelling(.a, .natural, .up),
            Pitch.Spelling(.a, .quarter, .sharp(count: 1), .down),
            Pitch.Spelling(.b, .threeQuarter, .flat, .down)
        ],

        09.50: [
            Pitch.Spelling(.a, .quarter, .sharp(count: 1))
        ],

        09.75: [
            Pitch.Spelling(.b, .flat, .down),
            Pitch.Spelling(.a, .sharp(count: 1), .down),
            Pitch.Spelling(.b, .threeQuarter, .flat, .up),
            Pitch.Spelling(.a, .quarter, .sharp(count: 1), .up),
        ],

        10.00: [
            Pitch.Spelling(.b, .flat),
            Pitch.Spelling(.a, .sharp(count: 1)),
            Pitch.Spelling(.c, .flat)
        ],

        10.25: [
            Pitch.Spelling(.b, .flat, .up),
            Pitch.Spelling(.a, .sharp(count: 1), .up),
            Pitch.Spelling(.b, .quarter, .flat, .down),
            Pitch.Spelling(.a, .threeQuarter, .sharp(count: 1), .down)
        ],

        10.50: [
            Pitch.Spelling(.b, .quarter, .flat),
            Pitch.Spelling(.a, .threeQuarter, .sharp(count: 1))
        ],

        10.75: [
            Pitch.Spelling(.b, .natural, .down),
            Pitch.Spelling(.b, .quarter, .flat, .up),
            Pitch.Spelling(.a, .threeQuarter, .sharp(count: 1), .up)
        ],

        11.00: [
            Pitch.Spelling(.b),
            Pitch.Spelling(.c, .flat),
            Pitch.Spelling(.a, .sharp(count: 2))
        ],

        11.25: [
            Pitch.Spelling(.b, .natural, .up),
            Pitch.Spelling(.b, .quarter, .sharp(count: 1), .down),
            Pitch.Spelling(.c, .quarter, .flat, .down)
        ],

        11.50: [
            Pitch.Spelling(.b, .quarter, .sharp(count: 1)),
            Pitch.Spelling(.c, .quarter, .flat)
        ],

        11.75: [
            Pitch.Spelling(.c, .natural, .down),
            Pitch.Spelling(.b, .quarter, .sharp(count: 1), .up),
            Pitch.Spelling(.c, .quarter, .flat, .up),
        ]
    ]

    public static func spellings(forPitchClass pitchClass: Pitch.Class) -> [Pitch.Spelling<EDO48>]? {
        return EDO48.spellingsByPitchClass[pitchClass]
    }

    public static func defaultSpelling(forPitchClass pitchClass: Pitch.Class) -> Pitch.Spelling<EDO48>? {
        return spellings(forPitchClass: pitchClass)?.first
    }
}


extension Pitch.Class {

    /// All `Pitch.Spelling` structures available for this `PitchClass`.
    public var spellings: [Pitch.Spelling<EDO48>] {
        return EDO48.spellings(forPitchClass: self) ?? []
    }
}
