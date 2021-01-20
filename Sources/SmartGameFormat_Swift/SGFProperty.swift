//
//  SGFProperty.swift
//  Go
//
//  Created by Jae Seung Lee on 1/10/21.
//  Copyright © 2021 Jae Seung Lee. All rights reserved.
//

import Foundation

public struct SGFProperty: CustomStringConvertible {
    public var id: String
    public var name: SGFToken
    public var values: [String]?
    
    public init() {
        id = SGFToken.NONE.rawValue
        name = SGFToken.NONE
    }
    
    public init(id: String, values: [String], name: String? = nil) {
        self.id = id
        self.name = (name == nil ? SGFToken(rawValue: id) : SGFToken(rawValue: name!)) ?? SGFToken.UNKNOWN
        self.values = values
    }
    
    public var description: String {
        return "<SGFProperty: id = \(id)), name = \(name), values = \(values ?? ["NONE"]))>"
    }
    
    public var sgfString: String {
        guard let values = self.values, !values.isEmpty else {
            return ""
        }
        
        var text = id
        
        for value in values {
            text += "[\(value)]"
        }
        
        return text
    }
}

extension SGFProperty: Hashable {
    public static func == (lhs: SGFProperty, rhs: SGFProperty) -> Bool {
        return (lhs.id == rhs.id) && (lhs.values == rhs.values)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(values)
    }
}
