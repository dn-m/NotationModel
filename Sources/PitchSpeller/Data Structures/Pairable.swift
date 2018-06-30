//
//  Pairable.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 6/30/18.
//

protocol Pairable {
    associatedtype A
    associatedtype B
    var a: A { get }
    var b: B { get }
    var tuple: (A,B) { get }
    init(_ pair: (A,B))
    init(_ a: A, _ b: B)
}
