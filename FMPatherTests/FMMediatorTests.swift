//
//  FMMediatorTests.swift
//  FMPather
//
//  Created by Fantasy on 2017/9/21.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import XCTest

class FMMediatorTests: XCTestCase {
    
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
    
    func testMediator() {
        let mediator = FMMediator(scheme: String.appScheme, host: String.appHost)
        let restful = "\(String.appScheme)://\(String.appHost)/app/api/v2/:id"
        let path0 = "\(String.appScheme)://\(String.appHost)/app/api/v2/3354?name=feng&add=1"
        let _ = mediator.registerRestful(restfulPath: restful) { _ in UIViewController()}
        let obj0 = mediator.controller(for: path0)
        XCTAssert(obj0 != nil, "path filter failed")
        let dynamic = mediator.dynamicPathComponents(for: path0)
        dynamic.isEmpty ? XCTFail("dynamic conponents paraser failed") : {print("\(dynamic)\n")}()
        
        let querys = mediator.querys(for: path0)
        querys.isEmpty ? XCTFail("querys conponents paraser failed") : {print("\(querys)\n")}()
        
        
        let path1 = "\(String.appScheme)://\(String.appHost)/app/api/v2/3354/adds"
        let obj1 = mediator.controller(for: path1)
        XCTAssert(obj1 == nil, "path filter failed")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
