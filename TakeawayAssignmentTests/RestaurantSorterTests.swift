//
//  RestaurantSorterTests.swift
//  TakeawayAssignmentTests
//
//  Created by Alex Gordon on 22.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import XCTest
@testable import TakeawayAssignment

class RestaurantSorterTests: XCTestCase {
    let restaurants: [Restaurant] = StubFactory().restaurantsFromStub()

    func test_CheckEverySortType() {
        
        // For each sort type check if the invariants of the sorting are kept
        for sortType in SortType.allValues() {
            
            let sut = RestaurantSorter(sortType: sortType)
            let sortedRestaurants = sut.sort(elements: restaurants)
            
            var previousRestaurant: Restaurant?
            
            for restaurant in sortedRestaurants {
                
                if let previousRestaurant = previousRestaurant {
                    
                    // The previous restaurant (higher in the list) MUST NOT have a status lower than the present one
                    XCTAssertFalse(previousRestaurant.status < restaurant.status)
                    
                    // If the status is the same -- the previous restaurant (higher in the list) MUST NOT have
                    // a sort parameter lower than the present one
                    if previousRestaurant.status == restaurant.status {
                        if sortType.sortAscending() {
                            XCTAssertTrue(previousRestaurant.sortValues!.valueFor(sortType: sortType) <= restaurant.sortValues!.valueFor(sortType: sortType))
                        } else {
                            XCTAssertTrue(previousRestaurant.sortValues!.valueFor(sortType: sortType) >= restaurant.sortValues!.valueFor(sortType: sortType))
                        }
                    }
                }
                
                previousRestaurant = restaurant
            }
        }
    }
}
