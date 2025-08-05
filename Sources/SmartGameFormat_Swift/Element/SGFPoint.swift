//
//  SGFPoint.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/5/25.
//

public struct SGFPoint: Hashable {
    public let row: Int
    public let col: Int
    
    public static func from(_ rawValue: String, in size: Int) -> SGFPoint {
        if rawValue == "" || rawValue == "tt" {
            return SGFPoint(row: -1, col: -1)
        }
        
        let point = Array(rawValue.utf16)
        let col = Int(point[0]) - 97
        let row = size - Int(point[1]) + 96
        return SGFPoint(row: row, col: col)
    }
    
    static public let pass: SGFPoint = SGFPoint(row: -1, col: -1)
    
    public var isPass: Bool {
        return self == SGFPoint.pass
    }
}
