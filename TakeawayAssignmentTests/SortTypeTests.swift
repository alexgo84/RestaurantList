//
//  SortTypeTests.swift
//  TakeawayAssignmentTests
//
//  Created by Alex Gordon on 22.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//


import XCTest
@testable import TakeawayAssignment

class SortTypeTests: XCTestCase {
    
    func test_SortTypeCount() {
        XCTAssertTrue(SortType.allValues().count == 8, "Total number of sort types should be 8")
    }
    
    func test_BestMatchToString() {
        let sortType = SortType.bestMatch
        XCTAssertTrue(sortType.toString() == "Best Match")
    }
    
    func test_NewestToString() {
        let sortType = SortType.newest
        XCTAssertTrue(sortType.toString() == "Newest")
    }
    
    func test_RatingAverageToString() {
        let sortType = SortType.ratingAverage
        XCTAssertTrue(sortType.toString() == "Average Rating")
    }
    
    func test_DistanceToString() {
        let sortType = SortType.distance
        XCTAssertTrue(sortType.toString() == "Distance")
    }
    
    func test_PopularityToString() {
        let sortType = SortType.popularity
        XCTAssertTrue(sortType.toString() == "Popularity")
    }
    
    func test_AverageProductPriceToString() {
        let sortType = SortType.averageProductPrice
        XCTAssertTrue(sortType.toString() == "Avg. Product Price")
    }
    
    func test_DeliveryCostsToString() {
        let sortType = SortType.deliveryCosts
        XCTAssertTrue(sortType.toString() == "Delivery Costs")
    }
}
