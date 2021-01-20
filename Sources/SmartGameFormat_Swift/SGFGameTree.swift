//
//  SGFGameTree.swift
//  Go
//
//  Created by Jae Seung Lee on 1/10/21.
//  Copyright © 2021 Jae Seung Lee. All rights reserved.
//

import Foundation

public class SGFGameTree: CustomStringConvertible {
    private var _rootNode: SGFNode?
    public var gameInfo: SGFGameInfo?
    
    public var rootNode: SGFNode {
        get {
            return _rootNode ?? SGFNode(properties: [SGFProperty]())
        }
        
        set {
            _rootNode = newValue
            var infos: [SGFToken: String] = [:]
            for property in newValue.properties {
                if SGFGameInfo.tokens.contains (property.value.name) {
                    infos[property.value.name] = property.value.values?[0] ?? String()
                }
            }
            gameInfo = SGFGameInfo(infos: infos)
        }
    }
    
    public var description: String {
        return "<SGFGameTree: \(String(describing: gameInfo))>"
    }
    
    public var sgfString: String {
        guard let rootNode = self._rootNode else {
            return String()
        }
        return "(\(rootNode.sgfString)\(sgfString(from: rootNode.children)))"
    }
    
    public func sgfString(from children: [SGFNode]) -> String {
        var text = ""
        if children.count == 1 {
            text += "\(children[0].sgfString)\(sgfString(from: children[0].children))"
        } else if children.count > 1 {
            for child in children {
                text += "(\(child.sgfString)\(sgfString(from: child.children)))"
            }
        }
        return text
    }
    
    public var main: [SGFNode] {
        var nodes = [SGFNode]()
        if _rootNode != nil {
            var currentNode = rootNode
            nodes.append(currentNode)
            while currentNode.children.count > 0 {
                nodes.append(currentNode.eldest)
                currentNode = currentNode.eldest
            }
        }
        return nodes
    }

}
