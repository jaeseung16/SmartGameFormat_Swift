//
//  SGFUnexpandedRootNode.swift
//  SmartGameFormat_Swift
//
//  Created by Jae Seung Lee on 8/6/25.
//

public class SGFUnexpandedRootNode: SGFRootNode {
    
    public let coarseGameTree: CoarseGameTree
    
    public init(owner: SGFGame, coarseGameTree: CoarseGameTree) {
        self.coarseGameTree = coarseGameTree
        super.init(propertyMap: coarseGameTree.sequence[0], context: owner.context, owner: owner)
    }
    
    public func getMainSequence() -> [SGFNode] {
        return SGFGrammar().get(mainSequenceOf: coarseGameTree)
            .map { SGFNode(owner: owner, properties: $0) }
    }
    
    public func expand() -> SGFNode {
        return CoarseGameTree.makeTree(
            gameTree: coarseGameTree,
            root: SGFRootNode(
                propertyMap: coarseGameTree.sequence[0],
                context: owner.context,
                owner: owner
            )
        )
    }
    
}
