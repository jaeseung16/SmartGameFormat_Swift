//
//  SGFARLNList.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/9/25.
//

public struct SGFARLNList: SGFProperty {

    public var usesList: Bool { true }
    public var allowsEmptyList: Bool { false }
    
    public typealias Element = (SGFPoint, SGFPoint)
    public var value: (SGFPoint, SGFPoint)? {
        return nil
    }
    
    public var values: [(SGFPoint, SGFPoint)] {
        return pointPairs
    }
    
    private var context: SGFContext
    private var pointPairs: [(SGFPoint, SGFPoint)]
    
    public init(values: [String], context: SGFContext) {
        guard !values.isEmpty else {
            fatalError(#function + ": Invalid initializer argument: \(values)")
        }
        
        var pointPairs: [(SGFPoint, SGFPoint)] = []
        for value in values {
            if let match = value.firstMatch(of: regex) {
                let point1 = SGFPoint.from(String(match.output.1), in: context.size)
                let point2 = SGFPoint.from(String(value[match.range.upperBound...]), in: context.size)
                pointPairs.append((point1, point2))
            }
        }
        self.pointPairs = pointPairs
        
        self.context = context
    }
    
    private let regex = /((?:[^\\:]|\\.)*):/

    public func serialize() -> [String] {
        var result: [String] = []
        for pointPair in pointPairs {
            let point1String = context.serialize(point: pointPair.0)
            let point2String = context.serialize(point: pointPair.1)
            result.append("\(point1String):\(point2String)")
        }
        return result
    }
    
}
