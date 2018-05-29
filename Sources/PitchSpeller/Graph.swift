//
//  Graph.swift
//  PitchSpeller
//
//  Created by James Bean on 5/24/18.
//

import StructureWrapping
import DataStructures

/// Minimal implementeation of a Directed Graph with Weighted (/ Capacious) Edges.
public struct Graph <Value: Hashable>: Hashable {

    /// Node in a `Graph`. Note that this is a value type. It is stored by its `hashValue`, thereby
    /// making its `Value` type `Hashable`. It is thus up to the user to make the wrapped value
    /// unique if the nature of the data is not necessarily unique.
    public struct Node: Hashable {
        var value: Value
    }

    /// Directed edge between two `Node` values.
    ///
    /// - TODO: Consider making `value` generic, rather than `Double`. This would make it possible
    /// for a `Value` to be of any type (e.g., `Capacity`, `Weight`, etc.)
    public struct Edge: Hashable {

        // MARK: - Instance Properties

        public let source: Node
        public let destination: Node
        public var value: Double

        // MARK: - Initializers

        public init(from source: Node, to destination: Node, value: Double) {
            self.source = source
            self.destination = destination
            self.value = value
        }

        /// - Returns: An `Edge` with the value updated with by the given `transform`.
        public func map(_ transform: (Double) -> Double) -> Edge {
            return Edge(from: source, to: destination, value: transform(value))
        }
    }

    /// Path between nodes in a graph.
    public struct Path: Hashable {

        // MARK: - Instance Properties

        /// The `Graph.Edge` values contained herein.
        let edges: [Edge]

        // MARK: - Initializers

        /// Create a `Graph.Path` with the given array of `Edge` values.
        public init(_ edges: [Edge]) {
            self.edges = edges
        }

        /// - Returns: A `Path` with the values of each `Edge` updated with by the given `transform`.
        public func map(_ transform: (Double) -> Double) -> Path {
            return Path(edges.map { $0.map(transform) })
        }
    }

    // MARK: - Instance Properties

    /// - Returns: All of the `Edge` values in the `Graph`.
    public var edges: [Edge] {
        return adjacencyList.flatMap { _, values in values }
    }

    /// - Returns: All of the `Node` values in the `Graph`.
    public var nodes: [Node] {
        return adjacencyList.map { node, _ in node }
    }

    private var adjacencyList: [Node: [Edge]] = [:]

    // MARK: - Initializers

    public init() { }

    // MARK: - Insance Methods

    /// Create a `Node` with the given `value`. This node is placed in the `Graph`.
    ///
    /// - Note: Consider making `throw` if value already exists in the graph?
    public mutating func createNode(_ value: Value) -> Node {
        let node = Node(value: value)
        if adjacencyList[node] == nil {
            adjacencyList[node] = []
        }
        return node
    }

    /// Add an edge from the given `source` to the given `destination` nodes, with the given
    /// `value` (i.e., weight, or capacity).
    public mutating func insertEdge(from source: Node, to destination: Node, value: Double) {
        let edge = Edge(from: source, to: destination, value: value)
        insertEdge(edge)
    }

    /// Add an `Edge` if it does not currently exist. Otherwise, replaces the edge with the
    /// equivalent `source` and `destination` nodes.
    public mutating func insertEdge(_ edge: Edge) {
        removeEdge(from: edge.source, to: edge.destination)
        adjacencyList.safelyAppend(edge, toArrayWith: edge.source)
    }

    /// Removes the `Edge` which connects the given `source` and `destination` nodes, if present.
    public mutating func removeEdge(from source: Node, to destination: Node) {
        // FIXME: Consider more efficient and cleaner approach.
        adjacencyList[source] = adjacencyList[source]?.filter { $0.destination != destination }
    }

    /// Inserts the given `path`. Replaces nodes and edges if necessary.
    public mutating func insertPath(_ path: Path) {
        path.forEach { insertEdge($0) }
    }

