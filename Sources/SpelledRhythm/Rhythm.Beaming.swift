//
//  Rhythm.Beaming.swift
//  SpelledRhythm
//
//  Created by James Bean on 6/18/18.
//

import StructureWrapping
import Rhythm

extension Rhythm {

    /// The beaming information for an entire `Rhythm`.
    public struct Beaming: Equatable {

        /// The collection of points for a single beamed event (metrical `.instance`)
        public struct Item: Equatable {

            /// Whether a beamlet is pointed forward or backward.
            public enum BeamletDirection: Double {
                case forward = 1
                case backward = -1
            }

            /// A single point of the beaming for a single beaming item (metrical `.instance`).
            public enum Point: Equatable {
                /// Maintain a beam on a given level.
                case maintain
                /// Start a beam on a given level.
                case start
                /// Stop a beam on a given level.
                case stop
                /// Add a beamlet on a given level.
                case beamlet(direction: BeamletDirection)
            }

            /// Array of `Point` values ordered from lowest subdivision value (quarter, eighth,
            /// sixteenth, etc.) to highest.
            ///
            /// They must be ordered in groups of: `.maintain`, `.start`, `.stop`, `beamlet(...)`.
            private let points: [Point]

            public init(_ points: [Point]) {
                self.points = points
            }
        }

        private let items: [Item]

        // MARK: - Initializers

        /// Create a `Beaming` with the given `items`.
        public init(_ items: [Item]) {
            self.items = items
        }
    }
}

extension Rhythm.Beaming.Item: CollectionWrapping {
    public var base: [Point] {
        return points
    }
}

extension Rhythm.Beaming: CollectionWrapping {
    public var base: [Item] {
        return items
    }
}
