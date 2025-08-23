//
//  SGFNode.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/6/25.
//

//
//  Untitled.swift
//  dlgo
//
//  Created by Jae Seung Lee on 6/26/25.
//

import Foundation
import Logging

public class SGFNode {
    
    static let logger = Logger(label: "SGFNode")
    
    public var owner: SGFGame
    public var parent: SGFNode?
    public var children: [SGFNode] = []
    
    private var context: SGFContext
    private var properties: [SGFPropertyIdentifier: any SGFProperty] = [:]
    private var nonStandardProperties: [String: [String]] = [:]
    
    public convenience init(parent: SGFNode, properties: [String: [String]]) {
        self.init(propertyMap: properties, context: parent.context, parent: parent, owner: parent.owner)
    }
    
    public convenience init(owner: SGFGame, properties: [String: [String]]) {
        self.init(propertyMap: properties, context: owner.context, owner: owner)
    }
    
    public init(propertyMap: [String: [String]], context: SGFContext, parent: SGFNode? = nil, owner: SGFGame) {
        self.context = context
        self.parent = parent
        self.owner = owner
        
        for (key, values) in propertyMap {
            guard let identifer = SGFPropertyIdentifier(rawValue: key) else {
                SGFNode.logger.warning("Unknown property key: \(key)")
                nonStandardProperties[key] = values
                continue
            }
            
            if identifer == .TM && !values.isEmpty && values[0] == "" {
                SGFNode.logger.warning("Missing TM value: \(values)")
                properties[identifer] = SGFPropertyFactory.create(identifier: identifer, values: ["-1"], context: context)
                continue
            }
            
            properties[identifer] = SGFPropertyFactory.create(identifier: identifer, values: values, context: context)
        }
    }
    
    public var size: Int {
        return context.size
    }
    
    public var encodingName: String.Encoding? {
        return context.encoding
    }
    
    public var length: Int {
        return children.count
    }
    
    public subscript(index: Int) -> SGFNode {
        return children[index]
    }
    
    public func index(of child: SGFNode) -> Int? {
        return children.firstIndex(of: child)
    }
    
    public var allPropertyKeys: [String] {
        var result = [String]()
        result.append(contentsOf: properties.keys.map{ $0.rawValue })
        result.append(contentsOf: nonStandardProperties.keys.map{ $0 })
        return result
    }
    
    public var rawProperties: [String: [String]] {
        var result = [String: [String]]()
        for property in properties {
            result[property.key.rawValue] = property.value.serialize()
        }
        for property in nonStandardProperties {
            result[property.key] = property.value
        }
        return result
    }
    
    public func has(propertyFor identifier: String) -> Bool {
        if let identifier = SGFPropertyIdentifier(rawValue: identifier) {
            return properties[identifier] != nil
        } else {
            return nonStandardProperties[identifier] != nil
        }
    }
    
    public func property(for identifier: String) -> (any SGFProperty)? {
        if let propertyIdentifier = SGFPropertyIdentifier(rawValue: identifier) {
            return properties[propertyIdentifier]
        } else if let property = nonStandardProperties[identifier] {
            return SGFText(values: property, context: context)
        } else {
            return nil
        }
    }
    
    public func get(valuesFor identifier: String) -> [String] {
        if let identifier = SGFPropertyIdentifier(rawValue: identifier) {
            return properties[identifier]?.serialize() ?? []
        } else {
            return nonStandardProperties[identifier] ?? []
        }
    }
    
    public func get(valueFor identifier: String) -> String? {
        if let identifier = SGFPropertyIdentifier(rawValue: identifier) {
            return properties[identifier]?.serialize().first
        } else {
            return nonStandardProperties[identifier]?.first
        }
    }
    
    // Find the nearest ancestor-or-self containing the specified property.
    public func search(nodeHaving identifier: String) -> SGFNode? {
        var node: SGFNode? = self
        while node != nil {
            if let node = node, node.has(propertyFor: identifier) {
                return node
            }
            node = node?.parent
        }
        return nil
    }
    
    // Return the value of a property, defined at this node or an ancestor.
    // This is intended for use with properties of type 'game-info', and with properties with the 'inherit' attribute.
    public func search(propertyFor identifier: String) -> String? {
        if let node = search(nodeHaving: identifier) {
            return node.get(valueFor: identifier)
        }
        return nil
    }
    
    public func remove(propertyFor identifier: String) {
        if let propertyIdentifier = SGFPropertyIdentifier(rawValue: identifier) {
            if propertyIdentifier == .SZ {
                SGFNode.logger.warning("Attempting to remove SZ property, which is not allowed.")
            }
            properties.removeValue(forKey: propertyIdentifier)
        } else {
            nonStandardProperties.removeValue(forKey: identifier)
        }
    }
    
    private func _set(_ identifier: String, to values: [String]) {
        if identifier == "SZ" && !values.isEmpty {
            if let size = Int(values[0]), size != context.size {
                SGFNode.logger.warning("changing size is not permitted")
            }
        }
        
        if let propertyIdentifier = SGFPropertyIdentifier(rawValue: identifier), let value = SGFPropertyFactory.create(identifier: propertyIdentifier, values: values, context: context) {
            set(propertyFor: propertyIdentifier, to: value)
        } else {
            nonStandardProperties[identifier] = values
        }
    }
    
