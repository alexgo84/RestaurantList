//
//  RestaurantListViewControllerTests.swift
//  TakeawayAssignmentTests
//
//  Created by Alex Gordon on 23.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import XCTest
import Foundation
import UIKit
@testable import TakeawayAssignment


class RestaurantListViewControllerTests: XCTestCase {
    var sut: RestaurantListViewController!
    var restaurantTableViewController = DummyRestaurantTableViewController()
    var searchBar: UISearchBar = UISearchBar()
    var scrollView: UIScrollView = UIScrollView()
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "RestaurantListViewController") as! RestaurantListViewController
        
        // Set outlets that are strongly referenced elsewhere
        sut.searchBar = searchBar
        sut.sortTypeScrollView = scrollView
        sut.viewDidLoad()
        
        // Assign a dummy APIClient
        let dummyApiClient = DummyAPIClient(allFavorite: false, mixUp: true)
        sut.apiClient = dummyApiClient
        
        // Segue to dummy table view controller
        let segue = UIStoryboardSegue(identifier: "RestaurantTableViewControllerSegue", source: UIViewController(), destination: restaurantTableViewController)
        sut.prepare(for: segue, sender: nil)
    }
    
    func test_InitialConfiguration() {
        XCTAssertTrue(restaurantTableViewController.updateContentCalledCounter == 1,
                      "After initialization, updateContent() method should have been called exactly once")
        XCTAssertTrue(restaurantTableViewController.lastSearchTerm == "",
                      "After initialization, the default search term should be the empty string")
        XCTAssertTrue(restaurantTableViewController.lastSortType == .bestMatch,
                      "After initialization, the default sort type should be .bestMatch")
    }
    
    func test_SearchResultChanged() {
        searchBar.text = "sushi"
        searchBar.delegate?.searchBar!(searchBar, textDidChange: "sushi")
        XCTAssertTrue(restaurantTableViewController.updateContentCalledCounter == 2,
                      "After search, updateContent() method should have been called again")
        XCTAssertTrue(restaurantTableViewController.lastSearchTerm == "sushi",
                      "After search, the last search term should have been updated")
        XCTAssertTrue(restaurantTableViewController.lastSortType == .bestMatch,
                      "After search, the last sort type should stay the same")
    }
    
    func test_SearchCancelled() {
        searchBar.text = "sushi"
        searchBar.delegate?.searchBar!(searchBar, textDidChange: "sushi")
        searchBar.delegate?.searchBarCancelButtonClicked!(searchBar)
        XCTAssertTrue(restaurantTableViewController.updateContentCalledCounter == 3,
                      "After canceling search, updateContent() method should have been called again")
        XCTAssertTrue(restaurantTableViewController.lastSearchTerm == "",
                      "After canceling search, the last search term should have been updated to empty string")
        XCTAssertTrue(restaurantTableViewController.lastSortType == .bestMatch,
                      "After canceling search, the last sort type should stay the same")
    }
    
    func test_SortTypeChanged() {
        let button = scrollView.subviews[2] as! SortTypeButton
        button.sendActions(for: .touchUpInside)
        XCTAssertTrue(restaurantTableViewController.updateContentCalledCounter == 2,
                      "After the sort type was changed, updateContent() method should have been called again")
        XCTAssertTrue(restaurantTableViewController.lastSearchTerm == "",
                      "After the sort type was changed, the last search term shouldn't change")
        XCTAssertTrue(restaurantTableViewController.lastSortType?.rawValue == button.tag,
                      "After the sort type was changed, the last sort type should have changed")
    }
}


