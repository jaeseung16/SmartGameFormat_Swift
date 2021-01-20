//
//  SGFDecoder.swift
//  Go
//
//  Created by Jae Seung Lee on 1/8/21.
//  Copyright © 2021 Jae Seung Lee. All rights reserved.
//

import Foundation

public class SGFParser {
    private static let gameTreeStart = "\\s*\\("
    private static let gameTreeEnd = "\\s*\\)"
    private static let gameTreeNext = "\\s*(;|\\(|\\))"
    private static let nodeContents = "\\s*([A-Za-z]+(?=\\s*\\[))"
    private static let propertyStart = "\\s*\\["
    private static let propertyEnd = "\\]"
    private static let escape = "\\\\"
    private static let lineBreak = "\\r\\n?|\\n\\r"
    
    var data: String
    var dataLen: Int
    var index: Int
    var gameTrees: [SGFGameTree]
    
    public init(_ data: String) {
        self.data = data
        self.dataLen = data.count
        self.index = 0
        self.gameTrees = [SGFGameTree]()
    }
    
    public func parse() throws -> Void {
        while self.index < self.dataLen {
            let gameTree = try self.parseOneGame()
            if gameTree != nil {
                self.gameTrees.append(gameTree!)
            } else {
                break
            }
        }
    }
    
    private func parseOneGame() throws -> SGFGameTree? {
        if self.index < self.dataLen {
            let reGameTreeStart = try NSRegularExpression(pattern: SGFParser.gameTreeStart)
            
            let match = reGameTreeStart.firstMatch(in: data, options: .anchored, range: NSMakeRange(self.index, self.dataLen - self.index))
    
            if match != nil {
                self.index = match!.range.upperBound
                let rootNode = try self.parseGameTree()
                let gameTree = SGFGameTree()
                gameTree.rootNode = rootNode
                return gameTree
            }
        }
        return nil
    }
    
    private func parseGameTree() throws -> SGFNode {
        var rootNode: SGFNode?
        var currentNode: SGFNode?
        while self.index < self.dataLen {
            let reGameTreeNext = try NSRegularExpression(pattern: SGFParser.gameTreeNext)
            let match = reGameTreeNext.firstMatch(in: data, options: .anchored, range: NSMakeRange(self.index, self.dataLen - self.index))
            
            if match != nil {
                self.index = match!.range.upperBound
                let matchedString = data[Range(match!.range(at: 1), in: data)!]
                
                switch matchedString {
                case ";":
                    let node = try self.parseNode()
                    if rootNode == nil {
                        rootNode = node
                        currentNode = node
                    } else {
                        currentNode!.add(child: node)
                        currentNode = node
                    }
                case "(":
                    let variations = try self.parseVariations()
                    variations.forEach { currentNode!.add(child: $0)}
                case ")":
                    return rootNode!
                default:
                    throw SGFParserError.GameTreeParseError("at \(self.index)")
                }
            } else {
                throw SGFParserError.GameTreeParseError("at \(self.index)")
            }
        }
        
        return rootNode!
    }
    
    private func parseVariations() throws -> [SGFNode] {
        let reGameTreeStart = try NSRegularExpression(pattern: SGFParser.gameTreeStart)
        let reGameTreeEnd = try NSRegularExpression(pattern: SGFParser.gameTreeEnd)
        
        var variations = [SGFNode]()
        while self.index < self.dataLen {
            let matchEnd = reGameTreeEnd.firstMatch(in: data, options: .anchored, range: NSMakeRange(self.index, self.dataLen - self.index))
     
            if matchEnd != nil {
                return variations
            }
            
            let node = try self.parseGameTree()
            if !node.properties.isEmpty {
                variations.append(node)
            }
            
            let matchStart = reGameTreeStart.firstMatch(in: data, options: .anchored, range: NSMakeRange(self.index, self.dataLen - self.index))

            if matchStart != nil {
                self.index = matchStart!.range.upperBound
            }
        }
        
        throw SGFParserError.EndOfDataParseError
    }
    
