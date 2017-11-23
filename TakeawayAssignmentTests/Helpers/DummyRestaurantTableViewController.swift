//
//  DummyRestaurantTableViewController.swift
//  TakeawayAssignmentTests
//
//  Created by Alex Gordon on 23.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation
import UIKit
@testable import TakeawayAssignment


class DummyRestaurantTableViewController: RestaurantTableViewController {
    public var lastSortType: SortType? = .bestMatch
    public var lastSearchTerm: String? = ""
    public var updateContentCalledCounter: Int = 0
    override public func updateContent(sortType: SortType? = nil, searchTerm: String? = nil) {
        lastSortType = sortType
        lastSearchTerm = searchTerm
        updateContentCalledCounter += 1
    }
}
