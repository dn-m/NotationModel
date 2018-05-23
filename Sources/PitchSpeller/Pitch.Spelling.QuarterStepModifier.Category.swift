//
//  NamedIntervalQuality.Category.swift
//  PitchSpeller
//
//  Created by James Bean on 5/22/18.
//

import Pitch
import SpelledPitch

// Wetherfield Pitch Speller, Thesis pg. 38

extension Wetherfield {

    internal enum Category {

        internal struct TendencyPair: Equatable, Hashable {

            internal enum Tendency: Int {
                case down = 0
                case up = 1
            }

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

        private typealias Map = [TendencyPair: Pitch.Spelling.QuarterStepModifier]

        private static var zero: Map = [
            .init(.up,.down): .natural,
            .init(.up,.up): .sharp,
            .init(.down,.down): .doubleFlat
        ]

        private static var one: Map = [
            .init(.up,.down): .sharp,
            .init(.down,.down): .flat,
            .init(.up,.up): .doubleSharp
        ]

        private static var two: Map = [
            .init(.up,.up): .doubleSharp,
            .init(.down,.down): .doubleFlat,
            .init(.up,.down): .natural
        ]

        private static var three: Map = [
            .init(.down,.down): .doubleFlat,
            .init(.up,.up): .sharp,
            .init(.up,.down): .flat
        ]

        private static var four: Map = [
            .init(.down,.down): .flat,
            .init(.up,.down): .natural,
            .init(.up,.up): .doubleSharp
        ]

        private static var five: Map = [
            .init(.up,.down): .sharp,
            .init(.down,.down): .flat
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
        /// Musical Pitch Spelling_.
        ///
        internal static func modifier(
            pitchClass: Pitch.Class,
            tendency: (TendencyPair.Tendency,TendencyPair.Tendency)
        ) -> Pitch.Spelling.QuarterStepModifier?
        {
            return category(for: pitchClass)?[.init(tendency)]
        }
    }

}
