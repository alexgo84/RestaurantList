//
//  RestaurantTableViewControllerTests.swift
//  TakeawayAssignmentTests
//
//  Created by Alex Gordon on 23.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import XCTest
import Foundation
import UIKit
@testable import TakeawayAssignment


class RestaurantTableViewControllerTests: XCTestCase {
    var sut: RestaurantTableViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "RestaurantTableViewController") as! RestaurantTableViewController
        let dummyApiClient = DummyAPIClient(allFavorite: false, mixUp: true)
        sut.apiClient = dummyApiClient
        dummyApiClient.getAllRestaurants {(restaurants, error) in
            self.sut.restaurants = StubFactory().restaurantsFromStub()
            self.sut.updateContent(sortType: .bestMatch, searchTerm: "")
        }
    }
    
    func testInitialData() {
        
        XCTAssertEqual(sut.tableView.numberOfSections, 2)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 9)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 1), 10)
    }
    
    func testInitialDataWithSortType() {
        self.sut.updateContent(sortType: .ratingAverage, searchTerm: "")
        XCTAssertEqual(sut.tableView.numberOfSections, 2)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 9)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 1), 10)
    }
    
    func testInitialDataWithSearchTerm() {
        self.sut.updateContent(sortType: .minCost, searchTerm: "express")
        XCTAssertEqual(sut.tableView.numberOfSections, 1)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(sut.tableView.visibleCells.count, 1)
    }
}

