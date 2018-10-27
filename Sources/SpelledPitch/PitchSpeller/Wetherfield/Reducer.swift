//
//  Reducer.swift
//  SpelledPitch
//
//  Created by James Bean on 10/24/18.
//

import Algebra

struct Reducer <S,A>: Monoid {

    static var identity: Reducer {
        return .init { _, _ in return }
    }

    static func <> (lhs: Reducer, rhs: Reducer) -> Reducer {
        return Reducer { s,a in
            rhs.reduce(&s,a)
            lhs.reduce(&s,a)
        }
    }

    let reduce: (inout S, A) -> ()
}
