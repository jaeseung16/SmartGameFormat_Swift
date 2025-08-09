//
//  SGFMove.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/9/25.
//

public struct SGFMove: SGFProperty {

    public var usesList: Bool { true }
    public var allowsEmptyList: Bool { false }
    
    public typealias Element = SGFPoint
    public var value: SGFPoint?
    
    public var values: [SGFPoint] {
        return value == nil ? [] : [value!]
    }
 
    private var context: SGFContext
    
    public init(values: [String], context: SGFContext) {
        guard values.count == 1 else {
            fatalError(#function + ": Invalid initializer argument: \(values)")
        }
        
        self.value = SGFPoint.from(values[0], in: context.size)
        self.context = context
    }
    
    public func serialize() -> [String] {
        return value == nil ? [] : [context.serialize(point: value!)]
    }
}
