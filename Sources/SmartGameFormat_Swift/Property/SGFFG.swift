//
//  SGFFG.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/9/25.
//

public struct SGFFG: SGFProperty {
    
    public var usesList: Bool { false }
    public var allowsEmptyList: Bool { false }
    
    public typealias Element = (Int, String)
    
    public var value: (Int, String)? {
        return flag == nil ? nil : (flag!, self.name ?? "")
    }
    
    public var values: [(Int, String)] {
        return value == nil ? [] : [value!]
    }
    
    private var context: SGFContext
    public var flag: Int?
    public var name: String?
    
    public init(values: [String], context: SGFContext) {
        guard values.count == 1 else {
            fatalError(#function + ": Invalid initializer argument: \(values)")
        }
        
        let value = values[0]
        
        if let match = value.firstMatch(of: regex) {
            self.flag = Int(String(match.output.1))
            self.name = String(value[match.range.upperBound...]) // TODO: - simpleText
        }
        
        self.context = context
    }
    
    private let regex = /((?:[^\\:]|\\.)*):/
    
    public func serialize() -> [String] {
        guard let flag = flag, let name = name else {
            return [""]
        }
        return ["\(flag):\(context.escape(text: name))"]
    }
}
