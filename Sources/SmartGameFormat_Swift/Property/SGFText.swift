//
//  SGFText.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/7/25.
//

public struct SGFText: SGFProperty {
    
    public var usesList: Bool { false }
    public var allowsEmptyList: Bool { false }
    
    public typealias Element = String
    
    public var value: String?
    
    public var values: [String] {
        return value == nil ? [] : [value!]
    }
    
    private var context: SGFContext
    
    public init(values: [String], context: SGFContext) {
        guard values.count == 1 else {
            fatalError(#function + ": Invalid initializer argument: \(values)")
        }
        self.value = SGFText.unescape(values[0])
        self.context = context
    }
    
    // TODO: - text vs. simpletext https://www.red-bean.com/sgf/sgf4.html#text
    private static func unescape(_ text: String) -> String {
        let newLineRegex = /\n\r|\r\n|\n|\r/
        let chunkRegex = /[^\n\\]+|[\n\\]/
        
        var temp = text
        temp.replace(newLineRegex, with: "\n")
        let temp2 = temp.replacingOccurrences(of: "\\t\\f\\v", with: "   ")
        var escaped = false
        
        var result = [String]()
        for chunk in temp2.matches(of: chunkRegex) {
            let output = String(chunk.output)
            if escaped {
                if output != "\\n" {
                    result.append(output)
                }
                escaped = false
            } else if output == "\\" {
                escaped = true
            } else {
                result.append(output)
            }
        }
        return result.joined()
    }
    
    public func serialize() -> [String] {
        return value == nil ? [""] : [context.escape(text: value!)]
    }
    
}

