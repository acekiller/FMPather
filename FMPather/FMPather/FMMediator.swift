//
//  FMMediator.swift
//  FMPather
//
//  Created by Fantasy on 2017/9/20.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

public class FMMediator: Hashable {
    
    fileprivate var pages = [FMPatherPage]()
    let scheme: String
    let host: String
    let regex: String
    
    public init(scheme: String, host:String, regex: String = ":[a-z,A-Z,0-9,_]+") {
        self.scheme = scheme
        self.host = host
        self.regex = regex
    }
    
    func patherPage(for path: String) -> FMPatherPage? {
        return self.pages.filter{ $0.canMatch(for: path)}.first
    }
}

public extension FMMediator {
    public func registerRestful(restfulPath: String,
                                builder: @escaping (FMPatherPage)->AnyObject)
        -> FMPatherError
    {
        if restfulPath.scheme != scheme {
            return .invalidClass
        }
        if restfulPath.host != host {
            return .invalidHost
        }
        let page = FMPatherPage(restful: restfulPath,
                                regex: regex,
                                builder: builder)
        self.pages.append(page)
        return .success
    }
    
    public func containPage(for path: String) -> Bool {
        if path.scheme != scheme || path.host != host {
            return false
        }
        return self.pages.contains {
            return $0.canMatch(for: path)
        }
    }

    public func object(for path:String) -> AnyObject? {
        return patherPage(for: path)?.matchedObject(path: path)
    }
    
    public func controller(for path: String) -> AnyObject? {
        return object(for: path)
    }
    
    public var hashValue: Int {
        return self.scheme.hashValue ^ self.host.hashValue
    }
    
}

public extension FMMediator {
    
    func dynamicPathComponents(for path: String) -> [String: String] {
        return patherPage(for: path)?.dynamicPathNode(for:path) ?? [:]
    }
    
    func querys(for path: String) -> [String: String] {
        return path.querys
    }
}

public func ==(lhs: FMMediator, rhs: FMMediator) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
