//
//  LBList.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/9/25.
//

public struct SGFLBList: SGFProperty {
    
    public var usesList: Bool { true }
    public var allowsEmptyList: Bool { false }
    
    public typealias Element = SGFLabel
    public var value: SGFLabel? {
        return nil
    }
    
    public var values: [SGFLabel]
    
    private var context: SGFContext
    
    public init(values: [String], context: SGFContext) {
        guard !values.isEmpty else {
            fatalError(#function + ": Invalid initializer argument: \(values)")
        }
        
        var result = [SGFLabel]()
        for value in values {
            if let match = value.firstMatch(of: regex) {
                let point = SGFPoint.from(String(match.output.1), in: context.size)
                let label = String(value[match.range.upperBound...])
                result.append(SGFLabel(point: point, label: label))
            }
        }
        
        self.values = result
        self.context = context
    }
    
    private let regex = /((?:[^\\:]|\\.)*):/

    public func serialize() -> [String] {
        return values.map {
            context.serialize(point: $0.point) + ":" + context.escape(text: $0.label)
        }
    }
    
}
