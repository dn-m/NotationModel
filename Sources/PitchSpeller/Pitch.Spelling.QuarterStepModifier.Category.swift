//
//  NamedIntervalQuality.Category.swift
//  PitchSpeller
//
//  Created by James Bean on 5/22/18.
//

import Pitch
import SpelledPitch

// Wetherfield Pitch Speller, Thesis pg. 38

internal enum Category {

    private struct PredicatePair: Equatable, Hashable {

        let a: Int
        let b: Int

        init(_ a: Int, _ b: Int) {
            self.a = a
            self.b = b
        }

        init(_ tuple: (Int, Int)) {
            self.a = tuple.0
            self.b = tuple.1
        }
    }

    private typealias Map = [PredicatePair: Pitch.Spelling.QuarterStepModifier]

    private static var zero: Map = [
        .init(0,1): .natural,
        .init(1,1): .sharp,
        .init(0,0): .doubleFlat
    ]

    private static var one: Map = [
        .init(1,0): .sharp,
        .init(0,0): .flat,
        .init(1,1): .doubleSharp
    ]

    private static var two: Map = [
        .init(1,1): .doubleSharp,
        .init(0,0): .doubleFlat,
        .init(1,0): .natural
    ]

    private static var three: Map = [
        .init(0,0): .doubleFlat,
        .init(1,1): .sharp,
        .init(0,1): .flat
    ]

    private static var four: Map = [
        .init(0,0): .flat,
        .init(1,0): .natural,
        .init(1,1): .doubleSharp
    ]

    private static var five: Map = [
        .init(1,0): .sharp,
        .init(0,0): .flat
    ]

    private static func category(for pitchClass: Pitch.Class) -> Map? {
        switch pitchClass {
        case 0,5:
            return zero
        case 1,6:
            return one
        case 2,7,9:
            return two
        case 3,10:
            return three
        case 4,11:
            return four
        case 8:
            return five
        default:
            return nil
        }
    }

    /// - Returns: `Pitch.Spelling.QuarterStepModifier` for the given `pitchClass` and `tendency`.
    /// This mapping is defined by Wetherfield on pg. 38 of the thesis _A Graphical Theory of
    /// Musical Pitch Spelling.
    ///
    internal static func modifier(pitchClass: Pitch.Class, tendency: (Int,Int))
        -> Pitch.Spelling.QuarterStepModifier?
    {
        return category(for: pitchClass)?[.init(tendency)]
    }
}
