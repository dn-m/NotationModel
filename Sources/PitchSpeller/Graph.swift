//
//  Graph.swift
//  PitchSpeller
//
//  Created by James Bean on 5/24/18.
//

import StructureWrapping

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
