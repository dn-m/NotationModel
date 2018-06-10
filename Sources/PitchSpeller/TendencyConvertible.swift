//
//  TendencyConvertible.swift
//  PitchSpeller
//
//  Created by James Bean on 6/10/18.
//

import Pitch

typealias TendencyMap = [TendencyPair: ModifierDirection]

/// Interface for `PitchSpellingCategory` types which can transform a `TendencyPair` into a
/// `ModifierDirection`.
protocol TendencyConvertible {
    static var modifierDirectionByTendencies: TendencyMap { get }
}

extension PitchSpellingCategory where Self: TendencyConvertible {
    //static func category
}

extension TendencyConvertible {
    static func modifierDirection(for tendencies: TendencyPair)
        -> ModifierDirection?
    {
        return modifierDirectionByTendencies[tendencies]
    }
}

extension Pitch.Spelling.Category.Zero: TendencyConvertible {
    static var modifierDirectionByTendencies: TendencyMap {
        return [
            .init(.down,.down): .down,
            .init(.up,.down): .neutral,
            .init(.up,.up): .up
        ]
    }
}

extension Pitch.Spelling.Category.One: TendencyConvertible {
    static var modifierDirectionByTendencies: TendencyMap {
        return [
            .init(.down,.down): .down,
            .init(.up,.down): .neutral,
            .init(.up,.up): .up
        ]
    }
}

extension Pitch.Spelling.Category.Two: TendencyConvertible {
    static var modifierDirectionByTendencies: TendencyMap {
        return [
            .init(.down,.down): .down,
            .init(.up,.down): .neutral,
            .init(.up,.up): .up
        ]
    }
}

extension Pitch.Spelling.Category.Three: TendencyConvertible {
    static var modifierDirectionByTendencies: TendencyMap {
        return [
            .init(.down,.down): .down,
            .init(.up,.down): .neutral,
            .init(.up,.up): .up
        ]
    }
}

extension Pitch.Spelling.Category.Four: TendencyConvertible {
    static var modifierDirectionByTendencies: TendencyMap {
        return [
            .init(.down,.down): .down,
            .init(.up,.down): .neutral,
            .init(.up,.up): .up
        ]
    }
}

extension Pitch.Spelling.Category.Five: TendencyConvertible {
    static var modifierDirectionByTendencies: TendencyMap {
        return [
            .init(.down,.down): .down,
            .init(.up,.down): .up
        ]
    }
}
