//
//  NamedIntervalQuality.Category.swift
//  PitchSpeller
//
//  Created by James Bean on 5/22/18.
//

import Pitch
import SpelledPitch
import DataStructures

// Wetherfield Pitch Speller, Thesis pg. 38

extension Wetherfield {

    struct PitchSpeller {
        let unspelledPitchSequence: UnspelledPitchSequence

        // Create a `FlowNetwork`.
    }
}

extension Wetherfield.PitchSpeller {

    internal enum Category {

        internal enum Tendency: Int {
            case down = 0
            case up = 1
        }

        internal struct TendencyPair: Equatable, Hashable {

            let up: Tendency
            let down: Tendency

            init(_ up: Tendency, _ down: Tendency) {
                self.up = up
                self.down = down
            }

            init(_ tuple: (Tendency, Tendency)) {
                self.up = tuple.0
                self.down = tuple.1
            }
        }

        private typealias Map = OrderedDictionary<TendencyPair,Pitch.Spelling.QuarterStepModifier>

        private static var zero: Map = [
            .init(.down,.down): .doubleFlat,
            .init(.up,.down): .natural,
            .init(.up,.up): .sharp
        ]

        private static var one: Map = [
            .init(.down,.down): .flat,
            .init(.up,.down): .sharp,
            .init(.up,.up): .doubleSharp
        ]

        private static var two: Map = [
            .init(.down,.down): .doubleFlat,
            .init(.up,.down): .natural,
            .init(.up,.up): .doubleSharp
        ]

        private static var three: Map = [
            .init(.down,.down): .doubleFlat,
            .init(.up,.down): .flat,
            .init(.up,.up): .sharp
        ]

        private static var four: Map = [
            .init(.down,.down): .flat,
            .init(.up,.down): .natural,
            .init(.up,.up): .doubleSharp
        ]

        private static var five: Map = [
            .init(.down,.down): .flat,
            .init(.up,.down): .sharp
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

        /// - Returns: `Pitch.Spelling.QuarterStepModifier` for the given `pitchClass` and
        /// `tendency`. This mapping is defined by Wetherfield on pg. 38 of the thesis _A Graphical
        /// Theory of Musical Pitch Spelling_.
        ///
        internal static func modifier(
            pitchClass: Pitch.Class,
            tendency: (Tendency,Tendency)
        ) -> Pitch.Spelling.QuarterStepModifier?
        {
            return category(for: pitchClass)?[.init(tendency)]
        }
    }
}

extension Pitch.Spelling {
    init?(pitchClass: Pitch.Class, quarterStepModifier: Pitch.Spelling.QuarterStepModifier) {
        guard
            let letter = LetterName(pitchClass: pitchClass, quarterStepModifier: quarterStepModifier)
        else {
            return nil
        }
        self.init(letter, quarterStepModifier)
    }
}
