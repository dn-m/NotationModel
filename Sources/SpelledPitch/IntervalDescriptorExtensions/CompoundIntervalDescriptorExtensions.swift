//
//  CompoundSpelledInterval.swift
//  SpelledPitch
//
//  Created by James Bean on 5/20/18.
//

import Math
import Algorithms
import Pitch

extension CompoundIntervalDescriptor {

    /// Creates a `CompoundSpelledInterval` with the two given `SpelledPitch` values.
    public init(_ a: SpelledPitch<EDO12>, _ b: SpelledPitch<EDO12>) {
        self.init(OrderedIntervalDescriptor(a,b), displacedBy: abs(b.octave - a.octave))
    }
}
