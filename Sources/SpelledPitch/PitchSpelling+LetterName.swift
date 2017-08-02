//
//  PitchSpelling+LetterName.swift
//  SpelledPitch
//
//  Created by James Bean on 5/3/16.
//
//

import Pitch

extension PitchSpelling {
    
    // MARK: - LetterName
    
    /**
     Letter name component of a `PitchSpelling`
     */
    public enum LetterName: String {
        
        // MARK: - Cases
        
        /// A, la.
        case a
        
        /// B, si.
        case b
        
        /// C, do.
        case c
        
        /// D, re.
        case d
        
        /// E, mi.
        case e
        
        /// F, fa.
        case f
        
        /// G, sol.
        case g
        
        // MARK: - Initializers
        
        /**
         Create a `LetterName` with a given `string` value. Uppercase and lowercase values are
         accepted here.
         */
        public init?(string: String) {
            switch string {
            case "a", "A": self = .a
            case "b", "B": self = .b
            case "c", "C": self = .c
            case "d", "D": self = .d
            case "e", "E": self = .e
            case "f", "F": self = .f
            case "g", "G": self = .g
            default: return nil
            }
        }

        /// Amount of steps from c
        public var steps: Int {
            switch self {
            case .c: return 0
            case .d: return 1
            case .e: return 2
            case .f: return 3
            case .g: return 4
            case .a: return 5
            case .b: return 6
            }
        }
        
        public var pitchClass: Double {
            switch self {
            case .c: return 0
            case .d: return 2
            case .e: return 4
            case .f: return 5
            case .g: return 7
            case .a: return 9
            case .b: return 11
            }
        }
    }
}
