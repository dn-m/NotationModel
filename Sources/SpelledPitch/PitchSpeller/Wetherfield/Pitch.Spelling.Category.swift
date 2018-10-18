//
//  Pitch.Spelling.Category.swift
//  PitchSpeller
//
//  Created by James Bean on 6/10/18.
//

import Math
import Pitch

/// Interface for the six pitch spelling categories.
protocol PitchSpellingCategoryProtocol {
    typealias ModifierMap = [ModifierDirection: EDO12.Modifier]
    /// The available `QuarterStepModifier` value by the given `ModifierDirection`.
    static var modifiers: [ModifierDirection: EDO12.Modifier] { get }
}

extension Pitch.Spelling {

    /// Namespace for `PitchSpellingCategoryProtocol` types.
    enum Category {

        /// Category for pitch classes `0` and `5`.
        struct Zero: PitchSpellingCategoryProtocol {
            static var modifiers: ModifierMap {
                return [.down: .flat(2), .neutral: .natural, .up: .sharp(count: 1)]
            }
        }

        /// Category for pitch classes `1` and `6`.
        struct One: PitchSpellingCategoryProtocol {
            static var modifiers: ModifierMap {
                return [.down: .flat(1), .neutral: .sharp(count: 1), .up: .sharp(count: 2)]
            }
        }

        /// Category for pitch classes `2`, `7`, and `9`.
        struct Two: PitchSpellingCategoryProtocol {
            static var modifiers: ModifierMap {
                return [.down: .flat(2), .neutral: .natural, .up: .sharp(count: 2)]
            }
        }

        /// Category for pitch classes `3`, and `10`.
        struct Three: PitchSpellingCategoryProtocol {
            static var modifiers: ModifierMap {
                return [.down: .flat(2), .neutral: .flat(1), .up: .sharp(count: 1)]
            }
        }

        /// Category for pitch classes `4`, and `11`.
        struct Four: PitchSpellingCategoryProtocol {
            static var modifiers: ModifierMap {
                return [.down: .flat(1), .neutral: .natural, .up: .sharp(count: 2)]
            }
        }

        /// Category for pitch class `8`.
        struct Five: PitchSpellingCategoryProtocol {
            static var modifiers: ModifierMap {
                return [.down: .flat(1), .up: .sharp(count: 1)]
            }
        }

        /// - Returns: The type of `PitchSpellingCategoryProtocol` in which the given `pitchClass`
        /// resides, if the `pitchClass` is an integral value. Otherwise, `nil`.
        static func category(for pitchClass: Pitch.Class) -> PitchSpellingCategoryProtocol.Type? {
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
    }
}

extension Pitch.Spelling where Tuning == EDO12 {

    /// - Returns: The `Pitch.Spelling` value for the given `pitchClass` with the given
    /// `modifierDirection`, if the `pitchClass` is an integral value, and if the
    /// `modifierDirection` can be converted into a `QuarterStepModifier` within the
    /// `PitchSpellingCategoryProtocol` in which the given `pitchClass` resides. Otherwise, `nil`.
    init?(pitchClass: Pitch.Class, modifierDirection: ModifierDirection) {
        guard
            let category = Category.category(for: pitchClass),
            let modifier = category.modifiers[modifierDirection],
            let letterName = LetterName(pitchClass: pitchClass, modifierDirection: modifierDirection)
        else {
            return nil
        }
        self.init(letterName, modifier)
    }
}

extension LetterName {

    /// Create a `LetterName` with the given `pitchClass` and `modifierDirection`.
    init?(pitchClass: Pitch.Class, modifierDirection: ModifierDirection) {
        if pitchClass == 8 {
            switch modifierDirection {
            case .down: self = .a
            case .up: self = .g
            default: return nil
            }
            return
        }
        guard
            let neutral = LetterName.neutral(for: pitchClass),
            let adjusted = neutral.adjusted(for: pitchClass, with: modifierDirection)
        else {
            return nil
        }
        self = adjusted
    }

