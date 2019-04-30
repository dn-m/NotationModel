//
//  Pitch.Spelling.Category.swift
//  PitchSpeller
//
//  Created by James Bean on 6/10/18.
//

import DataStructures
import Math
import Pitch

/// Interface for the six pitch spelling categories.
protocol PitchSpellingCategoryProtocol: TendencyConverting {
    typealias ModifierLookup = Bimap<ModifierDirection,Pitch.Spelling.Modifier>
    /// The available `Pitch.Spelling.Modifier` value by the given `ModifierDirection`.
    static var directionToModifier: ModifierLookup { get }
}

extension Pitch.Spelling {

    /// Namespace for `PitchSpellingCategoryProtocol` types.
    enum Category {

        /// Category for pitch classes `0` and `5`.
        struct Zero: PitchSpellingCategoryProtocol {
            static let directionToModifier: ModifierLookup = [
                .down: .doubleFlat,
                .neutral: .natural,
                .up: .sharp
            ]
        }

        /// Category for pitch classes `1` and `6`.
        struct One: PitchSpellingCategoryProtocol {
            static let directionToModifier: ModifierLookup = [
                .down: .flat,
                .neutral: .sharp,
                .up: .doubleSharp
            ]
        }

        /// Category for pitch classes `2`, `7`, and `9`.
        struct Two: PitchSpellingCategoryProtocol {
            static let directionToModifier: ModifierLookup = [
                .down: .doubleFlat,
                .neutral: .natural,
                .up: .doubleSharp
            ]
        }

        /// Category for pitch classes `3`, and `10`.
        struct Three: PitchSpellingCategoryProtocol {
            static let directionToModifier: ModifierLookup = [
                .down: .doubleFlat,
                .neutral: .flat,
                .up: .sharp
            ]
        }

        /// Category for pitch classes `4`, and `11`.
        struct Four: PitchSpellingCategoryProtocol {
            static let directionToModifier: ModifierLookup = [
                .down: .flat,
                .neutral: .natural,
                .up: .doubleSharp
            ]
        }

        /// Category for pitch class `8`.
        struct Five: PitchSpellingCategoryProtocol {
            static let directionToModifier: ModifierLookup = [
                .down: .flat,
                .up: .sharp
            ]
        }

        /// - Returns: The type of `PitchSpellingCategoryProtocol` in which the given `pitchClass`
        /// resides, if the `pitchClass` is an integral value. Otherwise, `nil`.
        //
        // TODO: The proposal for static subscripts was accepted:
        // https://github.com/apple/swift-evolution/blob/master/proposals/0254-static-subscripts.md
        // This would be a nice use case for that.
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

extension Pitch.Spelling {

    /// - Returns: The `Pitch.Spelling` value for the given `pitchClass` with the given
    /// `modifierDirection`, if the `pitchClass` is an integral value, and if the
    /// `modifierDirection` can be converted into a `QuarterStepModifier` within the
    /// `PitchSpellingCategoryProtocol` in which the given `pitchClass` resides. Otherwise, `nil`.
    init?(pitchClass: Pitch.Class, modifierDirection: ModifierDirection) {
        let letterName = Pitch.Spelling.letterName(pitchClass: pitchClass, with: modifierDirection)
        guard
            let category = Category.category(for: pitchClass),
            let modifier = category.directionToModifier[modifierDirection]
        else {
            return nil
        }
        self.init(letterName, modifier)
    }
}

extension Pitch.Spelling {
    
    /// - Returns: The `LetterName` which corresponds to the `.neutral` `ModifierDirection` for the
    /// the given `pitchClass`, if such a `LetterName` exists. Otherwise, `nil`.
    static func neutralLetterName(for pitchClass: Pitch.Class) -> LetterName? {
        guard let category = Category.category(for: pitchClass) else { return nil }
        guard let modifier = category.directionToModifier[.neutral] else { return nil }
        switch modifier {
        case .natural:
            return LetterName.default(for: pitchClass)
        case .flat:
            return LetterName.default(for: pitchClass + 1)
        case .sharp:
            return LetterName.default(for: pitchClass - 1)
        default:
            fatalError("Unsupported Pitch.Spelling.Modifier \(modifier)")
        }
    }
   
    /// Create a `LetterName` with the given `pitchClass` and `modifierDirection`.
    static func letterName(pitchClass: Pitch.Class, with modifierDirection: ModifierDirection)
        -> LetterName
    {
        guard let neutralLetterName = Pitch.Spelling.neutralLetterName(for: pitchClass)
            else { return modifierDirection == .down ? .a : .g }
        switch modifierDirection {
        case .down: return neutralLetterName.successor
        case .neutral: return neutralLetterName
        case .up: return neutralLetterName.predecessor
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
