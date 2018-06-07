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

// TripleOutputCategory
// DoubleOutputCategory
// SingleOutputCategory

// TripleInputCategory
// DoubleInputCategory
// SingleInputCategory



extension Wetherfield.PitchSpeller {

    /// - Returns: A `SpelledPitch` value applied to the given `pitch` with the given `tendencies`
    /// which are resultant from the `FlowNetwork` decoding.
    func spelledPitch(pitch: Pitch, tendencies: TendencyPair) -> SpelledPitch {
        let (modifier, _) = Category.modifierAndIndex(for: pitch.class, with: tendencies)!
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

    /// - TODO: Architect things around concrete Category instances, with calling instance methods.
    internal struct Category {

        private typealias Map = OrderedDictionary<TendencyPair,Pitch.Spelling.QuarterStepModifier>

        // Each of these `Map` values are ordered from flat to sharp.

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
        internal static func modifierAndIndex(
            for pitchClass: Pitch.Class,
            with tendencies: TendencyPair
        ) -> (modifier: Pitch.Spelling.QuarterStepModifier, index: Int)?
        {
            guard let category = self.category(for: pitchClass) else { return nil }
            let index = category.keys.index(of: tendencies)!
            guard let modifier = category[tendencies] else { return nil }
            return (modifier: modifier, index: index)
        }

        internal static func pitchSpelling(pitchClass: Pitch.Class, tendencies: TendencyPair)
            -> Pitch.Spelling?
        {

            guard let (modifier, index) = modifierAndIndex(for: pitchClass, with: tendencies) else {
                return nil
            }

            var letterName: Pitch.Spelling.LetterName? {

                var initial: Pitch.Spelling.LetterName {
                    switch pitchClass {
                    // "White keys" pitch classes need no adjustment
                    case 0,2,4,5,7,9,11:
                        return Pitch.Spelling.LetterName.default(for: pitchClass)
                    // Category "One" pitch classes need to be shifted down
                    case 1,6:
                        return Pitch.Spelling.LetterName.default(for: pitchClass - 1)
                    // Category "Three" pitch classes need to be shifted up
                    case 3,10:
                        return Pitch.Spelling.LetterName.default(for: pitchClass + 1)
                    default:
                        fatalError()
                    }
                }

                switch pitchClass {
                case 0,1,2,3,4,5,6,7,9,10,11:
                    return index == 1 ? initial : index == 0 ? initial.successor : initial.predecessor
                case 8:
                    return modifier == .flat ? .a : .g
                default:
                    return nil
                }
            }

            return letterName.map { Pitch.Spelling($0, modifier) }
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

        // Get lettername given position of quarterStepModifier in options

        func initialLetterName(for pitchClass: Pitch.Class) -> Pitch.Spelling.LetterName {
            switch pitchClass {
            case 0,2,4,5,7,9,11:
                return Pitch.Spelling.LetterName.default(for: pitchClass)
            case 1,6:
                return Pitch.Spelling.LetterName.default(for: pitchClass - 1)
            case 3,10:
                return Pitch.Spelling.LetterName.default(for: pitchClass + 1)
            case 8:
                return .a // temporary
            default:
                fatalError()
            }
        }

        let initial = initialLetterName(for: pitchClass)

        switch pitchClass {

        // Category "zero"
        case 0,5:

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