    /// - Returns: The `LetterName` which corresponds to the `.neutral` `ModifierDirection` for the
    /// the given `pitchClass`, if such a `LetterName` exists. Otherwise, `nil`.
    static func neutral(for pitchClass: Pitch.Class) -> LetterName? {
        switch pitchClass {
        // Category "Five" pitch classes have no neutral `LetterName`
        case 8:
            return nil
        // Category "One" pitch classes need to be shifted down
        case 1,6:
            return LetterName.default(for: pitchClass - 1)!
        // Category "Three" pitch classes need to be shifted up
        case 3,10:
            return LetterName.default(for: pitchClass + 1)!
        // `Pitch.Class` values which can be spelled with a `natural` modifier need no adjustment
        case 0...11:
            return LetterName.default(for: pitchClass)!
        default:
            return nil
        }
    }

    /// - Returns: A `LetterName` adjusted for the given `pitchClass` and the given
    /// `modifierDirection`, if such a `LetterName` value exists. Otherwise, `nil`.
    func adjusted(for pitchClass: Pitch.Class, with modifierDirection: ModifierDirection)
        -> LetterName?
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

extension LetterName {

    /// - Returns: The next-lower `LetterName` value.
    /// - TODO: Refactor out into `CircularEnum`
    public var predecessor: LetterName {
        let ownIndex = LetterName.allCases.index(of: self)!
        let previousIndex = mod(ownIndex - 1, LetterName.allCases.count)
        return LetterName.allCases[previousIndex]
    }

    /// - Returns: The next-higher `LetterName` value.
    /// - TODO: Refactor out into `CircularEnum`
    public var successor: LetterName {
        let ownIndex = LetterName.allCases.index(of: self)!
        let nextIndex = mod(ownIndex + 1, LetterName.allCases.count)
        return LetterName.allCases[nextIndex]
    }

    /// - Returns: The `LetterName` for the given `pitchClass`, if the given `pitchClass` is
    /// spellable with a `.natural` `QuarterStepModifier`.
    internal static func `default`(for pitchClass: Pitch.Class) -> LetterName? {
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

// FIXME: Move below to own file when SR-631 build order bug is resolved.
// MARK: `Pitch.Spelling.Category` -> `TendencyConverting`

extension Pitch.Spelling.Category.Zero: TendencyConverting {
    static var modifierDirectionByTendencies: TendencyConverting.TendencyMap {
        return [
            .init(.down,.down): .down,
            .init(.up,.down): .neutral,
            .init(.up,.up): .up
        ]
    }
}

extension Pitch.Spelling.Category.One: TendencyConverting {
    static var modifierDirectionByTendencies: TendencyConverting.TendencyMap {
        return [
            .init(.down,.down): .down,
            .init(.up,.down): .neutral,
            .init(.up,.up): .up
        ]
    }
}

extension Pitch.Spelling.Category.Two: TendencyConverting {
    static var modifierDirectionByTendencies: TendencyConverting.TendencyMap {
        return [
            .init(.down,.down): .down,
            .init(.up,.down): .neutral,
            .init(.up,.up): .up
        ]
    }
}

extension Pitch.Spelling.Category.Three: TendencyConverting {
    static var modifierDirectionByTendencies: TendencyConverting.TendencyMap {
        return [
            .init(.down,.down): .down,
            .init(.up,.down): .neutral,
            .init(.up,.up): .up
        ]
    }
}

extension Pitch.Spelling.Category.Four: TendencyConverting {
    static var modifierDirectionByTendencies: TendencyConverting.TendencyMap {
        return [
            .init(.down,.down): .down,
            .init(.up,.down): .neutral,
            .init(.up,.up): .up
        ]
    }
}

extension Pitch.Spelling.Category.Five: TendencyConverting {
    static var modifierDirectionByTendencies: TendencyConverting.TendencyMap {
        return [
            .init(.down,.down): .down,
            .init(.up,.down): .up
        ]
    }
}
