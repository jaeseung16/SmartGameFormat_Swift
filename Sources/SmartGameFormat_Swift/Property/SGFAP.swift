//
//  SGFAP.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/9/25.
//

public struct SGFAP: SGFProperty {
    public var usesList: Bool { false }
    public var allowsEmptyList: Bool { false }
    
    public typealias Element = String
    public var value: String? {
        return version
    }
    public var values: [String] {
        return version == nil ? [] : [version!]
    }
    
    private var context: SGFContext
    private var application: String?
    private var version: String?
    
    public init(values: [String], context: SGFContext) {
        guard values.count == 1 else {
            fatalError(#function + ": Invalid initializer argument: \(values)")
        }
       
        let value = values[0]
        
        if let match = value.firstMatch(of: regex) {
            self.application = String(match.output.1)
            self.version = String(value[match.range.upperBound...])
        }
        
        self.context = context
    }
    
    private let regex = /((?:[^\\:]|\\.)*):/

    public func serialize() -> [String] {
        return application == nil && version == nil ? [""] : [context.escape(text: application ?? "") + ":" + (version ?? "")]
    }
    
}
