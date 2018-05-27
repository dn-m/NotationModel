//
//  Graph.swift
//  PitchSpeller
//
//  Created by James Bean on 5/24/18.
//

import StructureWrapping
import DataStructures

/// Minimal implementeation of a Directed Graph with Weighted (/ Capacious) Edges.
public struct Graph <Value: Hashable> {

    // TODO: Consider making own type which wraps `[Node]`
    public typealias Path = [Edge]

    /// Node in a `Graph`. Note that this is a value type. It is stored by its `hashValue`, thereby
    /// making its `Value` type `Hashable`. It is thus up to the user to make the wrapped value
    /// unique if the nature of the data is not necessarily unique.
    public struct Node: Hashable {
        var value: Value
    }

    /// Directed edge between two `Node` values.
    public struct Edge: Hashable {
        public let source: Node
        public let destination: Node
        public var value: Double
        public init(from source: Node, to destination: Node, value: Double) {
            self.source = source
            self.destination = destination
            self.value = value
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
    public mutating func createNode(_ value: Value) -> Node {
        let node = Node(value: value)
        if adjacencyList[node] == nil {
            adjacencyList[node] = []
        }
        return node
    }

    /// Add an edge from the given `source` to the given `destination` nodes, with the given
    /// `value` (i.e., weight, or capacity).
    public mutating func addEdge(from source: Node, to destination: Node, value: Double) {
        let edge = Edge(from: source, to: destination, value: value)
        adjacencyList.safelyAppend(edge, toArrayWith: source)
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
        let edges = nodes.map(makePath)
        return Set(edges)
    }

    /// - Returns: The path with the minimum number of edges between the given `source` and the
    /// given `destination`, if it is reachable. Otherwise, `nil`.
    public func shortestPath(from source: Node, to destination: Node) -> [Node]? {

        func backtrace(from history: [Node: Node]) -> [Node] {
            var result: [Node] = []
            var current: Node = destination
            while current != source {
                result.append(current)
                current = history[current]!
            }
            result.append(source)
            return Array(result.reversed())
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

    /// Create a `Path` from a given array of `nodes`.
    private func makePath(from nodes: [Node]) -> Path {
        return (nodes.startIndex ..< nodes.endIndex - 1).compactMap { index in
            let source = nodes[index]
            let destination = nodes[index + 1]
            return edgeValue(from: source, to: destination).map { value in
                Edge(from: source, to: destination, value: value)
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
