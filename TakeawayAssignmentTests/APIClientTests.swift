//
//  APIClientTests.swift
//  TakeawayAssignmentTests
//
//  Created by Alex Gordon on 22.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import XCTest
@testable import TakeawayAssignment

class APIClientTests: XCTestCase {
    
    func test_getAllRestaurantsFromStub_Success() {
        let sut = APIClient()
        let expectation = self.expectation(description: "wait to get all restaurants")
        
        sut.getAllRestaurants { (restaurants, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(restaurants)
            if let restaurants = restaurants {
                XCTAssertTrue(restaurants.count == 19, "19 restaurants should be received from local stub")
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    /*
        APIClient has additional bridiging methods that I will not test!
     */
}

