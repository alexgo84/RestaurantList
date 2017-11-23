//
//  RestaurantTests.swift
//  TakeawayAssignmentTests
//
//  Created by Alex Gordon on 19.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import XCTest
@testable import TakeawayAssignment


class RestaurantTests: XCTestCase {

    let validJSON = ["name": "A",
                     "status": "open",
                     "sortingValues": [
                        "bestMatch": 1,
                        "newest": 2,
                        "ratingAverage": 3,
                        "distance": 4,
                        "popularity": 5,
                        "averageProductPrice": 6,
                        "deliveryCosts": 7,
                        "minCost": 8
        ]
    ] as [String : Any]
    
    let validJSONWithEmptySortValues = ["name": "A",
                                        "status": "open",
                                        "sortingValues": [
                                            "bestMatch": 1
        ]
    ] as [String : Any]
    
    let invalidJSONWithoutStatus = ["name": "A",
                                    //"status": "open",
                                    "sortingValues": [
                                        "bestMatch": 1
        ]
    ] as [String : Any]
    
    let invalidJSONWithoutName = [
                                  //"name": "A" as AnyObject,
                                  "status": "open",
                                  "sortingValues": [
                                    "bestMatch": 1
        ]
    ] as [String : Any]

    let invalidJSONWithoutSortingValues = ["name": "A",
                                           "status": "open",
                                           "sortingValues": []
    ] as [String : Any]

    
    func test_ParseValidJSON_Success() {
        let restaurant = Restaurant(json: validJSON as JSONDict)
        
        XCTAssertNotNil(restaurant)
        XCTAssertNotNil(restaurant?.sortValues)
        XCTAssertTrue(restaurant?.name == "A")
        XCTAssertTrue(restaurant?.status == .open)
    }
    
    func test_ParseValidJSONWithoutSortValues_Success() {
        let restaurant = Restaurant(json: validJSONWithEmptySortValues as JSONDict)
        
        XCTAssertNotNil(restaurant)
        XCTAssertNil(restaurant?.sortValues)
        XCTAssertTrue(restaurant?.name == "A")
        XCTAssertTrue(restaurant?.status == .open)
    }
    
    func test_ParseInvalidJSON1() {
        let restaurant = Restaurant(json: invalidJSONWithoutName as JSONDict)
        XCTAssertNil(restaurant)
    }

    func test_ParseInvalidJSON2() {
        let restaurant = Restaurant(json: invalidJSONWithoutStatus as JSONDict)
        XCTAssertNil(restaurant)
    }
    
    func test_ParseInvalidJSON3() {
        let restaurant = Restaurant(json: invalidJSONWithoutSortingValues as JSONDict)
        XCTAssertNil(restaurant)
    }
    
    func test_AllFromStub() {
        let resource = Restaurant.allFromStub
        XCTAssertNotNil(resource)
        XCTAssertNotNil(resource.url)
        XCTAssertNotNil(resource.parseFunction)
    }
    
}
