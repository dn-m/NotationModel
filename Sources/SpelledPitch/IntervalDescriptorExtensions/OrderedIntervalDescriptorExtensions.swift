//
//  OrderedIntervalDescriptorExtensions.swift
//  SpelledPitch
//
//  Created by James Bean on 1/8/17.
//
//

import Math
import Algorithms
import Pitch

extension OrderedIntervalDescriptor {

    /// Creates an `OrderedIntervalDescriptor` with two `SpelledPitch` values.
    public init(_ a: SpelledPitch, _ b: SpelledPitch) {
        let (a,b,didSwap) = swapped(a,b) { a > b }
        let (interval,steps) = intervalAndSteps(a,b)
        let (quality,ordinal) = OrderedIntervalDescriptor.qualityAndOrdinal(interval: interval, steps: steps)
        self.init(didSwap ? .descending : .ascending, ordinal, quality)
    }
}

extension OrderedIntervalDescriptor.Ordinal: SpelledPitchConvertingIntervalOrdinal {

    /// - Returns: The distance in semitones from an iedal interval at which point an interval
    /// quality becomes diminished or augmented for a given `Ordinal`.
    var platonicThreshold: Double {
        switch self {
        case .perfect:
            return 1
        case .imperfect:
            return 1.5
        }
    }
}

/// - Returns: The "ideal" interval for the given amount of scalar steps between two
/// `SpelledPitch` values.
///
/// For example, perfect intervals have a single ideal spelling, whereas imperfect intervals
/// could be spelled two different ways.
func idealSemitoneInterval(steps: Int) -> Double {
    assert((0..<7).contains(steps))
    switch steps {
    case 0:
        return 0
    case 1:
        return 1.5
    case 2:
        return 3.5
    case 3:
        return 5
    case 4:
        return 7
    case 5:
        return 8.5
    case 6:
        return 10.5
    default:
        fatalError("Impossible")
    }
}

private func intervalAndSteps(_ a: SpelledPitch,  _ b: SpelledPitch) -> (Double,Int) {
    return ((interval(a,b), steps(a,b)))
}

private func interval(_ a: SpelledPitch, _ b: SpelledPitch) -> Double {
    return (b.pitch - a.pitch).value.value
}

private func steps(_ a: SpelledPitch, _ b: SpelledPitch) -> Int {
    return mod(b.spelling.letterName.steps - a.spelling.letterName.steps, 7)
}
