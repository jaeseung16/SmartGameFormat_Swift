//
//  SGFNode.swift
//  Go
//
//  Created by Jae Seung Lee on 1/7/21.
//  Copyright © 2021 Jae Seung Lee. All rights reserved.
//

import Foundation

public class SGFNode: CustomStringConvertible {
    public weak var parent: SGFNode?
    public var properties = [String: SGFProperty]()
    public var children = [SGFNode]()
    
    public var eldest: SGFNode {
        return children[0]
    }
    
    public var isRoot: Bool {
        return self.parent == nil
    }
    
    public init() {
    }
    
    public init(properties: [SGFProperty]) {
        properties.forEach { self.add(property: $0) }
    }
    
    public func add(child: SGFNode) {
        children.append(child)
        child.parent = self
    }
    
    public func remove(child: SGFNode) {
        var index = 0
        for k in 0..<children.count {
            if child == children[k] {
                break
            }
            index += 1
        }
        
        let removed = children.remove(at: index)
        removed.parent = nil
    }
    
    public func removeChildren() {
        for child in children {
            child.parent = nil
        }
        
        children.removeAll()
    }

    public func add(property: SGFProperty) -> Void {
        guard !properties.contains(where: { arg0 -> Bool in
            let (key, _) = arg0
            return key == property.id
        }) else {
            return
        }
        
        properties[property.id] = property
    }
    
    public func makeProperty(id: String, values: [String]) -> SGFProperty {
        return SGFProperty(id: id, values: values)
    }
    
    public var description: String {
        return "<SGFNode: parent = \(String(describing: parent)), properties = \(properties), childeren.count = \(children.count)"
    }
    
    public var sgfString: String {
        var text = ";"
        for property in properties {
            text += property.value.sgfString
        }
        return text
    }
}

extension SGFNode: Hashable {
    public static func == (lhs: SGFNode, rhs: SGFNode) -> Bool {
        return lhs.properties == rhs.properties
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(properties)
    }
}
