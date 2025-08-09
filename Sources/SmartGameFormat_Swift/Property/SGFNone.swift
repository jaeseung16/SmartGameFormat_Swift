//
//  SGFNone.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/9/25.
//

public struct SGFNone: SGFProperty {
    
    public var usesList: Bool { false }
    public var allowsEmptyList: Bool { false }
    
    public typealias Element = String
    
    public var value: String? {
        return ""
    }
    
    public var values: [String] {
        return [""]
    }
    
    public var context: SGFContext
    
    public func serialize() -> [String] {
        return [""]
    }
    
}
