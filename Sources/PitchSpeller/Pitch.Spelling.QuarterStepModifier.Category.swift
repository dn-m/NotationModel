//
//  NamedIntervalQuality.Category.swift
//  PitchSpeller
//
//  Created by James Bean on 5/22/18.
//

import Pitch
import SpelledPitch
import DataStructures

// Wetherfield Pitch Speller, Thesis pg. 38

extension Wetherfield {

    struct PitchSpeller {

        internal enum Category {

            internal enum Tendency: Int {
                case down = 0
                case up = 1
            }

            internal struct TendencyPair: Equatable, Hashable {

                let up: Tendency
                let down: Tendency

                init(_ up: Tendency, _ down: Tendency) {
                    self.up = up
                    self.down = down
                }

                init(_ tuple: (Tendency, Tendency)) {
                    self.up = tuple.0
                    self.down = tuple.1
                }
            }

            private typealias Map = [TendencyPair: Pitch.Spelling.QuarterStepModifier]

            private static var zero: Map = [
                .init(.up,.down): .natural,
                .init(.up,.up): .sharp,
                .init(.down,.down): .doubleFlat
            ]

            private static var one: Map = [
                .init(.up,.down): .sharp,
                .init(.down,.down): .flat,
                .init(.up,.up): .doubleSharp
            ]

            private static var two: Map = [
                .init(.up,.up): .doubleSharp,
                .init(.down,.down): .doubleFlat,
                .init(.up,.down): .natural
            ]

            private static var three: Map = [
                .init(.down,.down): .doubleFlat,
                .init(.up,.up): .sharp,
                .init(.up,.down): .flat
            ]

            private static var four: Map = [
                .init(.down,.down): .flat,
                .init(.up,.down): .natural,
                .init(.up,.up): .doubleSharp
            ]

            private static var five: Map = [
                .init(.up,.down): .sharp,
                .init(.down,.down): .flat
            ]

            private static func category(for pitchClass: Pitch.Class) -> Map? {
                switch pitchClass {
                case 0,5:
                    return zero
                case 1,6:
                    return one
                case 2,7,9:
                    return two
                case 3,10:
                    return three
                case 4,11:
                    return four
                case 8:
                    return five
                default:
                    return nil
                }
            }

            /// - Returns: `Pitch.Spelling.QuarterStepModifier` for the given `pitchClass` and
            /// `tendency`. This mapping is defined by Wetherfield on pg. 38 of the thesis _A Graphical
            /// Theory of Musical Pitch Spelling_.
            ///
            internal static func modifier(
                pitchClass: Pitch.Class,
                tendency: (Tendency,Tendency)
            ) -> Pitch.Spelling.QuarterStepModifier?
            {
                return category(for: pitchClass)?[.init(tendency)]
            }
        }
    }

    public struct FlowNetwork {

        struct UnassignedNodeInfo: Hashable {

            /// The `pitchClass` which is being represented by a given `Node`.
            let pitchClass: Pitch.Class

            /// Index of the node in the `Box` for the given `pitchClass`. Will be either `0`, or
            /// `1`. This value will ultimately represent the index within a `TendencyPair`.
            let index: Int
        }

        struct AssignedNodeInfo: Hashable {

            /// The `pitchClass` which is being represented by a given `Node`.
            let pitchClass: Pitch.Class

            /// Index of the node in the `Box` for the given `pitchClass`. Will be either `0`, or
            /// `1`. This value will ultimately represent the index within a `TendencyPair`.
            let index: Int

            /// The "tendency" value assigned subsequent to finding the minium cut.
            let tendency: PitchSpeller.Category.Tendency

            // MARK: - Initializers

            init(_ nodeInfo: UnassignedNodeInfo, tendency: PitchSpeller.Category.Tendency) {
                self.pitchClass = nodeInfo.pitchClass
                self.index = nodeInfo.index
                self.tendency = tendency
            }
        }

        // TODO: Consider more (space-)efficient storage of Nodes.
        internal var graph: Graph<UnassignedNodeInfo>
        internal var source: Graph<UnassignedNodeInfo>.Node
        internal var sink: Graph<UnassignedNodeInfo>.Node
        internal var internalNodes: [Graph<UnassignedNodeInfo>.Node] = []

        public init(pitchClasses: Set<Pitch.Class>, parsimonyPivot: Pitch.Class = 2) {

            // Create an empty `Graph`.
            self.graph = Graph()

            // Create the `source` node of the pair representing the `parsimony pivot`.
            self.source = self.graph.createNode(
                UnassignedNodeInfo(pitchClass: parsimonyPivot, index: 0)
            )

            // Create the `sink` nodeof the pair representing the `parsimony pivot`.
            self.sink = self.graph.createNode(
                UnassignedNodeInfo(pitchClass: parsimonyPivot, index: 1)
            )

            // Create nodes for each pitch class in the given `pitchClasses`.
            for pitchClass in pitchClasses {

                // Create two nodes, one which will represent the `up` tendency (index 0), and the
                // other which will represent the `down` tendency (index 1)
                for index in [0,1] {
                    internalNodes.append(
                        self.graph.createNode(
                            UnassignedNodeInfo(pitchClass: pitchClass, index: index)
                        )
                    )
                }
            }

            // Connect nodes
            for node in internalNodes {

                // Add edges from source to all internal nodes, with an initial value of 1.
                self.graph.addEdge(from: source, to: node, value: 1)

                // Add edges from all internal nodes to sink, with an initial value of 1.
                self.graph.addEdge(from: node, to: sink, value: 1)

                // Add edges from all internal nodes to all other internal nodes.
                for other in internalNodes.lazy.filter({ $0 != node }) {
                    self.graph.addEdge(from: node, to: other, value: 1)
                }
            }
        }
    }
}

