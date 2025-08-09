//
//  StoneList.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/7/25.
//

public struct SGFStoneList: SGFProperty {

    public var usesList: Bool { true }
    public var allowsEmptyList: Bool { false }
    
    public typealias Element = SGFPoint
    
    public var value: SGFPoint? {
        return nil
    }
    
    public var values: [SGFPoint]
    
    private var context: SGFContext
    
    public init(values: [String], context: SGFContext) {
        guard !values.isEmpty else {
            fatalError(#function + ": Invalid initializer argument: \(values)")
        }
        
        var result = [SGFPoint]()
        
        for value in values {
            if value.contains(":") {
                let points = value.split(separator: ":")
                let (top, left) = context.interpretAsPoint(String(points[0]))
                let (bottom, right) = context.interpretAsPoint(String(points[1]))
                
                guard bottom <= top && left <= right else {
                    fatalError(#function + ": Invalid initializer argument: \(value)")
                }
                
                for row in bottom...top {
                    for col in left...right {
                        result.append(SGFPoint(row: row, col: col))
                    }
                }
            } else {
                result.append(SGFPoint.from(value, in: context.size))
            }
        }
        
        self.values = result
        self.context = context
    }
    
    public func serialize() -> [String] {
        return values.map {
            context.serialize(point: $0)
        }.sorted { $0 < $1 }
    }
    
}



