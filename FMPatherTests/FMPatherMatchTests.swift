//
//  FMPatherMatchTests.swift
//  FMPather
//
//  Created by Fantasy on 2017/9/16.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import XCTest

class FMPatherMatchTests: XCTestCase {
    
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
    
    func testURLIsMatch() {
        let patternURL = "demo://baidu.com/hello/:welcome"
        let testURL = "demo://baidu.com/hello/aaa"
        if !(testURL.isMatchRouter(restfulPath: patternURL, dynamic: ":[a-z,A-Z,0-9,_]+")) {
            XCTFail("url test failed")
        }
        
        let testURL1 = "demo://baidu.com/hello/aaa/ccc"
        if (testURL1.isMatchRouter(restfulPath: patternURL, dynamic: ":[a-z,A-Z,0-9,_]+")) {
            XCTFail("url test failed")
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