    /// - Returns: The value (i.e., weight, or capacity) of the `Edge` directed from the given `source`,
    /// to the given `destination`, if the two given nodes are connected. Otherwise, `nil`.
    public func edgeValue(from source: Node, to destination: Node) -> Double? {
        guard let edges = adjacencyList[source] else { return nil }
        for edge in edges {
            if edge.destination == destination {
                return edge.value
            }
        }
        return nil
    }

    /// - Returns: All of the `Edge` values directed out from the given `node`.
    public func edges(from source: Node) -> [Edge] {
        return adjacencyList[source] ?? []
    }

    /// - Returns: All of the `Node` values adjacent to the given `node`.
    public func nodesAdjacent(to node: Node) -> [Node] {
        return edges(from: node).map { $0.destination }
    }

    /// - Returns: All of the paths from the given `source` to the given `destination`.
    public func paths(from source: Node, to destination: Node) -> Set<Path> {

        func paths(
            from source: Node,
            to destination: Node,
            visited: Set<Node>,
            currentPath: [Node],
            accum: Set<[Node]>
        ) -> Set<[Node]>
        {
            var visited = visited.inserting(source)
            var currentPath = currentPath
            var accum = accum

            // We have found a path!
            if source == destination {
                return accum.inserting(currentPath)
            }

            // Continue on from each node connected from this one.
            for adjacent in nodesAdjacent(to: source) {
                if !visited.contains(adjacent) {
                    currentPath.append(adjacent)
                    accum.formUnion(
                        paths(
                            from: adjacent,
                            to: destination,
                            visited: visited,
                            currentPath: currentPath,
                            accum: accum
                        )
                    )
                    currentPath.removeLast()
                }
            }
            visited.remove(source)
            return accum
        }

        let nodes = paths(from: source, to: destination, visited: [], currentPath: [source], accum: [])

        // FIXME: Refactor
        let edges = nodes.map(makePath)
        return Set(edges)
    }

    /// - Returns: The path with the minimum number of edges between the given `source` and the
    /// given `destination`, if it is reachable. Otherwise, `nil`.
    public func shortestPath(from source: Node, to destination: Node) -> Path? {

        /// In the process of breadth-first searching, each node is stored as a key in a dictionary
        /// with its predecessor as its associated value. Follow this line back to the beginning in
        /// order to reconstitute the path travelled.
        func backtrace(from history: [Node: Node]) -> Path {
            var result: [Node] = []
            var current: Node = destination
            while current != source {
                result.append(current)
                current = history[current]!
            }
            result.append(source)
            return makePath(from: Array(result.reversed()))
        }

        // Maps each visited node to its predecessor, which is then backtraced to reconstitute
        // the path travelled.
        var history: [Node: Node] = [:]
        var queue: Queue<Node> = []

        queue.push(source)

        while !queue.isEmpty {
            let node = queue.pop()
            if node == destination {
                return backtrace(from: history)
            }
            for adjacent in nodesAdjacent(to: node) where !history.keys.contains(adjacent) {
                queue.push(adjacent)
                history[adjacent] = node
            }
        }

        // `destination` is not reachable by `source`.
        return nil
    }

    private func edges(_ nodes: [Node]) -> [Edge] {
        return (nodes.startIndex ..< nodes.endIndex - 1).compactMap { index in
            let source = nodes[index]
            let destination = nodes[index + 1]
            return edgeValue(from: source, to: destination).map { value in
                Edge(from: source, to: destination, value: value)
            }
        }
    }

    /// Create a `Path` from a given array of `nodes`.
    private func makePath(from nodes: [Node]) -> Path {
        return Path(edges(nodes))
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

extension Graph.Path: ExpressibleByArrayLiteral {

    /// Create a `Graph.Path` with an array literal of `Graph.Edge` values.
    public init(arrayLiteral elements: Graph.Edge...) {
        self.edges = elements
    }
}

extension Graph.Path: CollectionWrapping {
    public var base: [Graph.Edge] {
        return edges
    }
}
