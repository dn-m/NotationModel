//
//  Queue.swift
//  PitchSpeller
//
//  Created by James Bean on 5/29/18.
//

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
