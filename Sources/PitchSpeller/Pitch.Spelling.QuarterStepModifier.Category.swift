//
//  NamedIntervalQuality.Category.swift
//  PitchSpeller
//
//  Created by James Bean on 5/22/18.
//

import Pitch
import SpelledPitch
import DataStructures
import StructureWrapping

// Wetherfield Pitch Speller, Thesis pg. 38

/// Minimal implementeation of a Directed Graph with Weighted (/ Capacious) Edges.
public struct Graph <Value: Hashable> {

    // TODO: Consider making own type which wraps `[Node]`
    public typealias Path = [Node]

    public struct Node: Hashable {
        var value: Value
    }

    public struct Edge: Hashable {
        public var source: Node
        public var destination: Node
        public var value: Double
        public init(from source: Node, to destination: Node, value: Double) {
            self.source = source
            self.destination = destination
            self.value = value
        }
    }

    // MARK: - Instance Properties

    public var edges: [Edge] {
        return adjacencyList.flatMap { _, values in values }
    }

    public var nodes: [Node] {
        return adjacencyList.map { node, _ in node }
    }

    private var adjacencyList: [Node: [Edge]] = [:]

    // MARK: - Initializers

    public init() { }

    // MARK: - Insance Methods

    public mutating func createNode(_ value: Value) -> Node {
        let node = Node(value: value)
        if adjacencyList[node] == nil {
            adjacencyList[node] = []
        }
        return node
    }

    public mutating func addEdge(from source: Node, to destination: Node, value: Double) {
        let edge = Edge(from: source, to: destination, value: value)
        adjacencyList[source]?.append(edge)
    }

    public func edgeValue(from source: Node, to destination: Node) -> Double? {
        guard let edges = adjacencyList[source] else { return nil }
        for edge in edges {
            if edge.destination == destination {
                return edge.value
            }
        }
        return nil
    }

    public func edges(from source: Node) -> [Edge] {
        return adjacencyList[source] ?? []
    }
}

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

    struct FlowNetwork {

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

        private var graph: Graph<UnassignedNodeInfo>
        private var source: Graph<UnassignedNodeInfo>.Node
        private var sink: Graph<UnassignedNodeInfo>.Node
        private var internalNodes: [Graph<UnassignedNodeInfo>.Node] = []

        init(_ pitchClasses: Set<Pitch.Class>, parsimonyPivot: Pitch.Class = 2) {

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
        }
    }
}


extension Graph: CollectionWrapping {
    public var base: [Node: [Edge]] {
        return adjacencyList
    }
}

extension Graph: CustomStringConvertible {
    public var description: String {
        var result = ""
        for (source, edges) in adjacencyList {
            let destinations = edges.map { "\($0.destination.value)" }
            result += "\(source.value) -> [\(destinations.joined(separator: ","))]"
            result += "\n"
        }
        return result
    }
}
