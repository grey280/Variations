//
//  GridConverterTests.swift
//  mkTests
//
//  Created by Grey Patterson on 2018-03-30.
//  Copyright © 2018 Grey Patterson. All rights reserved.
//

import XCTest
@testable import mk

class GridConverterTests: XCTestCase{
    let converter = GridConverter()
    
    func testChordLimiting(){
        let input1 = [true, false, true, true, false, false]
        XCTAssertEqual(converter.convert(input1, chord: .I), [51, 58, 63]) // Eb3, Bb3, Eb4
        let input2 = [true, false, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
        XCTAssertEqual(converter.convert(input2, chord: .I), [15, 22, 27]) // Eb0, Bb0, Eb1
    }
}
