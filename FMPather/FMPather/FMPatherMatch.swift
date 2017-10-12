//
//  FMPatherMatch.swift
//  FMPather
//
//  Created by Fantasy on 2017/9/16.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import Foundation

fileprivate extension String {
    fileprivate func isMatchRouterNode(by restfulNode: String,dynamic condition: String) -> Bool {
        if self.isEmpty || restfulNode.isEmpty {
            return false
        }
        if self.lowercased() == restfulNode.lowercased() {
            return true
        }
        
        if condition.isEmpty {
            return false
        }
        
        return restfulNode.isDynamic(dynamic: condition)
    }
}

public extension String {
    public func isMatchRouter(restfulPath: String, dynamic condition: String) -> Bool {
        guard pathComponents.count == restfulPath.pathComponents.count else {
            return false
        }
        
        return self.pathComponents.isMatched(by: restfulPath.pathComponents, dynamic: condition)
    }
    
    public func isDynamic(dynamic condition: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: condition,
                                             options: .caseInsensitive)
        let res = regex.firstMatch(in: self,
                                   options: .reportProgress,
                                   range: NSMakeRange(0,
                                                      self.characters.count))
        guard let result = res else {
            return false
        }
        return 0 == result.range.location && result.range.length == self.characters.count
    }
}

fileprivate extension Sequence where Iterator.Element == String {
    fileprivate func isMatched<OtherSequence>(by patternSequence:OtherSequence,
                          dynamic condition:String)
        -> Bool
        where
        OtherSequence : Sequence,
        OtherSequence.Iterator.Element == Self.Iterator.Element {
        return self.elementsEqual(patternSequence,
                                  by: { $0.isMatchRouterNode(by: $1, dynamic: condition) })
    }
}
