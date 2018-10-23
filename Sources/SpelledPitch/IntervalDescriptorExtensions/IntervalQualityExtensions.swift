//
//  IntervalQualityExtensions.swift
//  SpelledPitch
//
//  Created by James Bean on 10/13/18.
//

import Pitch

extension IntervalQuality {
    init(distance: Double, with platonicThreshold: Double) {
        let (diminished, augmented) = (-platonicThreshold,platonicThreshold)
        switch distance {
        case diminished - 4:
            self = .extended(.init(.quintuple, .diminished))
        case diminished - 3:
            self = .extended(.init(.quadruple, .diminished))
        case diminished - 2:
            self = .extended(.init(.triple, .diminished))
        case diminished - 1:
            self = .extended(.init(.double, .diminished))
        case diminished:
            self = .extended(.init(.single, .diminished))
        case -0.5:
            self = .imperfect(.minor)
        case +0.0:
            self = .perfect(.perfect)
        case +0.5:
            self = .imperfect(.major)
        case augmented:
            self = .extended(.init(.single, .augmented))
        case augmented + 1:
            self = .extended(.init(.double, .augmented))
        case augmented + 2:
            self = .extended(.init(.triple, .augmented))
        case augmented + 3:
            self = .extended(.init(.quadruple, .augmented))
        case augmented + 4:
            self = .extended(.init(.quintuple, .augmented))
        default:
            fatalError("Not possible to create a NamedIntervalQuality with interval \(distance)")
        }
    }
}
