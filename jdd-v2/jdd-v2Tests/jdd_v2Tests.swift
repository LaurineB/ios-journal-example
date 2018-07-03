//
//  jdd_v2Tests.swift
//  jdd-v2Tests
//
//  Created by laurine baillet on 19/06/2018.
//  Copyright © 2018 laurine baillet. All rights reserved.
//

import XCTest
@testable import jdd_v2

class jdd_v2Tests: XCTestCase {
    
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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func getAllArticlesTest () {
        var articles : [Articles] = ArticleRequest.getArticles()
        
        XCTAssertNil(articles)
    }
}
