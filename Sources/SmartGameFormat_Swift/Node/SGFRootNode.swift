//
//  SGFRootNode.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/6/25.
//

public class SGFRootNode: SGFNode {
    
    public init(propertyMap: [String: [String]], context: SGFContext, owner: SGFGame) {
        super.init(propertyMap: propertyMap, context: context, parent: nil, owner: owner)
    }
    
}
