//
//  FlowNetwork.swift
//  PitchSpeller
//
//  Created by James Bean on 5/24/18.
//

import Pitch

/// Queue.
///
/// - TODO: Move to dn-m/Structure/DataStructures
public struct Queue <Element: Equatable> {

    private var storage: [Element] = []

    public var isEmpty: Bool {
        return storage.isEmpty
    }

    public var count: Int {
        return storage.count
    }

    public mutating func push(_ value: Element) {
        storage.append(value)
    }

    public mutating func pop() -> Element {
        return storage.remove(at: 0)
    }

    public func contains(_ value: Element) -> Bool {
        if storage.index(of: value) != nil {
            return true
        }
        return false
    }
}

extension Queue: ExpressibleByArrayLiteral {

    /// Create a `Queue` with an `ArrayLiteral`.
    public init(arrayLiteral elements: Element...) {
        self.storage = elements
    }
}

extension Wetherfield {

    /// - TODO: Make generic
    public struct FlowNetwork {

        typealias Path = Graph<UnassignedNodeInfo>.Path
        typealias Node = Graph<UnassignedNodeInfo>.Node

        internal struct UnassignedNodeInfo: Hashable {

            /// The `pitchClass` which is being represented by a given `Node`.
            ///
            /// - TODO: Make reference to `box` for `notehead` (pitch event) instead of `Pitch.Class`.
            let pitchClass: Pitch.Class

            /// Index of the node in the `Box` for the given `pitchClass`. Will be either `0`, or
            /// `1`. This value will ultimately represent the index within a `TendencyPair`.
            let index: Int
        }

        internal struct AssignedNodeInfo: Hashable {

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
        internal var source: Node
        internal var sink: Node
        internal var internalNodes: [Node] = []

        // TODO: Expand this out so that each "notehead" (pitch-event) has a `box` of two nodes as
        // opposed to only a single `Pitch.Class` having a `box`.
        public init(pitchClasses: Set<Pitch.Class>, parsimonyPivot: Pitch.Class = 2) {

            // Create an empty `Graph`.
            self.graph = Graph()

            // Create the `source` node of the pair representing the `parsimony pivot`.
            self.source = self.graph.createNode(
                UnassignedNodeInfo(pitchClass: parsimonyPivot, index: 0)
            )

            // Create the `sink` node of the pair representing the `parsimony pivot`.
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
                // TODO: Ensure `filter` does not making this accidentally expensive.
                for other in internalNodes.lazy.filter({ $0 != node }) {
                    self.graph.addEdge(from: node, to: other, value: 1)
                }
            }
        }

        /// - Returns: All of the paths from the `source` to the `sink`.
        internal var paths: Set<Path> {
            return graph.paths(from: source, to: sink)
        }
    }
}
