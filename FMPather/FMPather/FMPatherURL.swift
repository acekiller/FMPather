//
//  FMPatherURL.swift
//  FMPather
//
//  实现对字符串URL编码操作处理
//
//  Created by Fantasy on 2017/9/15.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import Foundation

fileprivate extension String {
    
    fileprivate var appHost: String {
        return "\(String.appScheme)://\(String.appHost)"
    }
    
    fileprivate var isLocalFile: Bool {
        return ("file" == scheme) 
    }
    
    fileprivate func urlStringDecoding() -> String {
        return removingPercentEncoding ?? ""
    }
    
    fileprivate var urlEncoding: String {
        return urlStringDecoding().addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
    }
    
    private var isRelativePath: Bool {
        return (self.range(of: "://") != nil) ? false : true
    }
    
    private var fixedEncodingUrl: String {
        let urlString = urlEncoding
        if urlString.isRelativePath {
            return "\(appHost)\(urlString.hasPrefix("/") ? "" : "/")\(urlString))"
        }
        return urlEncoding
    }
    
    fileprivate var urlComponents: URLComponents? {
        return URLComponents(string: fixedEncodingUrl)
    }
}

public extension String {
    static var appScheme: String {
        let bundleIdentifier = (Bundle.main.infoDictionary)![kCFBundleIdentifierKey! as String] as! String
        return bundleIdentifier.components(separatedBy: ".").reversed().first!
    }
    
    static var appHost: String {
        let bundleIdentifier = (Bundle.main.infoDictionary)![kCFBundleIdentifierKey! as String] as! String
        let components = bundleIdentifier.components(separatedBy: ".").reversed().map{$0}
        return components[1..<components.count].joined(separator: ".")
    }
}

public extension String {
    
    public var asURL: URL? {
        return urlComponents?.url
    }
}

public extension String {
    public var scheme: String {
        return urlComponents?.scheme ?? ""
    }
    
    public var host: String {
        return urlComponents?.host ?? ""
    }
    
    public var port: Int? {
        return urlComponents?.port
    }
    
    public var pathComponents: [String] {
        return asURL?.pathComponents.filter({"/" != $0}) ?? []
    }
    
    public var lastPathComponent: String {
        return asURL?.lastPathComponent ?? ""
    }
    
    public var pathExtension: String {
        return asURL?.pathExtension ?? ""
    }
    
    public var querys: [String: String] {
        var items = [String: String]()
        guard let queryItems = urlComponents?.queryItems else {
            return items
        }
        
        for item in queryItems {
            items[item.name] = item.value
        }
        return items
    }
    
    public var isUrl: Bool {
        return nil == asURL ? false : true
    }
}
