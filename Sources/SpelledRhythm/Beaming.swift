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

                /// - Returns: Remaining levels to cut.
                mutating func cut(amount: Int) throws -> Int {
                    switch self {
                    case .none:
                        return amount
                    case .start(let count):
                        if amount >= count {
                            self = .none
                            return amount - count
                        } else {
                            self = .start(count: count - amount)
                            return 0
                        }
                    case .stop(let count):
                        if amount >= count {
                            self = .none
                            return amount - count
                        } else {
                            self = .stop(count: count - amount)
                            return 0
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
            var maintainCount: Int

            /// The amount of `.start` or `.stop` points.
            var startOrStop: StartOrStop

            /// The amount of `.beamlet` points.
            var beamletCount: Int

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
            mutating func cutAt(amount: Int) throws {
                precondition(amount >= 0)
                guard !isEmpty else { throw Error.currentStackEmpty }
                let remaining = try startOrStop.cut(amount: amount)
                print("remaining after cut at: \(remaining)")
            }

            /// Cuts `Vertical` when the current is `previous`.
            mutating func cutAfter(amount: Int) throws {
                precondition(amount >= 0)
                guard !isEmpty else { throw  Error.previousStackEmpty }
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

    /// Subdivides beaming verticals by the given `amount` at the given `index`.
    ///
    /// - Throws: Error if the `Item` at the given `index` is empty.
    /// - Throws: Error if the `Item` at the given `index` is less than 1 or greater than equal
    /// to the amount of events contained herein.
    public mutating func cut(amount: Int, at index: Int) throws {
        guard index > 0 && index < verticals.count else { throw Error.indexOutOfBounds(index) }
        try verticals[index].cutAt(amount: amount)
        try verticals[index - 1].cutAt(amount: amount)

        #warning("TODO: Implement cut(amount:at:)")
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
