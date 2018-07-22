//
//  Beaming.swift
//  SpelledRhythm
//
//  Created by James Bean on 6/18/18.
//

import DataStructures
import Rhythm

/// The beaming information for an entire `Rhythm`.
public struct Beaming: Equatable {

    /// Errors which may occur when performing an cutting operation on an `Item`.
    public enum Error: Swift.Error {
        case indexOutOfBounds(Int)
        case previousStackEmpty
        case currentStackEmpty
        case notEnoughPoints
    }

    /// Whether a beamlet is pointed forward or backward.
    public enum BeamletDirection: Double {
        case forward = 1
        case backward = -1
    }

    /// A single point of the beaming for a single beaming item (metrical `.instance`).
    public enum Point: Equatable {

        public enum StartOrStop: Equatable {

            var points: [Point] {
                switch self {
                case .none: return []
                case .start(let count):
                    return Array(repeating: .start, count: count)
                case .stop(let count):
                    return Array(repeating: .stop, count: count)
                }
            }

            case none
            case start(count: Int)
            case stop(count: Int)

            func cut(amount: Int) -> (StartOrStop, Int) {
                switch self {
                case .none:
                    return (.none, amount)
                case .start(let count):
                    if count > amount {
                        return (.start(count: count - amount), 0)
                    } else {
                        return (.none, amount - count)
                    }
                case .stop(let count):
                    if count > amount {
                        return (.stop(count: count - amount), 0)
                    } else {
                        return (.none, amount - count)
                    }
                }
            }

            func cutAt(amount: Int) throws -> (before: StartOrStop, after: StartOrStop, remaining: Int) {
                switch self {
                case .none, .start:
                    return (self, self, amount)
                case .stop(let count):
                    if amount >= count {
                        return (self, .none, amount - count)
                    } else {
                        return (self, .stop(count: count - amount), count - amount)
                    }
                }
            }

            func cutAfter(amount: Int) throws -> (before: StartOrStop, after: StartOrStop, remaining: Int) {
                switch self {
                case .none, .stop:
                    return (self, self, amount)
                case .start(let count):
                    if amount >= count {
                        return (self, .none, amount - count)
                    } else {
                        return (self, .start(count: count - amount), count - amount)
                    }
                }
            }
        }

        /// Rhythm.Beaming.Point.Vertical
        public struct Vertical: Equatable {

            #warning("Implement beamlet direction if neither start nor stop")

            /// - Returns: The `Point` values contained herein.
            var points: [Point] {
                return
                    Array(repeating: .maintain, count: maintainCount) +
                    startOrStop.points +
                    Array(repeating: .beamlet(direction: .forward), count: beamletCount)
            }


            /// The amount of `.maintain` points.
            let maintainCount: Int

            /// The amount of `.start` or `.stop` points.
            let startOrStop: StartOrStop

            /// The amount of `.beamlet` points.
            let beamletCount: Int

            // MARK: - Initializers

            public init(
                maintain: Int = 0,
                startOrStop: StartOrStop = .none,
                beamlets: Int = 0
            )
            {
                self.maintainCount = maintain
                self.startOrStop = startOrStop
                self.beamletCount = beamlets
            }

            public init(
                maintain: Int = 0,
                start: Int,
                beamlets: Int = 0
            )
            {
                self.maintainCount = maintain
                self.startOrStop = start == 0 ? .none : .start(count: start)
                self.beamletCount = beamlets
            }

            public init(
                maintain: Int = 0,
                stop: Int,
                beamlets: Int = 0
            )
            {
                self.maintainCount = maintain
                self.startOrStop = stop == 0 ? .none : .stop(count: stop)
                self.beamletCount = beamlets
            }

            // cutAt
            func stopsToBeamlets(amount: Int) -> (Vertical,Int) {
                guard case .stop = startOrStop else { return (self,amount) }
                return startOrStopToBeamlets(amount: amount)
            }

            // cut at
            func maintainsToStarts(amount: Int) -> (Vertical,Int) {
                switch startOrStop {
                case .stop:
                    return (self,amount)
                case .none:
                    if maintainCount >= amount {
                        // absorb all amount, return 0 remaining
                        let vertical = Vertical(
                            maintain: maintainCount - amount,
                            start: amount,
                            beamlets: beamletCount
                        )
                        return (vertical, 0)
                    } else {
                        let remaining = amount - maintainCount
                        let vertical = Vertical(
                            maintain: 0,
                            start: maintainCount,
                            beamlets: beamletCount
                        )
                        return (vertical, remaining)
                    }
                case .start(let count):
                    if maintainCount >= amount {
                        let vertical = Vertical(
                            maintain: maintainCount - amount,
                            start: count + amount,
                            beamlets: beamletCount
                        )
                        return (vertical, 0)
                    } else {
                        let remaining = amount - maintainCount
                        let vertical = Vertical(
                            maintain: 0,
                            start: count + maintainCount,
                            beamlets: beamletCount
                        )
                        return (vertical, remaining)
                    }
                }
            }

            // cutAfter
            func startsToBeamlets(amount: Int) -> (Vertical,Int) {
                guard case .start = startOrStop else { return (self,amount) }
                return startOrStopToBeamlets(amount: amount)
            }

