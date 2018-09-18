//
//  TendencyConverting.swift
//  PitchSpeller
//
//  Created by James Bean on 6/10/18.
//

import Pitch

/// Interface for `PitchSpellingCategoryProtocol` types which can convert a `TendencyPair` into a
/// `ModifierDirection`.
protocol TendencyConverting {
    typealias TendencyMap = [TendencyPair: ModifierDirection]
    static var modifierDirectionByTendencies: TendencyMap { get }
}

extension TendencyConverting {
    /// - Returns: The `ModifierDirection` for the given `tendencies`, if such a direction exists.
    /// Otherwise, `nil`.
    static func modifierDirection(for tendencies: TendencyPair)
        -> ModifierDirection?
    {
        return modifierDirectionByTendencies[tendencies]
    }
}

