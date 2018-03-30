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
    
    private var grid: Grid!
    
    /// Prep for the tests! We'll be using a 5x5 grid.
    override func setUp() {
        super.setUp()
        grid = Grid(x: 5, y: 5, wrap: true)
    }
    
    /// Reset for each consecutive test. Mostly just resetting the grid.
    override func tearDown() {
        super.tearDown()
        grid = Grid(x: 5, y: 5, wrap: true)
    }
    
    /// Test [this blinker](https://en.wikipedia.org/wiki/File:Game_of_life_blinker.gif)
    func testBasicBlinker() {
        grid.cell(x: 2, y: 1, alive: true)
        grid.cell(x: 2, y: 2, alive: true)
        grid.cell(x: 2, y: 3, alive: true)
        grid.iterate()
        XCTAssert(grid.cell(x: 1, y: 2))
        XCTAssert(grid.cell(x: 2, y: 2))
        XCTAssert(grid.cell(x: 3, y: 2))
        XCTAssert(!grid.cell(x: 2, y: 1))
        XCTAssert(!grid.cell(x: 2, y: 3))
        grid.iterate()
        XCTAssert(!grid.cell(x: 1, y: 2))
        XCTAssert(grid.cell(x: 2, y: 2))
        XCTAssert(!grid.cell(x: 3, y: 2))
        XCTAssert(grid.cell(x: 2, y: 1))
        XCTAssert(grid.cell(x: 2, y: 3))
    }
    
    
}
