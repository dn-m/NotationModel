//
//  TendencyConverting.swift
//  PitchSpeller
//
//  Created by James Bean on 6/10/18.
//

import DataStructures
import Pitch

/// Interface for `PitchSpellingCategoryProtocol` types which can convert a `TendencyPair` into a
/// `ModifierDirection`.
protocol TendencyConverting {
    typealias DirectionLookup = Bimap<TendencyPair,ModifierDirection>
    static var tendenciesToDirection: DirectionLookup { get }
}

extension TendencyConverting {
    /// - Returns: The `ModifierDirection` for the given `tendencies`, if such a direction exists.
    /// Otherwise, `nil`.
    static func modifierDirection(for tendencies: TendencyPair)
        -> ModifierDirection?
    {
        return tendenciesToDirection[tendencies]
    }
}

extension Pitch.Spelling.Category.Zero: TendencyConverting {
    static let tendenciesToDirection: DirectionLookup = [
        .init(.down,.down): .down,
        .init(.up,.down): .neutral,
        .init(.up,.up): .up
    ]
}

extension Pitch.Spelling.Category.One: TendencyConverting {
    static let tendenciesToDirection: DirectionLookup = [
        .init(.down,.down): .down,
        .init(.up,.down): .neutral,
        .init(.up,.up): .up
    ]
}

extension Pitch.Spelling.Category.Two: TendencyConverting {
    static var tendenciesToDirection: DirectionLookup = [
        .init(.down,.down): .down,
        .init(.up,.down): .neutral,
        .init(.up,.up): .up
    ]
}

extension Pitch.Spelling.Category.Three: TendencyConverting {
    static var tendenciesToDirection: DirectionLookup = [
        .init(.down,.down): .down,
        .init(.up,.down): .neutral,
        .init(.up,.up): .up
    ]
}

extension Pitch.Spelling.Category.Four: TendencyConverting {
    static var tendenciesToDirection: DirectionLookup = [
        .init(.down,.down): .down,
        .init(.up,.down): .neutral,
        .init(.up,.up): .up
    ]
}

extension Pitch.Spelling.Category.Five: TendencyConverting {
    static var tendenciesToDirection: DirectionLookup = [
        .init(.down,.down): .down,
        .init(.down,.up): .down,
        .init(.up,.down): .up,
        .init(.up,.up): .up
    ]
}
