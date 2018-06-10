//
//  PitchSpellingCategory.swift
//  PitchSpeller
//
//  Created by James Bean on 6/9/18.
//

import Math
import Pitch

/// The possible directions of `QuarterStepModifier` values within the context of
/// a `PitchSpellingCategory`.
enum ModifierDirection: Hashable {
    case down
    case neutral
    case up
}

/// Interface for the six pitch spelling categories.
protocol PitchSpellingCategory {

    /// The available `QuarterStepModifier` value by the given `ModifierDirection`.
    static var modifiers: [ModifierDirection: Pitch.Spelling.QuarterStepModifier] { get }
}

extension Pitch.Spelling {

    /// Namespace for `PitchSpellingCategory` types.
    enum Category {

        /// Category for pitch classes `0` and `5`.
        struct Zero: PitchSpellingCategory {
            static var modifiers: [ModifierDirection: Pitch.Spelling.QuarterStepModifier] {
                return [.down: .doubleFlat, .neutral: .natural, .up: .sharp]
            }
        }

        /// Category for pitch classes `1` and `6`.
        struct One: PitchSpellingCategory {
            static var modifiers: [ModifierDirection: Pitch.Spelling.QuarterStepModifier] {
                return [.down: .flat, .neutral: .sharp, .up: .doubleSharp]
            }
        }

        /// Category for pitch classes `2`, `7`, and `9`.
        struct Two: PitchSpellingCategory {
            static var modifiers: [ModifierDirection: Pitch.Spelling.QuarterStepModifier] {
                return [.down: .doubleFlat, .neutral: .natural, .up: .doubleSharp]
            }
        }

        /// Category for pitch classes `3`, and `10`.
        struct Three: PitchSpellingCategory {
            static var modifiers: [ModifierDirection: Pitch.Spelling.QuarterStepModifier] {
                return [.down: .doubleFlat, .neutral: .flat, .up: .sharp]
            }
        }

        /// Category for pitch classes `4`, and `11`.
        struct Four: PitchSpellingCategory {
            static var modifiers: [ModifierDirection: Pitch.Spelling.QuarterStepModifier] {
                return [.down: .flat, .neutral: .natural, .up: .doubleSharp]
            }
        }

        /// Category for pitch class `8`.
        struct Five: PitchSpellingCategory {
            static var modifiers: [ModifierDirection: Pitch.Spelling.QuarterStepModifier] {
                return [.down: .flat, .up: .sharp]
            }
        }

        /// - Returns: The type of `PitchSpellingCategory` which the given `pitchClass` resides, if
        /// the `pitchClass` is an integral value. Otherwise, `nil`.
        static func category(for pitchClass: Pitch.Class) -> PitchSpellingCategory.Type? {
            switch pitchClass {
            case 0,5: return Zero.self
            case 1,6: return One.self
            case 2,7,9: return Two.self
            case 3,10: return Three.self
            case 4,11: return Four.self
            case 8: return Five.self
            default: return nil
            }
        }

        /// - Returns: The `Pitch.Spelling` value for the given `pitchClass` with the given
        /// `modifierDirection`, if the `pitchClass` is an integral value, and if the
        /// `modifierDirection` can be converted into a `QuarterStepModifier` within the
        /// `PitchSpellingCategory` in which the given `pitchClass` resides. Otherwise, `nil`.
        static func pitchSpelling(for pitchClass: Pitch.Class, modifierDirection: ModifierDirection)
            -> Pitch.Spelling?
        {
            guard
                let category = category(for: pitchClass),
                let modifier = category.modifiers[modifierDirection],
                let neutral = Pitch.Spelling.LetterName.neutral(for: pitchClass),
                let letterName = neutral.adjusted(for: pitchClass, with: modifierDirection)
            else {
                return nil
            }
            return Pitch.Spelling(letterName, modifier)
        }
    }
}

extension Pitch.Spelling.LetterName {

    /// - Returns: The `LetterName` which corresponds to the `.neutral` `ModifierDirection` for the
    /// the given `pitchClass`, if such a `LetterName` exists. Otherwise, `nil`.
    static func neutral(for pitchClass: Pitch.Class) -> Pitch.Spelling.LetterName? {
        switch pitchClass {
        // Category "Five" pitch classes have no neutral `LetterName`
        case 8:
            return nil
        // Category "One" pitch classes need to be shifted down
        case 1,6:
            return Pitch.Spelling.LetterName.default(for: pitchClass - 1)!
        // Category "Three" pitch classes need to be shifted up
        case 3,10:
            return Pitch.Spelling.LetterName.default(for: pitchClass + 1)!
        // `Pitch.Class` values which can be spelled with a `natural` modifier need no adjustment
        case 0...11:
            return Pitch.Spelling.LetterName.default(for: pitchClass)!
        default:
            return nil
        }
    }

    /// - Returns: A `LetterName` adjusted for the given `pitchClass` and the given
    /// `modifierDirection`, if such a `LetterName` value exists. Otherwise, `nil`.
    func adjusted(for pitchClass: Pitch.Class, with modifierDirection: ModifierDirection)
        -> Pitch.Spelling.LetterName?
    {
        switch pitchClass {
        case 8:
            switch modifierDirection {
            case .down: return .a
            case .up: return .g
            default: return nil
            }
        case 0...11:
            switch modifierDirection {
            case .down: return successor
            case .neutral: return self
            case .up: return predecessor
            }
        default:
            return nil
        }
    }
}

extension Pitch.Spelling.LetterName {

    /// - TODO: Refactor out into `CircularEnum`
    public var predecessor: Pitch.Spelling.LetterName {
        let ownIndex = Pitch.Spelling.LetterName.allCases.index(of: self)!
        let previousIndex = mod(ownIndex - 1, Pitch.Spelling.LetterName.allCases.count)
        return Pitch.Spelling.LetterName.allCases[previousIndex]
    }

    /// - TODO: Refactor out into `CircularEnum`
    public var successor: Pitch.Spelling.LetterName {
        let ownIndex = Pitch.Spelling.LetterName.allCases.index(of: self)!
        let nextIndex = mod(ownIndex + 1, Pitch.Spelling.LetterName.allCases.count)
        return Pitch.Spelling.LetterName.allCases[nextIndex]
    }

    /// - Returns: The `LetterName` for the given `pitchClass`, if the given `pitchClass` is
    /// spellable with a `.natural` `QuarterStepModifier`.
    internal static func `default`(for pitchClass: Pitch.Class) -> Pitch.Spelling.LetterName? {
        switch pitchClass {
        case 0: return .c
        case 2: return .d
        case 4: return .e
        case 5: return .f
        case 7: return .g
        case 9: return .a
        case 11: return .b
        default: return nil
        }
    }
}
