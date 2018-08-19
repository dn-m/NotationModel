//
//  EDO.swift
//  SpelledPitch
//
//  Created by James Bean on 8/18/18.
//

/// Interface for the `EDO` (equal divisions of the octave) `TuningSystem` types.
public protocol EDO: TuningSystem { }

/// Interface for `Modifier` types within an `EDO` `TuningSystem`.
protocol EDOModifier {

    // MARK: - Static Properties

    /// A `Modifier` which does not apply any modification.
    static var identity: Self { get }
}
