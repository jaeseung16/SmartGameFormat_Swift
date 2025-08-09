//
//  SGFNumber.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/9/25.
//

public struct SGFNumber: SGFProperty {

    public var usesList: Bool { false }
    public var allowsEmptyList: Bool { false }
    
    public typealias Element = Int
    
    public var value: Int?
    
    public var values: [Int] {
        return value == nil ? [] : [value!]
    }
    
    private var context: SGFContext?
    
    public init(values: [String], context: SGFContext? = nil) {
        guard values.count == 1, let doubleValue = Double(values[0]) else {
            fatalError(#function + ": Invalid initializer argument: \(values)")
        }
        self.value = Int(doubleValue)
        self.context = context
    }
    
    public func serialize() -> [String] {
        return value == nil ? [] : ["\(value!)"]
    }
}
