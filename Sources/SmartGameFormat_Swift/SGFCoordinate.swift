//
//  SGFCoordinate.swift
//  Go
//
//  Created by Jae Seung Lee on 1/15/21.
//  Copyright © 2021 Jae Seung Lee. All rights reserved.
//

import Foundation

public enum SGFCoordinate: String, CaseIterable {
    case a, b, c, d, e, f, g, h, i, j, k, l, m,
         n, o, p, q, r, s, t, u, v, w, x, y, z,
         A, B, C, D, E, F, G, H, I, J, K, L, M,
         N, O, P, Q, R, S, T, U, V, W, X, Y, Z
    
    // From https://www.red-bean.com/sgf/go.html
    // The first letter designates the column (left to right), the second the row (top to bottom). The upper left part of the board is used for smaller boards, e.g. letters "a"-"m" for 13*13.
    // A pass move is shown as '[]' or alternatively as '[tt]' (only for boards <= 19x19), i.e. applications should be able to deal with both representations. '[tt]' is kept for compatibility with FF[3].
    // Using lowercase letters only the maximum board size is 26x26.
    // In FF[4] it is possible to specify board sizes upto 52x52. In this case uppercase letters are used to represent points from 27-52, i.e. 'a'=1 ... 'z'=26 , 'A'=27 ... 'Z'=52
    public func toNumber() -> Int {
        var count = 0
        for coordinate in SGFCoordinate.allCases {
            if self == coordinate {
                return count
            } else {
                count += 1
            }
        }
        return count
    }
    
    public static func toString(_ number: Int) -> String {
        var count = 0
        for coordinate in SGFCoordinate.allCases {
            if count == number {
                return coordinate.rawValue
            } else {
                count += 1
            }
        }
        return String()
    }
}
