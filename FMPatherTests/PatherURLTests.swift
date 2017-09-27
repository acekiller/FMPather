//
//  PatherURLEncoding.swift
//  FMPather
//
//  Created by Fantasy on 2017/9/16.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import XCTest

class PatherURLEncoding: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testURLParams() {
        let httppath  = "https://yiqijiao.cn/app/api/中文/users?id=23241234&name=冯锡君"
        let filepath = Bundle.main.bundleURL.absoluteString
        let custompath = "demo://yiqijiao.cn/app/api/中文/users?id=23241234&name=冯锡君"
        httppath.asURL != nil ? {}() : XCTFail("http encoding failed")
        filepath.asURL != nil ? {}() : XCTFail("http encoding failed")
        custompath.asURL != nil ? {}() : XCTFail("http encoding failed")
        
    }
    
    func testURLEncoding() {
        let httppath  = "https://yiqijiao.cn/app/api/中文/users?id=23241234&name=冯锡君"
        let filepath = Bundle.main.bundleURL.absoluteString
        let custompath = "demo://yiqijiao.cn/app/api/中文/users?id=23241234&name=冯锡君"
        let relativePath1 = "app/api/dev"
        let relativePath2 = "/app/api/dev"
        httppath.asURL != nil ? {debugPrint("httppath.asURL : \(httppath.asURL!)")}() : XCTFail("http encoding failed with httppath")
        filepath.asURL != nil ? {debugPrint("filepath.asURL : \(filepath.asURL!)")}() : XCTFail("http encoding failed with filepath")
        custompath.asURL != nil ? {debugPrint("custompath.asURL : \(custompath.asURL!)")}() : XCTFail("http encoding failed with custompath")
        relativePath1.asURL != nil ? {debugPrint("relativePath1.asURL : \(relativePath1.asURL!)")}() : XCTFail("http encoding failed with relativePath1")
        relativePath2.asURL != nil ? {debugPrint("relativePath2.asURL : \(relativePath2.asURL!)")}() : XCTFail("http encoding failed with relativePath1")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
