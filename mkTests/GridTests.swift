//
//  GridTests.swift
//  mkTests
//
//  Created by Grey Patterson on 2018-03-08.
//  Copyright © 2018 Grey Patterson. All rights reserved.
//

import XCTest
@testable import mk

class GridTests: XCTestCase {
    
    var grid: Grid!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        grid = Grid(x: 5, y: 5, wrap: true)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        grid = Grid(x: 5, y: 5, wrap: true)
    }
    
    func testBasicBlinker() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        grid.cell(x: 2, y: 1, alive: true)
        grid.cell(x: 2, y: 2, alive: true)
        grid.cell(x: 2, y: 3, alive: true)
        grid.iterate()
        XCTAssert(grid.cell(x: 1, y: 2))
        XCTAssert(grid.cell(x: 2, y: 2))
        XCTAssert(grid.cell(x: 3, y: 2))
        XCTAssert(!grid.cell(x: 2, y: 1))
        XCTAssert(!grid.cell(x: 2, y: 3))
    }
}
