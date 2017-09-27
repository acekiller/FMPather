//
//  FMPatherPage.swift
//  FMPather
//
//  Created by Fantasy on 2017/9/20.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

public class FMPatherPage {
    fileprivate let restful: String
    fileprivate let restfulRegex: String
    fileprivate let builder: (FMPatherPage)->AnyObject
    public init(restful path: String,
                regex: String = ":[a-z,A-Z,0-9,_]+",
                builder:@escaping (FMPatherPage)->AnyObject)
    {
        restful = path
        restfulRegex = regex
        self.builder = builder
    }
    
    public func canMatch(for path: String) -> Bool {
        return path.isMatchRouter(restfulPath: restful,
                                  dynamic: restfulRegex)
    }
    
    public func matchedObject<T: NSObject>(path: String) -> T? {
        if !canMatch(for: path) {
            return nil
        }
        return builder(self) as? T
    }
}

extension FMPatherPage {
    func dynamicPathNode(for path: String) -> [String: String] {
        if !path.isMatchRouter(restfulPath: restful,
                               dynamic: restfulRegex) {
            return [:]
        }
        let pathNodes = path.pathComponents
        let patternNodes = restful.pathComponents
        let dNodes = patternNodes.flatMap {($0, pathNodes[patternNodes.index(of: $0)!])}
            .filter {
                [unowned self] in
                $0.0.isDynamic(dynamic: self.restfulRegex)
        }
        var result = [String: String]()
        dNodes.forEach {
            result[$0.0] = $0.1
        }
        return result
    }
}
