//
//  Untitled.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/5/25.
//

public class CoarseGameTree {
    public var sequence: [[String: [String]]]
    public var children: [CoarseGameTree]
    
    init(sequence: [[String: [String]]] = [], children: [CoarseGameTree] = []) {
        self.sequence = sequence
        self.children = children
    }
    
    public static func makeTree(gameTree: CoarseGameTree, root: SGFNode) -> SGFNode {
        var toBuild = [(root, gameTree, 0)]
        while !toBuild.isEmpty {
            let (currentNode, currentTree, index) = toBuild.removeLast()
            if index < currentTree.sequence.count - 1 {
                let child = SGFNode(parent: currentNode, properties: currentTree.sequence[index+1])
                currentNode.append(child: child)
                toBuild.append((child, currentTree, index + 1))
            } else {
                currentNode.children = []
                for childTree in currentTree.children {
                    let child = SGFNode(parent: currentNode, properties: childTree.sequence[0])
                    currentNode.append(child: child)
                    toBuild.append((child, childTree, 0))
                }
            }
        }
        
        return root
    }
    
    public static func make(root: SGFNode) -> CoarseGameTree {
        let result = CoarseGameTree()
        var stack: [(CoarseGameTree, SGFNode)] = [(result, root)]
        
        while !stack.isEmpty {
            var children = [SGFNode]()
            var (currentTree, currentNode) = stack.removeLast()
            
            while true {
                currentTree.sequence.append(currentNode.rawProperties)
                children = currentNode.children
                if children.count != 1 {
                    break
                }
                currentNode = children[0]
            }
            
            for child in children {
                let childTree = CoarseGameTree()
                currentTree.children.append(childTree)
                stack.append((childTree, child))
            }
        }
        return result
    }
    
    public static func serialize(_ gameTree: CoarseGameTree, wrap: Int = 0) -> String {
        var lines = [String]()
        var stack: [CoarseGameTree?] = [gameTree]
        
        while !stack.isEmpty {
            guard let currentTree = stack.removeLast() else {
                lines.append(")")
                continue
            }
            
            lines.append("(")
            
            for properties in currentTree.sequence {
                lines.append(";")
                
                let sortedProperties = properties.sorted {
                    if $0.key == "FF" {
                        return true
                    }
                    if $1.key == "FF" {
                        return false
                    }
                    return $0.key < $1.key
                }
                
                for property in sortedProperties {
                    var propertyString = ["\(property.key)"]
                    for value in property.value {
                        propertyString.append("[\(value)]")
                    }
                    lines.append(propertyString.joined())
                }
            }
            
            stack.append(nil)
            stack.append(contentsOf: currentTree.children.reversed())
            
        }
        lines.append("\n")
        
        return wrap > 0 ? blockFormat(lines, wrap) : lines.joined()
    }
    
    public static func blockFormat(_ lines: [String], _ width: Int) -> String {
        var result = [String]()
        
        var blockedLine = ""
        for line in lines {
            if line.count + blockedLine.count > width {
                result.append(blockedLine)
                blockedLine = ""
            }
            blockedLine += line
        }
        
        if !blockedLine.isEmpty {
            result.append(blockedLine)
        }
        
        return result.joined(separator: "\n")
    }
    
}

extension CoarseGameTree: CustomStringConvertible {
    public var description: String {
        let sequenceDescription = sequence.map { item -> String in
            item.map { "\($0.key): \($0.value)" }.joined(separator: ", ")
        }.joined(separator: "\n")
        
        return "CoarseGameTree(sequence: \(sequenceDescription)\n  children: \(children.map(\.description).joined(separator: "\n"))"
    }
}
