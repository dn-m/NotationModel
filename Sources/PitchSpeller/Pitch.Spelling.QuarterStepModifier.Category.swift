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

    public struct AdjacencyList {

        public var edges: [Edge] {
            return values.flatMap { _, values in values }
        }

        public var nodes: [Node] {
            return values.map { node, _ in node }
        }

        private var values: [Node: [Edge]] = [:]

        mutating func createNode(_ value: Value) -> Node {
            let node = Node(value: value)
            if values[node] == nil {
                values[node] = []
            }
            return node
        }

        mutating func addEdge(from source: Node, to destination: Node, value: Double) {
            let edge = Edge(from: source, to: destination, value: value)
            values[source]?.append(edge)
        }

        func edgeValue(from source: Node, to destination: Node) -> Double? {
            guard let edges = values[source] else { return nil }
            for edge in edges {
                if edge.destination == destination {
                    return edge.value
                }
            }
            return nil
        }

        func edges(from source: Node) -> [Edge] {
            return values[source] ?? []
        }
    }

    public struct Node: Hashable {
        var value: Value
    }

    public struct Edge: Hashable {
        var source: Node
        var destination: Node
        var value: Double
        init(from source: Node, to destination: Node, value: Double) {
            self.source = source
            self.destination = destination
            self.value = value
        }
    }

    public var nodes: [Node] {
        return adjacencyList.nodes
    }

    public var edges: [Edge] {
        return adjacencyList.edges
    }

    private var adjacencyList = AdjacencyList()

    public init() { }

    public mutating func createNode(_ value: Value) -> Node {
        return adjacencyList.createNode(value)
    }

    public mutating func addEdge(from source: Node, to destination: Node, value: Double) {
        adjacencyList.addEdge(from: source, to: destination, value: value)
    }

    public func edgeValue(from source: Node, to destination: Node) -> Double? {
        return adjacencyList.edgeValue(from: source, to: destination)
    }

    public func edges(from source: Node) -> [Edge] {
        return adjacencyList.edges(from: source)
    }
}

extension Wetherfield {

    struct PitchSpeller {

        internal enum Category {

            internal struct TendencyPair: Equatable, Hashable {

                internal enum Tendency: Int {
                    case down = 0
                    case up = 1
                }

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
                tendency: (TendencyPair.Tendency,TendencyPair.Tendency)
            ) -> Pitch.Spelling.QuarterStepModifier?
            {
                return category(for: pitchClass)?[.init(tendency)]
            }
        }
    }

    struct FlowNetwork <Value> {

        struct NodeInfo: Hashable {

            /// The `pitchClass` which is being represented by a given `Node`.
            let pitchClass: Pitch.Class

            /// Index of the node in the `Box` for the given `pitchClass`. Will be either `0`, or
            /// `1`.
            let index: Int
        }

        var graph = Graph<NodeInfo>()

        mutating func makeGraph() {
            let c: Pitch.Class = 60
            let d: Pitch.Class = 62
            let gsharp: Pitch.Class = 68
            let info: [NodeInfo] = [c,d,gsharp].flatMap { pitchClass in
                return [0,1].map { index in
                    return NodeInfo(pitchClass: pitchClass, index: index)
                }
            }
            for nodeInfo in info {
                _ = graph.createNode(nodeInfo)
            }
        }
    }
}

extension Graph.AdjacencyList: CollectionWrapping {
    public var base: [Graph.Node: [Graph.Edge]] {
        return values
    }
}

extension Graph: CollectionWrapping {
    public var base: AdjacencyList {
        return adjacencyList
    }
}

extension Graph.AdjacencyList: CustomStringConvertible {
    public var description: String {
        var result = ""
        for (source, edges) in values {
            let destinations = edges.map { "\($0.destination.value)" }
            result += "\(source.value) -> [\(destinations.joined(separator: ","))]"
            result += "\n"
        }
        return result
    }
}

extension Graph: CustomStringConvertible {
    public var description: String {
        return adjacencyList.description
    }
}
