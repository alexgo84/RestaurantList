//
//  SortValuesTests.swift
//  TakeawayAssignmentTests
//
//  Created by Alex Gordon on 22.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import XCTest
@testable import TakeawayAssignment

class SortValuesTests: XCTestCase {
    
    let validJSONDict = ["bestMatch": 1,
                         "newest": 2,
                         "ratingAverage": 3,
                         "distance": 4,
                         "popularity": 5,
                         "averageProductPrice": 6,
                         "deliveryCosts": 7,
                         "minCost": 8]
    
    let invalidJSONDict = ["bestMatch": 1,
                           "newest": 2,
                           "ratingAverage": 3,
                           //"distance": 4,
                           "popularity": 5,
                           "averageProductPrice": 6,
                           "deliveryCosts": 7,
                           "minCost": 8]

    var sortValues: SortValues!
    
    override func setUp() {
        sortValues = SortValues(json: validJSONDict as JSONDict)
    }
    
    func test_ParseValidJSONDict_Success() {
        let sortValues = SortValues(json: validJSONDict as JSONDict)
        XCTAssertNotNil(sortValues)
    }
    
    func test_ParseInvalidJSONDict_Fail() {
        let sortValues = SortValues(json: invalidJSONDict as JSONDict)
        XCTAssertNil(sortValues)
    }
    
    func test_CorrectValuesAfterParsing() {
        let sortValues = SortValues(json: validJSONDict as JSONDict)
        XCTAssertTrue(sortValues?.valueFor(sortType: .bestMatch) == 1)
        XCTAssertTrue(sortValues?.valueFor(sortType: .newest) == 2)
        XCTAssertTrue(sortValues?.valueFor(sortType: .ratingAverage) == 3)
        XCTAssertTrue(sortValues?.valueFor(sortType: .distance) == 4)
        XCTAssertTrue(sortValues?.valueFor(sortType: .popularity) == 5)
        XCTAssertTrue(sortValues?.valueFor(sortType: .averageProductPrice) == 6)
        XCTAssertTrue(sortValues?.valueFor(sortType: .deliveryCosts) == 7)
        XCTAssertTrue(sortValues?.valueFor(sortType: .minCost) == 8)
    }
}


