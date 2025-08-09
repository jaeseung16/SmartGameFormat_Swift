//
//  SGFProperty.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/7/25.
//

public protocol SGFProperty {
    associatedtype Element
    
    var value: Element? { get }
    var values: [Element] { get }
    
    var usesList: Bool { get }
    var allowsEmptyList: Bool { get }
    
    func serialize() -> [String]
}
