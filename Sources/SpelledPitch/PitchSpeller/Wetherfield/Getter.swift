//
//  Getter.swift
//  SpelledPitch
//
//  Created by James Bean on 10/24/18.
//

struct Getter<A, B> {
    let view: (A) -> B
}

extension Getter {
    init(_ keyPath: KeyPath<A,B>) {
        self.init { $0[keyPath: keyPath] }
    }
}

func compose <A,B,C> (_ lhs: Getter<A,B>, _ rhs: Getter<B,C>) -> Getter<A,C> {
    return .init { a in rhs.view(lhs.view(a)) }
}

func * <A,B,C> (lhs: Getter<A,B>, rhs: Getter<B,C>) -> Getter<A,C> {
    return compose(lhs,rhs)
}