    public func set(propertyFor identifier: SGFPropertyIdentifier, to value: any SGFProperty) {
        properties[identifier] = value
    }
    
    public func set(propertyFor identifier: String, to values: [String]) {
        guard SGFGrammar().isValidPropertyIdentifier(identifier) else {
            fatalError("ill-formed property identifier")
        }
        guard !values.isEmpty else {
            fatalError("empty property list")
        }
        
        for value in values {
            guard SGFGrammar().isValidPropertyValue(value) else {
                fatalError("ill-formed raw property value")
            }
        }
        _set(identifier, to: values)
    }
    
    public func set(propertyFor identifier: String, to value: String) {
        guard SGFGrammar().isValidPropertyIdentifier(identifier) else {
            fatalError("ill-formed property identifier")
        }
        guard SGFGrammar().isValidPropertyValue(value) else {
            fatalError("ill-formed raw property value")
        }
        _set(identifier, to: [value])
    }
    
    public var rawMove: (String?, String?) {
        if let values = properties[.B] {
            return (SGFColor.black.rawValue, values.serialize()[0])
        }
        if let values = properties[.W] {
            return (SGFColor.white.rawValue, values.serialize()[0])
        }
        return (nil, nil)
    }
    
    public func getMove() -> (String?, Int?, Int?) {
        let (colorStr, moveStr) = rawMove
        
        if let colorStr = colorStr, let moveStr = moveStr {
            let (row, col) = context.interpretAsPoint(moveStr)
            return (colorStr, row, col)
        } else {
            return (nil, nil, nil)
        }
    }
    
    // setup stones
    public func hasSetupStones() -> (Bool, Bool, Bool) {
        let (bp, wp, ep) = setupStones
        return (!bp.isEmpty, !wp.isEmpty, !ep.isEmpty)
    }
    
    public var setupStones: ([SGFPoint], [SGFPoint], [SGFPoint]) {
        let bp = points(for: .AB)
        let wp = points(for: .AW)
        let ep = points(for: .AE)
        return (bp, wp, ep)
    }
    
    private func points(for identifier: SGFPropertyIdentifier) -> [SGFPoint] {
        var result = [SGFPoint]()
        if let property = properties[identifier], let values = property.values as? [SGFPoint] {
            result.append(contentsOf: values)
        }
        return result
    }
    
    public var setupStonesStrings: ([String], [String], [String]) {
        let bp = properties[.AB]?.serialize() ?? []
        let wp = properties[.AW]?.serialize() ?? []
        let ep = properties[.AE]?.serialize() ?? []
        return (bp, wp, ep)
    }
    
    public func set(setupStones black: [(Int, Int)], white: [(Int, Int)], empty: [(Int, Int)]) {
        let bp = black.map { context.serialize(point: $0) }
        let wp = white.map { context.serialize(point: $0) }
        let ep = empty.map { context.serialize(point: $0) }
        
        properties[.AB] = SGFPropertyFactory.create(identifier: .AB, values: bp, context: context)
        properties[.AW] = SGFPropertyFactory.create(identifier: .AB, values: wp, context: context)
        properties[.AE] = SGFPropertyFactory.create(identifier: .AE, values: ep, context: context)
    }
    
    
    // setMove
    public func set(moveFor color: String, row: Int, col: Int) {
        if let sgfColor = SGFColor(rawValue: color) {
            _set(sgfColor.rawValue, to: [context.serialize(point: SGFPoint(row: row, col: col))])
        } else {
            SGFNode.logger.warning("can not set move for unknown color: \(color)")
        }
    }
    
    public func append(comment: String) -> Void {
        var newComment = comment
        if let currentValue = properties[.C] as? SGFText, let currentComment = currentValue.value {
            newComment = currentComment + "\n\n" + comment
        }
        if let newValue = SGFPropertyFactory.create(identifier: .C, values: [newComment], context: context) {
            set(propertyFor: .C, to: newValue)
        }
    }
    
    public func append(child: SGFNode) {
        children.append(child)
    }
    
    public func create(childAt index: Int? = nil) -> SGFNode {
        let newChild = SGFNode(parent: self, properties: [:])
        if let index = index {
            children.insert(newChild, at: index)
        } else {
            children.append(newChild)
        }
        return newChild
    }
    
    public func removeFromParent() -> Void {
        if let parent = parent {
            parent.children.removeAll { $0 === self }
            self.parent = nil
        }
    }
    
    // TODO: - throw?
    public func set(newParent: SGFNode, at index: Int? = nil) -> Void {
        guard newParent.owner != owner else {
            SGFNode.logger.warning("new parent doesn't belong to the same game")
            return
        }
        
        var np = newParent
        while true {
            if np === self {
                fatalError("would create a loop")
            }
            if np.parent == nil {
                break
            } else {
                np = np.parent!
            }
        }
        
        removeFromParent()
        parent = newParent
        if let index = index {
            newParent.children.insert(self, at: index)
        } else {
            newParent.children.append(self)
        }
    }
    
}

extension SGFNode: Equatable {
    public static func == (lhs: SGFNode, rhs: SGFNode) -> Bool {
        return lhs === rhs
    }
}

extension SGFNode: CustomDebugStringConvertible {
    public var debugDescription: String {
        return rawProperties.map {
            "\($0.key): \($0.value)"
        }.joined(separator: ", ")
    }
}
