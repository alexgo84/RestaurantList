//
//  DataSourceTests.swift
//  TakeawayAssignmentTests
//
//  Created by Alex Gordon on 23.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import XCTest
import Foundation
import UIKit
@testable import TakeawayAssignment


class DataSourceTests: XCTestCase {
    
    var dataSource: DataSource<Restaurant>!
    var tableView: UITableView!
    let restaurants: [Restaurant] = StubFactory().restaurantsFromStub()
    
    override func setUp() {
        super.setUp()
        
        dataSource = DataSource<Restaurant>()
        dataSource.sections = [Section<Restaurant>(title: "Test section title", cellData: restaurants)]
        
        tableView = UITableView()
        tableView.register(UINib(nibName: Restaurant.cellIdentifier(), bundle: nil), forCellReuseIdentifier: Restaurant.cellIdentifier())
        tableView.dataSource = dataSource
        tableView.reloadData()
        tableView.awakeFromNib()
    }
    
    func testDataSourceNumberOfItems() {
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1)
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 19)
    }
    
    func testDataSourceClearData() {
        dataSource.clearData()
        tableView.reloadData()
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1)
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 0)
    }
    
    func testDataSourceContent() {
        XCTAssertEqual(dataSource.tableView(tableView, titleForHeaderInSection: 0), "Test section title")
        let restaurantCell = dataSource.tableView(tableView, cellForRowAt: IndexPath(item: 2, section: 0)) as! RestaurantCell
        
        XCTAssertEqual(restaurantCell.nameLabel.text, "Royal Thai")
        XCTAssertEqual(restaurantCell.statusLabel.text, "Order ahead")
        XCTAssertEqual(restaurantCell.sortValueLabel.text, "Best Match: 2.0")
    }
}
