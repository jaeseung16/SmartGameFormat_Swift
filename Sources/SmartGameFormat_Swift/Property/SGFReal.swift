//
//  SGFReal.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/7/25.
//

import Foundation

public struct SGFReal: SGFProperty {
    
    public var usesList: Bool { false }
    public var allowsEmptyList: Bool { false }
    
    public typealias Element = Double
    
    public var value: Double?
    
    public var values: [Double] {
        return value == nil ? [] : [value!]
    }
    
    private var context: SGFContext
    
    public init(values: [String], context: SGFContext) {
        guard values.count == 1, let value = Double(values[0]), !value.isInfinite && !value.isNaN else {
            fatalError(#function + ": Invalid initializer argument: \(values)")
        }
        
        self.value = value
        self.context = context
    }
    
    public func serialize() -> [String] {
        if let value = value {
            if value.truncatingRemainder(dividingBy: 1) == 0 {
                return [ IntegerFormatStyle().format(Int(value)) ]
            } else {
                let stringValue = "\(value)"
                return [ stringValue.contains("e-") ? "0" : stringValue ]
            }
        }
        return [""]
    }
}
