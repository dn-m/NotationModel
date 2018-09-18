//
//  Bimap.swift
//  PitchSpeller
//
//  Created by James Bean on 6/9/18.
//

public struct Bimap <Key: Hashable, Value: Hashable>: Hashable {

    // MARK: - Instance Properties

    private var valueByKey = [Key: Value]()
    private var keyByValue = [Value: Key]()

    // MARK: - Initializers

    public init() { }

    public init(minimumCapacity: Int) {
        valueByKey = [Key: Value](minimumCapacity: minimumCapacity)
        keyByValue = [Value: Key](minimumCapacity: minimumCapacity)
    }

    public init(_ elements: Dictionary<Key, Value>) {
        for (k, value) in elements {
            self[key: k] = value
        }
    }

    public init<S:Sequence>(_ elements: S) where S.Iterator.Element == (Key, Value) {
        for (k, value) in elements {
            self[key: k] = value
        }
    }

    public var count: Int {
        return valueByKey.count
    }

    public var isEmpty: Bool {
        return valueByKey.isEmpty
    }

    public var keys: AnyCollection<Key> {
        return AnyCollection(valueByKey.keys)
    }

    public var values: AnyCollection<Value> {
        return AnyCollection(keyByValue.keys)
    }

    public subscript(value value: Value) -> Key? {
        get {
            return keyByValue[value]
        }
        set(newKey) {
            let oldKey = keyByValue.removeValue(forKey: value)
            if let oldKey = oldKey {
                valueByKey.removeValue(forKey: oldKey)
            }
            keyByValue[value] = newKey
            if let newKey = newKey {
                valueByKey[newKey] = value
            }
        }
    }

    public subscript(key key: Key) -> Value? {
        get {
            return valueByKey[key]
        }
        set {
            let oldValue = valueByKey.removeValue(forKey: key)
            if let oldValue = oldValue {
                keyByValue.removeValue(forKey: oldValue)
            }
            valueByKey[key] = newValue
            if let newValue = newValue {
                keyByValue[newValue] = key
            }
        }
    }

    @discardableResult
    public mutating func updateValue(_ value: Value, forKey key: Key) -> Value? {
        let previous = self[key: key]
        self[key: key] = value
        return previous
    }

    @discardableResult
    public mutating func removeValueForKey(_ key: Key) -> Value? {
        let previous = self[key: key]
        self[key: key] = nil
        return previous
    }

    @discardableResult
    public mutating func removeKeyForValue(_ value: Value) -> Key? {
        let previous = self[value: value]
        self[value: value] = nil
        return previous
    }

    public mutating func removeAll(keepCapacity keep: Bool = true) {
        keyByValue.removeAll(keepingCapacity: keep)
        valueByKey.removeAll(keepingCapacity: keep)
    }
}

extension Bimap: ExpressibleByDictionaryLiteral {

    // MARK: ExpressibleByDictionaryLiteral Protocol Conformance

    /// Constructs a bimap using a dictionary literal.
    public init(dictionaryLiteral elements: (Key, Value)...) {
        self.init(elements)
    }
}
