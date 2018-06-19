//
//  Rhythm.Spelling.swift
//  SpelledRhythm
//
//  Created by James Bean on 6/18/18.
//

import DataStructures
import StructureWrapping
import MetricalDuration
import Rhythm

extension Rhythm {

    public struct Spelling: Equatable {

        /// Information needed to abstractly represent all of the tuplet brackets for a single
        /// `Rhythm`.
        public typealias Grouping = Tree<Group.Context,Group.Context>

        /// Whether a tie is needed to start, stop, or not exist at all for a given metrical
        /// instance.
        public enum Tie {
            /// No ties needed.
            case none
            /// Start tie.
            case start
            /// Stop tie.
            case stop
            /// Continue a tie by stopping the previous and starting a new one.
            case maintain
        }

        /// Information necessary to render a tuplet bracket.
        public struct Group: Equatable {

            /// `Group` in context, applying to the indices of the leaves to which it applies.
            public struct Context: Equatable {

                // MARK: - Instance Properties

                /// `Group`.
                public let group: Group

                /// Range of leaves to which the `group` applies.
                public let leafRange: CountableClosedRange<Int>

                // MARK: - Initializers

                /// Creates a `Group.Context` with the given `group` for the given `range` of leaf
                /// indices.
                public init(for group: Group, in range: CountableClosedRange<Int>) {
                    self.group = group
                    self.leafRange = range
                }
            }

            // MARK: - Instance Properties

            /// `MetricalDuration` of a `Group`.
            public let duration: MetricalDuration

            /// The sum of the contents contained herein.
            public let contentsSum: Int

            // MARK: - Instance Methods

            /// - Returns: The `Group.Context`, applying the `self` to the given `range` of leaf
            /// indices.
            public func context(range: CountableClosedRange<Int>) -> Context {
                return Context(for: self, in: range)
            }
        }

        /// Information needed to abstractly represent a single metrical instance.
        public struct Item: Equatable {
            let beamItem: Beaming.Item
            let tie: Tie
            let dots: Int
        }

        /// All of the information needed to abstractly represent all of the metrical instances
        /// within a single `Rhythm`.
        let items: [Item]
    }
}

extension Rhythm.Spelling: CollectionWrapping {
    public var base: [Item] {
        return items
    }
}

extension Rhythm.Spelling.Group: CustomStringConvertible {
    public var description: String {
        return "\(contentsSum):\(duration)"
    }
}
