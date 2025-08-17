//
//  SGFGrammar.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/5/25.
//

import Logging

public class SGFGrammar {
    
    private static let logger = Logger(label: "SGFGrammar")
    
    /*
    static func parse(sgf gameString: String, start position: Int = 0) -> SGFNode? {
        //tokens, end_position = tokenise(s, start_position)
    }
    */
    
    private let startRegex = /\(\s*;/
    private let tokenRegex = /\s*(?:\[(?P<V>[^\\\]]*(?:\\.[^\\\]]*)*)\]|(?P<I>[A-Z]{1,8})|(?P<D>[;()]))/
    private let properyIdentifierRegex = /\A[A-Z]{1,8}\Z/
    private let properyValueRegex = /\A[^\\\]]*(?:\\.[^\\\]]*)*\Z/
    
    public func isValidPropertyIdentifier(_ s: String) -> Bool {
        return s.contains(properyIdentifierRegex)
    }
    
    public func isValidPropertyValue(_ s: String) -> Bool {
        return s.contains(properyValueRegex)
    }
    
    public func tokenize(_ s: String, start position: Int = 0) -> ([(String, String)], Int) {
        guard let startMatch = s.firstMatch(of: startRegex) else {
            SGFGrammar.logger.warning("Input does not contain any game data: \(s)")
            return ([], 0)
        }
        
        let startIndex = startMatch.range.lowerBound.utf16Offset(in: s)
        let body = s[s.index(s.startIndex, offsetBy: startIndex)...]
        
        var depth = 0
        var index = 0
        var result: [(String, String)] = []
        while index < body.count {
            guard let match = body[body.index(body.startIndex, offsetBy: index)...].firstMatch(of: tokenRegex) else {
                SGFGrammar.logger.warning("No more matches at index=\(index)")
                break
            }
            
            let output = match.output
            
            if let popertyValue = output.V {
                result.append(("V", String(popertyValue)))
            }
            if let proprtyIndetifier = output.I {
                result.append(("I", String(proprtyIndetifier)))
            }
            if let delimiter = output.D {
                result.append(("D", String(delimiter)))
                if delimiter == "(" {
                    depth += 1
                } else if delimiter == ")" {
                    depth -= 1
                    if depth == 0 {
                        SGFGrammar.logger.warning("It seems like we reached the end of the game data at index=\(index)")
                        break
                    }
                }
            }
            
            index = match.range.upperBound.utf16Offset(in: body)
        }

        return (result, index)
    }
    
    public func parse(sgf gameString: String, start position: Int = 0) -> (CoarseGameTree?, Int?) {
        let (tokens, endPosition) = tokenize(gameString, start: position)
        
        if tokens.isEmpty {
            return (nil, nil)
        }
        
        var index = 0
        var stack = [CoarseGameTree]()
        var variation: CoarseGameTree? = nil
        var gameTree: CoarseGameTree? = nil
        var sequence: [[String: [String]]]? = nil
        var properties: [String: [String]]? = nil
        while true {
            let (tokenType, token) = tokens[index]
            index += 1
            if tokenType == "V" {
                fatalError("Unexpected token type: \(tokenType) \(token)")
            }
            if tokenType == "D" {
                if token == ";" {
                    if sequence == nil {
                        fatalError("Unexpected node")
                    }
                    if let properties = properties {
                        sequence?.append(properties)
                    }
                    properties = [:]
                } else {
                    if sequence != nil {
                        if let sequence = sequence, sequence.isEmpty {
                            gameTree?.sequence = [properties!]
                            variation = gameTree
                            SGFGrammar.logger.warning("sequence is empty: \(String(describing: variation))")
                            break
                        }
                        gameTree?.sequence = sequence!
                        sequence = nil
                    }
                    if token == "(" {
                        if let gameTree = gameTree {
                            stack.append(gameTree)
                        }
                        gameTree = CoarseGameTree()
                        sequence = []
                    } else {
                        variation = gameTree
                        gameTree = stack.popLast()
                        if gameTree == nil {
                            break
                        }
                        gameTree?.children.append(variation!)
                    }
                    properties = nil
                }
            } else {
                let propertyIdentifier = token
                var propertyValues = [String]()
                while true {
                    let (tokenType, token) = tokens[index]
                    if tokenType != "V" {
                        break
                    }
                    index += 1
                    propertyValues.append(token)
                }
                if propertyValues.isEmpty {
                    fatalError("property with no values")
                }
                if properties?[propertyIdentifier] != nil {
                    var values = properties?[propertyIdentifier]
                    values?.append(contentsOf: propertyValues)
                    properties?[propertyIdentifier] = values
                } else {
                    properties?[propertyIdentifier] = propertyValues
                }
            }
            
        }
        
        return (variation, endPosition)
    }
    
    public func parse(sgf gameString: String) -> CoarseGameTree? {
        let (sgfGame, _) = parse(sgf: gameString, start: 0)
        return sgfGame
    }
    
    public func get(mainSequenceOf coarseGameTree: CoarseGameTree) -> [[String: [String]]] {
        var result = [[String: [String]]]()
        var currentGameTree: CoarseGameTree? = coarseGameTree
        while currentGameTree != nil {
            result.append(contentsOf: currentGameTree!.sequence)
            print("children.count=\(currentGameTree!.children.count)")
            if currentGameTree!.children.isEmpty {
                currentGameTree = nil
            } else {
                currentGameTree = currentGameTree!.children[0]
            }
        }
        return result
    }
}
