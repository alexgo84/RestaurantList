//
//  RestaurantCellConfigurator.swift
//  TakeawayAssignmentTests
//
//  Created by Alex Gordon on 22.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import XCTest
import Foundation
import UIKit
@testable import TakeawayAssignment

class CellConfiguratorTests: XCTestCase {

    var cell: DummyRestaurantCell!
    let restaurant = Restaurant(sortValues: SortValues(bestMatch: 1,
                                                       newest: 2,
                                                       ratingAverage: 3,
                                                       distance: 4,
                                                       popularity: 5,
                                                       averageProductPrice: 6,
                                                       deliveryCosts: 7,
                                                       minCost: 8),
                                name: "Test name",
                                status: .open)
    
    
    override func setUp() {
        cell = DummyRestaurantCell()
        cell.layoutSubviews()
    }

    func test_BasicCellConfiguration() {
        RestaurantCellConfigurator(restaurant: restaurant, sortType: .bestMatch).configure(cell: cell)
        XCTAssert(cell.nameLabel.text == "Test name")
        XCTAssert(cell.statusLabel.text == "Open")
        XCTAssert(cell.sortValueLabel.text == "Best Match: 1.0")
    }
    
    func test_ConfigureCellWithNewestSortType() {
        RestaurantCellConfigurator(restaurant: restaurant, sortType: .newest).configure(cell: cell)
        XCTAssert(cell.sortValueLabel.text == "Newest: 2.0")
    }
    
    
    func test_ConfigureCellWithAverageRatingSortType() {
        RestaurantCellConfigurator(restaurant: restaurant, sortType: .ratingAverage).configure(cell: cell)
        XCTAssert(cell.sortValueLabel.text == "Average Rating: 3.0")
    }
    
    func test_ConfigureCellWithDistanceSortType() {
        RestaurantCellConfigurator(restaurant: restaurant, sortType: .distance).configure(cell: cell)
        XCTAssert(cell.sortValueLabel.text == "Distance: 4.0")
    }
    
    func test_ConfigureCellWithPopularitySortType() {
        RestaurantCellConfigurator(restaurant: restaurant, sortType: .popularity).configure(cell: cell)
        XCTAssert(cell.sortValueLabel.text == "Popularity: 5.0")
    }
    
    func test_ConfigureCellWithAverageProductPriceSortType() {
        RestaurantCellConfigurator(restaurant: restaurant, sortType: .averageProductPrice).configure(cell: cell)
        XCTAssert(cell.sortValueLabel.text == "Average Product Price: 6.0")
    }
    
    func test_ConfigureCellWithDeliveryCostsSortType() {
        RestaurantCellConfigurator(restaurant: restaurant, sortType: .deliveryCosts).configure(cell: cell)
        XCTAssert(cell.sortValueLabel.text == "Delivery Costs: 7.0")
    }
    
    func test_ConfigureCellWithMinCostSortType() {
        RestaurantCellConfigurator(restaurant: restaurant, sortType: .minCost).configure(cell: cell)
        XCTAssert(cell.sortValueLabel.text == "Min Cost: 8.0")
    }
}
