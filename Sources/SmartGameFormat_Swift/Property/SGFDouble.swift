//
//  SGFDouble.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/9/25.
//

// Double values are used for annotation properties. They are called Double because the value is either simple or emphasized. A value of '1' means 'normal'; '2' means that it is emphasized.
public struct SGFDouble: SGFProperty {
    
    public var usesList: Bool { false }
    public var allowsEmptyList: Bool { false }
    
    public typealias Element = Int
    
    public var value: Int?
    
    public var values: [Int] {
        return value == nil ? [] : [value!]
    }
    
    private var context: SGFContext
    
    public init(values: [String], context: SGFContext) {
        guard values.count == 1 else {
            fatalError(#function + ": Invalid initializer argument: \(values)")
        }
        let trimmedValue = values[0].trimmingCharacters(in: .whitespaces)
        self.value = trimmedValue == "2" ? 2 : 1
        self.context = context
    }
    
    public func serialize() -> [String] {
        return [ value == 2 ? "2" : "1" ]
    }
}
