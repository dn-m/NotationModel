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
    }
}

extension Wetherfield.PitchSpeller {

    /// - Returns: A `SpelledPitch` value applied to the given `pitch` with the given `tendencies`
    /// which are resultant from the `FlowNetwork` decoding.
    func spelledPitch(pitch: Pitch, tendencies: TendencyPair) -> SpelledPitch {
        let modifier = Category.modifier(pitchClass: pitch.class, tendencies: tendencies)!
        let pitchSpelling = Pitch.Spelling(pitchClass: pitch.class, quarterStepModifier: modifier)!
        return try! pitch.spelled(with: pitchSpelling)
    }

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

    internal enum Category {

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
        internal static func modifier(pitchClass: Pitch.Class, tendencies: TendencyPair)
            -> Pitch.Spelling.QuarterStepModifier?
        {
            return category(for: pitchClass)?[tendencies]
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

extension Pitch.Spelling.LetterName {

    internal static func `default`(for unmodifiedPitchClass: Pitch.Class)
        -> Pitch.Spelling.LetterName
    {
        switch unmodifiedPitchClass {
        case 0: return .c
        case 2: return .d
        case 4: return .e
        case 5: return .f
        case 7: return .g
        case 9: return .a
        case 11: return .b
        default:
            fatalError("Impossible")
        }
    }

    // FIXME: Refactor
    /// Create a `Pitch.Spelling.LetterName with the given `pitchClass` and the given
    /// `modifier`.
    public init?(pitchClass: Pitch.Class, quarterStepModifier: Pitch.Spelling.QuarterStepModifier) {

        switch pitchClass {

        // Category "zero"
        case 0,5:
            let initial = Pitch.Spelling.LetterName.default(for: pitchClass)
            switch quarterStepModifier {
            case .natural:
                self = initial
            case .doubleFlat:
                self = initial.successor
            case .sharp:
                self = initial.predecessor
            default:
                return nil // impossible
            }

        // Category "one"
        case 1,6:
            let initial = Pitch.Spelling.LetterName.default(for: pitchClass - 1)
            switch quarterStepModifier {
            case .flat:
                self = initial.successor
            case .sharp:
                self = initial
            case .doubleSharp:
                self = initial.predecessor
            default:
                return nil // impossible
            }

        // Category "two"
        case 2,7,9:
            let initial = Pitch.Spelling.LetterName.default(for: pitchClass)
            switch quarterStepModifier {
            case .doubleFlat:
                self = initial.successor
            case .natural:
                self = initial
            case .doubleSharp:
                self = initial.predecessor
            default:
                return nil // impossible
            }

        // Category "three"
        case 3,10:
            let initial = Pitch.Spelling.LetterName.default(for: pitchClass + 1)
            switch quarterStepModifier {
            case .doubleFlat:
                self = initial.successor
            case .flat:
                self = initial
            case .sharp:
                self = initial.predecessor
            default:
                return nil // impossible
            }

        // Category "four"
        case 4,11:
            let initial = Pitch.Spelling.LetterName.default(for: pitchClass)
            switch quarterStepModifier {
            case .flat:
                self = initial.successor
            case .natural:
                self = initial
            case .doubleSharp:
                self = initial.predecessor
            default:
                return nil // impossible
            }


        // Category "Five"
        case 8:
            switch quarterStepModifier {
            case .flat:
                self = .a
            case .sharp:
                self = .g
            default:
                return nil
            }
        default:
            return nil // impossible
        }
    }
}
