//
//  SGFCoordinate.swift
//  Go
//
//  Created by Jae Seung Lee on 1/15/21.
//  Copyright © 2021 Jae Seung Lee. All rights reserved.
//

import Foundation

public enum SGFCoordinate: String, CaseIterable {
    case a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s
    
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
