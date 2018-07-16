//
//  Rhythm.Beaming.swift
//  SpelledRhythm
//
//  Created by James Bean on 6/18/18.
//

import DataStructures
import Rhythm

extension Rhythm {

    /// The beaming information for an entire `Rhythm`.
    public struct Beaming: Equatable {

        /// A single point of the beaming for a single beaming item (metrical `.instance`).
        public enum Point: Equatable {

            /// Rhythm.Beaming.Point.Vertical
            struct Vertical {

                enum StartOrStop {

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
                }

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
            }

            public enum Error: Swift.Error {
                case cuttingIneligibleState(Point)
            }

            /// Whether a beamlet is pointed forward or backward.
            public enum BeamletDirection: Double {
                case forward = 1
                case backward = -1
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

        /// The collection of points for a single beamed event (metrical `.instance`)
        public struct Item: Equatable {

            /// Errors which may occur when performing an operation on an `Item`.
            public enum Error: Swift.Error {
                case empty
            }

            /// Array of `Point` values ordered from lowest subdivision value (quarter, eighth,
            /// sixteenth, etc.) to highest.
            ///
            /// They must be ordered in groups of: `.maintain`, `.start`, `.stop`, `beamlet(...)`.
            var points: Stack<Point>

            // MARK: - Initializers

            public init(_ points: Stack<Point>) {
                self.points = points
            }
        }

        var items: [Item]

        // MARK: - Initializers

        /// Create a `Beaming` with the given `items`.
        public init(_ items: [Item]) {
            self.items = items
        }

        /// 
        ///
        /// - Throws: Error if the `Item` at the given `index` is empty.
        /// - Throws: Error if the `Item` at the given `index` is not
        public mutating func cut(amount: Int, at index: Int) throws {
            fatalError()
        }
    }
}

extension Rhythm.Beaming.Item: CollectionWrapping {
    public var base: Stack<Rhythm.Beaming.Point> {
        return points
    }
}

extension Rhythm.Beaming: CollectionWrapping {
    public var base: [Item] {
        return items
    }
}
