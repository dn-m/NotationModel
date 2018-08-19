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
            Pitch.Spelling(.b, .sharp(1)),
            Pitch.Spelling(.d, .flat(2))
        ],

        00.25: [
            Pitch.Spelling(.c, .natural, .up),
            Pitch.Spelling(.c, .quarter, .sharp(1), .down),
            Pitch.Spelling(.d, .threeQuarter, .flat(1), .down)
        ],

        00.50: [
            Pitch.Spelling(.c, .quarter, .sharp(1)),
            Pitch.Spelling(.d, .threeQuarter, .flat(1))
        ],

        00.75: [
            Pitch.Spelling(.c, .sharp(1), .down),
            Pitch.Spelling(.d, .flat(1), .down),
            Pitch.Spelling(.c, .quarter, .sharp(1), .up),
            Pitch.Spelling(.d, .threeQuarter, .flat(1), .up)
        ],

        01.00: [
            Pitch.Spelling(.c, .sharp(1)),
            Pitch.Spelling(.d, .flat(1))
        ],

        01.25: [
            Pitch.Spelling(.c, .sharp(1), .up),
            Pitch.Spelling(.d, .flat(1), .up),
            Pitch.Spelling(.d, .quarter, .flat(1), .down),
            Pitch.Spelling(.c, .threeQuarter, .sharp(1), .down)
        ],

        01.50: [
            Pitch.Spelling(.d, .quarter, .flat(1)),
            Pitch.Spelling(.c, .threeQuarter, .sharp(1))
        ],

        01.75: [
            Pitch.Spelling(.d, .natural, .down),
            Pitch.Spelling(.d, .quarter, .flat(1), .up)
        ],

        02.00: [
            Pitch.Spelling(.d),
            Pitch.Spelling(.c, .sharp(2)),
            Pitch.Spelling(.e, .flat(2))
        ],

        02.25: [
            Pitch.Spelling(.d, .natural, .up),
            Pitch.Spelling(.d, .quarter, .sharp(1), .down),
            Pitch.Spelling(.e, .threeQuarter, .flat(1), .down)
        ],

        02.50: [
            Pitch.Spelling(.d, .quarter, .sharp(1)),
            Pitch.Spelling(.e, .threeQuarter, .flat(1))
        ],

        02.75: [
            Pitch.Spelling(.e, .flat(1), .down),
            Pitch.Spelling(.d, .sharp(1), .down),
            Pitch.Spelling(.d, .quarter, .sharp(1), .up),
            Pitch.Spelling(.e, .threeQuarter, .flat(1), .up)
        ],

        03.00: [
            Pitch.Spelling(.e, .flat(1)),
            Pitch.Spelling(.d, .sharp(1)),
            Pitch.Spelling(.f, .flat(2))
        ],

        03.25: [
            Pitch.Spelling(.e, .flat(1), .up),
            Pitch.Spelling(.d, .sharp(1), .up),
            Pitch.Spelling(.e, .quarter, .flat(1), .down),
            Pitch.Spelling(.d, .threeQuarter, .sharp(1), .down)
        ],

        03.50: [
            Pitch.Spelling(.e, .quarter, .flat(1)),
            Pitch.Spelling(.d, .threeQuarter, .sharp(1))
        ],

        03.75: [
            Pitch.Spelling(.e, .natural, .down),
            Pitch.Spelling(.e, .quarter, .flat(1), .up),
            Pitch.Spelling(.d, .threeQuarter, .sharp(1), .up)
        ],

        04.00: [
            Pitch.Spelling(.e),
            Pitch.Spelling(.f, .flat(1)),
            Pitch.Spelling(.d, .sharp(2))
        ],

        04.25: [
            Pitch.Spelling(.e, .natural, .up),
            Pitch.Spelling(.e, .quarter, .sharp(1), .down),
            Pitch.Spelling(.f, .quarter, .flat(1), .down)
        ],

        04.50: [
            Pitch.Spelling(.e, .quarter, .sharp(1)),
            Pitch.Spelling(.f, .quarter, .flat(1))
        ],

        04.75: [
            Pitch.Spelling(.f, .natural, .down),
            Pitch.Spelling(.e, .quarter, .sharp(1), .up),
            Pitch.Spelling(.f, .quarter, .flat(1), .up)
        ],

        05.00: [
            Pitch.Spelling(.f),
            Pitch.Spelling(.e, .sharp(1)),
            Pitch.Spelling(.g, .flat(2))
        ],

        05.25: [
            Pitch.Spelling(.f, .natural, .up),
            Pitch.Spelling(.f, .quarter, .sharp(1), .down),
            Pitch.Spelling(.g, .threeQuarter, .flat(1), .down)
        ],

        05.50: [
            Pitch.Spelling(.f, .quarter, .sharp(1)),
            Pitch.Spelling(.g, .threeQuarter, .flat(1))
        ],

        05.75: [
            Pitch.Spelling(.f, .sharp(1), .down),
            Pitch.Spelling(.g, .flat(1), .down),
            Pitch.Spelling(.f, .quarter, .sharp(1), .up),
            Pitch.Spelling(.g, .threeQuarter, .sharp(1), .up)
        ],

        06.00: [
            Pitch.Spelling(.f, .sharp(1)),
            Pitch.Spelling(.g, .flat(1))
        ],

        06.25: [
            Pitch.Spelling(.f, .sharp(1), .up),
            Pitch.Spelling(.g, .flat(1), .up),
            Pitch.Spelling(.g, .quarter, .flat(1), .down),
            Pitch.Spelling(.f, .threeQuarter, .sharp(1), .down)
        ],

        06.50: [
            Pitch.Spelling(.g, .quarter, .flat(1)),
            Pitch.Spelling(.f, .threeQuarter, .sharp(1))
        ],

        06.75: [
            Pitch.Spelling(.g, .natural, .down),
            Pitch.Spelling(.g, .quarter, .flat(1), .up),
            Pitch.Spelling(.f, .threeQuarter, .sharp(1), .up)
        ],

        07.00: [
            Pitch.Spelling(.g),
            Pitch.Spelling(.f, .sharp(2)),
            Pitch.Spelling(.a, .flat(2))
        ],

        07.25: [
            Pitch.Spelling(.g, .natural, .up),
            Pitch.Spelling(.g, .quarter, .sharp(1), .down),
            Pitch.Spelling(.a, .threeQuarter, .flat(1), .down)
        ],

        07.50: [
            Pitch.Spelling(.g, .quarter, .sharp(1)),
            Pitch.Spelling(.a, .threeQuarter, .flat(1))
        ],

        07.75: [
            Pitch.Spelling(.g, .sharp(1), .down),
            Pitch.Spelling(.a, .flat(1), .down),
            Pitch.Spelling(.g, .quarter, .sharp(1), .up),
            Pitch.Spelling(.a, .threeQuarter, .flat(1), .up),
        ],

        08.00: [
            Pitch.Spelling(.a, .flat(1)),
            Pitch.Spelling(.g, .sharp(1))
        ],

        08.25: [
            Pitch.Spelling(.g, .sharp(1), .up),
            Pitch.Spelling(.a, .flat(1), .up),
            Pitch.Spelling(.a, .quarter, .flat(1), .down),
            Pitch.Spelling(.g, .threeQuarter, .sharp(1), .down)
        ],

        08.50: [
            Pitch.Spelling(.a, .quarter, .flat(1)),
            Pitch.Spelling(.g, .threeQuarter, .sharp(1))
        ],

        08.75: [
            Pitch.Spelling(.a, .natural, .down),
            Pitch.Spelling(.a, .quarter, .flat(1), .up),
            Pitch.Spelling(.g, .threeQuarter, .sharp(1), .up)
        ],

        09.00: [
            Pitch.Spelling(.a),
            Pitch.Spelling(.g, .sharp(2)),
            Pitch.Spelling(.b, .flat(2))
        ],

        09.25: [
            Pitch.Spelling(.a, .natural, .up),
            Pitch.Spelling(.a, .quarter, .sharp(1), .down),
            Pitch.Spelling(.b, .threeQuarter, .flat(1), .down)
        ],

        09.50: [
            Pitch.Spelling(.a, .quarter, .sharp(1))
        ],

        09.75: [
            Pitch.Spelling(.b, .flat(1), .down),
            Pitch.Spelling(.a, .sharp(1), .down),
            Pitch.Spelling(.b, .threeQuarter, .flat(1), .up),
            Pitch.Spelling(.a, .quarter, .sharp(1), .up),
        ],

        10.00: [
            Pitch.Spelling(.b, .flat(1)),
            Pitch.Spelling(.a, .sharp(1)),
            Pitch.Spelling(.c, .flat(2))
        ],

        10.25: [
            Pitch.Spelling(.b, .flat(1), .up),
            Pitch.Spelling(.a, .sharp(1), .up),
            Pitch.Spelling(.b, .quarter, .flat(1), .down),
            Pitch.Spelling(.a, .threeQuarter, .sharp(1), .down)
        ],

        10.50: [
            Pitch.Spelling(.b, .quarter, .flat(1)),
            Pitch.Spelling(.a, .threeQuarter, .sharp(1))
        ],

        10.75: [
            Pitch.Spelling(.b, .natural, .down),
            Pitch.Spelling(.b, .quarter, .flat(1), .up),
            Pitch.Spelling(.a, .threeQuarter, .sharp(1), .up)
        ],

        11.00: [
            Pitch.Spelling(.b),
            Pitch.Spelling(.c, .flat(1)),
            Pitch.Spelling(.a, .sharp(2))
        ],

        11.25: [
            Pitch.Spelling(.b, .natural, .up),
            Pitch.Spelling(.b, .quarter, .sharp(1), .down),
            Pitch.Spelling(.c, .quarter, .flat(1), .down)
        ],

        11.50: [
            Pitch.Spelling(.b, .quarter, .sharp(1)),
            Pitch.Spelling(.c, .quarter, .flat(1))
        ],

        11.75: [
            Pitch.Spelling(.c, .natural, .down),
            Pitch.Spelling(.b, .quarter, .sharp(1), .up),
            Pitch.Spelling(.c, .quarter, .flat(1), .up),
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
