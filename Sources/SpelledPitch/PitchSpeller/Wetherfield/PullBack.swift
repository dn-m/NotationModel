//
//  PullBack.swift
//  SpelledPitch
//
//  Created by James Bean on 10/24/18.
//

import DataStructures

struct PullBack <A,B,C,P,Q> where
    P: SymmetricPair & Hashable,
    Q: SymmetricPair & Hashable,
    P.A == A,
    Q.B == B
{
    let map: (Q) -> C?
    let lensOnIndex: Getter<A, B>

    func retrieve(for p: P) -> C {
        return map(Q(lensOnIndex.view(p.a), lensOnIndex.view(p.b)))!
    }
}