    private func parseNode() throws -> SGFNode {
        let node = SGFNode(properties: [SGFProperty]())
        
        while self.index < self.dataLen {
            let reNodeContents = try NSRegularExpression(pattern: SGFParser.nodeContents)
            let match = reNodeContents.firstMatch(in: data, options:.anchored, range: NSMakeRange(self.index, self.dataLen - self.index))
            
            if match != nil {
                self.index = match!.range.upperBound
                let propertyValueList = try self.parsePropertyValue()

                if !propertyValueList.isEmpty {
                    let id = data[Range(match!.range(at: 1), in: data)!]
                    let property = node.makeProperty(id: String(id), values: propertyValueList)
                    node.add(property: property)
                } else {
                    throw SGFParserError.NodePropertyParseError
                }
            } else {
                return node
            }
        }

        throw SGFParserError.EndOfDataParseError
    }
    
    private func parsePropertyValue() throws -> [String] {
        var propertyValueList = [String]()
        
        while self.index < self.dataLen {
            let rePropertyStart = try NSRegularExpression(pattern: SGFParser.propertyStart)
            let match = rePropertyStart.firstMatch(in: data, options: .anchored, range: NSMakeRange(self.index, self.dataLen - self.index))
            
            if match != nil {
                self.index = match!.range.upperBound
                var value = ""
                
                let rePropertyEnd = try NSRegularExpression(pattern: SGFParser.propertyEnd)
                let reEscape = try NSRegularExpression(pattern: SGFParser.escape)
                
                var matchEnd = rePropertyEnd.firstMatch(in: data, options: [], range: NSMakeRange(self.index, self.dataLen - self.index))
                var matchEscape = reEscape.firstMatch(in: data, options: [], range: NSMakeRange(self.index, self.dataLen - self.index))
                
                while matchEscape != nil && matchEnd != nil && (matchEscape!.range.upperBound < matchEnd!.range.upperBound) {
                    let matchedString = data[Range(NSMakeRange(self.index, matchEscape!.range.lowerBound - self.index), in:data)!]
                    value += matchedString
                    
                    let reLineBreak = try NSRegularExpression(pattern: SGFParser.lineBreak)
                    let matchBreak = reLineBreak.firstMatch(in: data, options: [], range: NSMakeRange( matchEscape!.range.upperBound, self.dataLen - matchEscape!.range.upperBound))
                    
                    if matchBreak != nil {
                        self.index = matchBreak!.range.upperBound
                    } else {
                        value += data[Range(NSMakeRange(matchEscape!.range.upperBound, 1), in: data)!]
                        self.index = matchEscape!.range.upperBound + 1
                    }
                    
                    matchEnd = rePropertyEnd.firstMatch(in: data, options: [], range: NSMakeRange(self.index, self.dataLen - self.index))
                    matchEscape = reEscape.firstMatch(in: data, options: [], range: NSMakeRange(self.index, self.dataLen - self.index))
                }
                
                if matchEnd != nil {
                    value += data[Range(NSMakeRange(self.index, matchEnd!.range.lowerBound - self.index), in: data)!]
                    self.index = matchEnd!.range.upperBound
                    propertyValueList.append(convertControlChars(value))
                } else {
                    throw SGFParserError.PropertyValueParseError
                }
            } else {
                break
            }
        }
        if propertyValueList.count >= 1 {
            return propertyValueList
        } else {
            throw SGFParserError.PropertyValueParseError
        }
    }
    
    private func convertControlChars(_ text: String) -> String {
        return text.map { character -> String in
            let singleCharacter = String(character)
            if SGFParser.escapingCharacters.contains(singleCharacter) {
                return " "
            } else {
                return singleCharacter
            }
        }.joined()
    }
    
    private static let escapingCharacters = ["\u{000}", "\u{001}", "\u{002}", "\u{003}", "\u{004}", "\u{005}", "\u{006}", "\u{007}",
                                    "\u{008}", "\u{009}", "\u{00B}", "\u{00C}", "\u{00E}", "\u{00F}",
                                    "\u{010}", "\u{011}", "\u{012}", "\u{013}", "\u{014}", "\u{015}", "\u{016}", "\u{017}",
                                    "\u{018}", "\u{019}", "\u{01A}", "\u{01B}", "\u{01C}", "\u{01D}", "\u{01E}", "\u{01F}"]
}