            func startOrStopToBeamlets(amount: Int) -> (Vertical, Int) {
                let (newStartOrStop, remaining) = startOrStop.cut(amount: amount)
                let vertical = Vertical(
                    maintain: maintainCount,
                    startOrStop: newStartOrStop,
                    beamlets: amount - remaining
                )
                return (vertical, remaining)
            }

            // cutAfter
            func maintainsToStops(amount: Int) -> (Vertical,Int) {
                switch startOrStop {
                case .start:
                    return (self,amount)
                case .none:
                    if maintainCount >= amount {
                        // absorb all amount, return 0 remaining
                        let vertical = Vertical(
                            maintain: maintainCount - amount,
                            stop: amount,
                            beamlets: beamletCount
                        )
                        return (vertical, 0)
                    } else {
                        let remaining = amount - maintainCount
                        let vertical = Vertical(
                            maintain: 0,
                            stop: maintainCount,
                            beamlets: beamletCount
                        )
                        return (vertical, remaining)
                    }
                case .stop(let count):
                    if maintainCount >= amount {
                        let vertical = Vertical(
                            maintain: maintainCount - amount,
                            stop: count + amount,
                            beamlets: beamletCount
                        )
                        return (vertical, 0)
                    } else {
                        let remaining = amount - maintainCount
                        let vertical = Vertical(
                            maintain: 0,
                            stop: count + maintainCount,
                            beamlets: beamletCount
                        )
                        return (vertical, remaining)
                    }
                }
            }

            /// Cuts `Vertical` when the current is `current`.
            func cutAt(amount: Int) throws -> Vertical {
                precondition(amount >= 0)
                guard !isEmpty else { throw Error.currentStackEmpty }

                // 1. Convert stops to beamlets
                // stop -> beamlet
                let (verticalAfterBeamletsTransform, remainingAfterStopsTransform) = self.stopsToBeamlets(amount: amount)

                if remainingAfterStopsTransform == 0 {
                    return verticalAfterBeamletsTransform
                }

                // 2. Convert maintains to starts
                let (verticalAfterMaintainsTransform, remainingAfterMaintainsTransform) = verticalAfterBeamletsTransform.maintainsToStarts(amount: remainingAfterStopsTransform)

                guard remainingAfterMaintainsTransform == 0 else {
                    throw Error.notEnoughPoints
                }

                return verticalAfterMaintainsTransform
            }

            /// Cuts `Vertical` when the current is `previous`.
            func cutAfter(amount: Int) throws -> Vertical {
                precondition(amount >= 0)
                guard !isEmpty else { throw  Error.previousStackEmpty }

                // 1. Convert starts to beamlets
                // stop -> beamlet
                let (verticalAfterBeamletsTransform, remainingAfterStopsTransform) = self.startsToBeamlets(amount: amount)

                if remainingAfterStopsTransform == 0 {
                    return verticalAfterBeamletsTransform
                }

                // 2. Convert maintains to stops
                let (verticalAfterMaintainsTransform, remainingAfterMaintainsTransform) = verticalAfterBeamletsTransform.maintainsToStops(amount: remainingAfterStopsTransform)

                guard remainingAfterMaintainsTransform == 0 else {
                    throw Error.notEnoughPoints
                }

                return verticalAfterMaintainsTransform
            }
        }

        /// Maintain a beam on a given level.
        case maintain
        /// Start a beam on a given level.
        case start
        /// Stop a beam on a given level.
        case stop
        /// Add a beamlet on a given level.
        case beamlet(direction: BeamletDirection)
    }

    var verticals: [Point.Vertical]

    // MARK: - Initializers

    /// Create a `Beaming` with the given `verticals`.
    public init(_ verticals: [Point.Vertical]) {
        self.verticals = verticals
    }

    /// Create a `Beaming` with the given `sequence`.
    public init <S> (_ sequence: S) where S: Sequence, S.Element == Point.Vertical {
        self.verticals = Array(sequence)
    }

    /// Subdivides beaming verticals by the given `amount` at the given `index`.
    ///
    /// - Throws: Error if the `Item` at the given `index` is empty.
    /// - Throws: Error if the `Item` at the given `index` is less than 1 or greater than equal
    /// to the amount of events contained herein.
    public func cut(amount: Int, at index: Int) throws -> Beaming {
        guard index > 0 && index < verticals.count else { throw Error.indexOutOfBounds(index) }
        let current = try verticals[index].cutAt(amount: amount)
        let previous = try verticals[index - 1].cutAfter(amount: amount)
        return Beaming(
            verticals.prefix(upTo: index - 1) +
            [previous,current] +
            verticals.suffix(from: index + 1)
        )
    }
}

extension Beaming.Point.Vertical: CollectionWrapping {
    public var base: [Beaming.Point] {
        return points
    }
}

extension Beaming.Point.Vertical: CustomStringConvertible {
    public var description: String {
        return points.map { "\($0)" }.joined(separator: "\n")
    }
}

extension Beaming: CollectionWrapping {
    public var base: [Point.Vertical] {
        return verticals
    }
}

extension Beaming: CustomStringConvertible {
    public var description: String {
        return verticals.enumerated().map { (index,vertical) in "\(index): \(vertical)" }.joined(separator: "\n")
    }
}
