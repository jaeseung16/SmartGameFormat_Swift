//
//  File.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/9/25.
//

public enum SGFColor: String, SGFProperty {
    case black = "b"
    case white = "w"
    
    public var usesList: Bool { false }
    public var allowsEmptyList: Bool { false }
    
    public typealias Element = SGFColor
    
    public var value: SGFColor? {
        return self
    }
    
    public var values: [SGFColor] {
        return value == nil ? [] : [value!]
    }
    
    public static func from(_ values: [String]) -> SGFColor? {
        guard values.count == 1 else {
            fatalError(#function + ": Invalid initializer argument: \(values)")
        }
        return SGFColor(rawValue: values[0].lowercased())
    }
    
    public func serialize() -> [String] {
        if let value = value {
            return [ value.rawValue.uppercased() ]
        }
        return []
    }
}
