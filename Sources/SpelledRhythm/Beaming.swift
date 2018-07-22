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

        /// Rhythm.Beaming.Point.Vertical
        public struct Vertical: Equatable {

            #warning("Implement beamlet direction if neither start nor stop")

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
                self.startOrStop = .start(count: start)
                self.beamletCount = beamlets
            }

            public init(
                maintain: Int = 0,
                stop: Int,
                beamlets: Int = 0
            )
            {
                self.maintainCount = maintain
                self.startOrStop = .stop(count: stop)
                self.beamletCount = beamlets
            }

            /// Cuts `Vertical` when the current is `current`.
            func cutAt(amount: Int) throws -> Vertical {
                precondition(amount >= 0)
                guard !isEmpty else { throw Error.currentStackEmpty }
                let (startOrStopBefore,startOrStopAfter,remaining) = try startOrStop.cutAt(amount: amount)
                let beamletBump = amount - remaining
                if remaining > 0 {
                    if remaining > maintainCount {
                        throw Error.notEnoughPoints
                    } else {
                        // Transform maintain to beamlets
                        return Vertical(
                            maintain: maintainCount - remaining,
                            startOrStop: startOrStopAfter,
                            beamlets: beamletCount + remaining
                        )
                    }
                }
                return Vertical(
                    maintain: maintainCount,
                    startOrStop: startOrStopAfter,
                    beamlets: beamletCount + beamletBump
                )
            }

            /// Cuts `Vertical` when the current is `previous`.
            func cutAfter(amount: Int) throws -> Vertical {
                precondition(amount >= 0)
                guard !isEmpty else { throw  Error.previousStackEmpty }
                let (before,after,remaining) = try startOrStop.cutAfter(amount: amount)
                let beamletBump = amount - remaining
                if remaining > 0 {
                    if remaining > maintainCount {
                        throw Error.notEnoughPoints
                    } else {
                        return Vertical(
                            maintain: maintainCount - remaining,
                            startOrStop: after,
                            beamlets: beamletCount + remaining
                        )
                    }
                }
                return Vertical(
                    maintain: maintainCount,
                    startOrStop: after,
                    beamlets: beamletCount + beamletBump
                )
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

        #warning("TODO: Implement cut(amount:at:)")

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
