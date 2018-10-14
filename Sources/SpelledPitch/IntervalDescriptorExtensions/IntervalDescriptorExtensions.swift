//
//  IntervalDescriptorExtensions.swift
//  SpelledPitch
//
//  Created by James Bean on 10/13/18.
//

import Pitch

extension IntervalDescriptor where Ordinal: SpelledPitchConvertingIntervalOrdinal {

    /// Creates a `IntervalDescriptor`-conforming type with the given `interval` (i.e., the distance
    /// between the `NoteNumber` representations of `Pitch` or `Pitch.Class` values) and the given
    /// `steps` (i.e., the distance between the `LetterName` attributes of `Pitch.Spelling`
    /// values).
    init(interval: Double, steps: Int) {
        let (quality,ordinal) = Self.qualityAndOrdinal(interval: interval, steps: steps)
        self.init(quality,ordinal)
    }

    /// - Returns the `IntervalQuality` and `Ordinal` values for the given `interval` (i.e.,
    /// the distance between the `NoteNumber` representations of `Pitch` or `Pitch.Class` values)
    /// and the given `steps (i.e., the distance between the `LetterName` attributes of
    ///`Pitch.Spelling`  values).
    static func qualityAndOrdinal(interval: Double, steps: Int) -> (IntervalQuality, Ordinal) {
        let distance = Ordinal.platonicDistance(from: interval, to: steps)
        let ordinal = Ordinal(steps: steps)!
        let quality = IntervalQuality(distance: distance, with: ordinal.platonicThreshold)
        return (quality, ordinal)
    }
}
