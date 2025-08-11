//
//  SGFGame.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/9/25.
//

import Foundation
import Logging

public class SGFGame {
    
    private static let logger = Logger(label: "SGFGame")
    
    public static func from(string: String, encoding: String.Encoding = .isoLatin1) -> SGFGame? {
        if let coarseGameTree = SGFGrammar().parse(sgf: string) {
            return from(coarseGameTree: coarseGameTree, encoding: encoding)
        } else {
            return nil
        }
    }
    
    public static func from(coarseGameTree: CoarseGameTree, encoding: String.Encoding = .isoLatin1) -> SGFGame? {
        if let size = coarseGameTree.sequence[0]["SZ"]?[0] {
            
            // Determine encoding to use for property values
            var encodingToUse: String.Encoding = encoding
            if let charsetName = coarseGameTree.sequence[0]["CA"]?.first,
               let encodingSpecified = stringEncoding(from: charsetName),
               encodingSpecified != encoding {
                encodingToUse = encodingSpecified
            }
            
            let sgfGame = SGFGame(size: Int(size)!, encoding: encodingToUse)
            sgfGame.root = SGFUnexpandedRootNode(owner: sgfGame, coarseGameTree: coarseGameTree).expand()
            return sgfGame
        } else {
            return nil
        }
    }
    
    private static func stringEncoding(from charsetName: String) -> String.Encoding? {
        let cfStringEncoding = CFStringConvertIANACharSetNameToEncoding(charsetName as CFString)
        let nsStringEndoding = CFStringConvertEncodingToNSStringEncoding(cfStringEncoding)
        return String.Encoding(rawValue: nsStringEndoding)
    }
    
    public let size: Int
    public let context: SGFContext
    public var root: SGFNode?
    public var encoding: String.Encoding
    
    public init(size: Int, encoding: String.Encoding = .utf8) {
        self.size = size
        self.context = SGFContext(size: size, encoding: encoding)
        self.encoding = encoding
        
        self.root = SGFRootNode(propertyMap: [:], context: self.context, owner: self)
        self.root?.set(propertyFor: .FF, to: SGFPropertyFactory.create(identifier: .FF, values: ["4.0"], context: self.context)!)
        self.root?.set(propertyFor: .GM, to: SGFPropertyFactory.create(identifier: .GM, values: ["1"], context: self.context)!)
        self.root?.set(propertyFor: .SZ, to: SGFPropertyFactory.create(identifier: .SZ, values: ["\(size)"], context: self.context)!)
        
        // TODO: - We haven't read the encoding specified in the file?
        // This will be replaced
        // Need to distinguish between encoding used to read the entire file vs encoding specified as CA
        self.root?.set(propertyFor: .CA, to: SGFPropertyFactory.create(identifier: .CA, values: ["\(context.encoding)"], context: self.context)!)
    }
    
    public func serialize(wrap: Int = 79) -> String {
        var result = ""
        if let root = root {
            let coarseGameTree = CoarseGameTree.make(root: root)
            result = CoarseGameTree.serialize(coarseGameTree)
        }
        return result
    }
    
    public var charset: String? {
        if let charset = root?.get(valueFor: "CA") {
            let encoding = String.availableStringEncodings
                .map { String.localizedName(of: $0) }
                .filter { $0.lowercased().contains(charset.lowercased()) }
                .first
            return encoding
        }
        return String.localizedName(of: .isoLatin1)
    }
    
    public var lastNode: SGFNode? {
        var result = root
        while result != nil {
            result = result?.children.first
        }
        return result
    }
    
    public var mainSequence: [SGFNode] {
        var result = [SGFNode]()
        if let root = root {
            var node = root
            result.append(node)
            while !node.children.isEmpty {
                node = node.children.first!
                result.append(node)
            }
        }
        return result
    }
    
    public func mainSequence(below node: SGFNode) -> [SGFNode] {
        guard node.owner === self else {
            SGFGame.logger.warning("called with node not belonging to this game: \(String(describing: node))")
            return []
        }
        var result = [SGFNode]()
        var currentNode = node
        while !currentNode.children.isEmpty {
            currentNode = currentNode.children.first!
            result.append(currentNode)
        }
        return result
    }
    
    public func sequence(above node: SGFNode) -> [SGFNode] {
        guard node.owner === self else {
            SGFGame.logger.warning("called with node not belonging to this game: \(String(describing: node))")
            return []
        }
        var result = [SGFNode]()
        var currentNode = node
        while currentNode.parent != nil {
            currentNode = currentNode.parent!
            result.append(currentNode)
        }
        return result.reversed()
    }
    
    public func extendMainSequence() -> SGFNode? {
        return lastNode?.create(childAt: nil)
    }
    
    public var komi: Double? {
        if let komi = root?.get(valueFor: "KM") {
            return Double(komi)
        }
        return 0.0
    }
    
    public var handicap: Int? {
        if let handicapString = root?.get(valueFor: "HA"), let handicap = Int(handicapString), handicap > 1 {
            return handicap
        }
        return nil
    }
    
    public func playerName(_ color: String) -> String? {
        switch color {
        case "B":
            return root?.get(valueFor: "PB")
        case "W":
            return root?.get(valueFor: "PW")
        default:
            return nil
        }
    }
    
    public var winnner: String? {
        if let color = root?.get(valueFor: "RE"), color == "B" || color == "W" {
            return color
        }
        return nil
    }
    
    public func set(date: Date = Date()) -> Void {
        root?.set(propertyFor: "DT", to: date.formatted(.iso8601.year().month().day().dateSeparator(.dash)))
    }
    
}

extension SGFGame: Equatable {
    public static func == (lhs: SGFGame, rhs: SGFGame) -> Bool {
        return lhs === rhs
    }
}
