//
//  RestaurantStatusTests.swift
//  TakeawayAssignmentTests
//
//  Created by Alex Gordon on 22.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import XCTest
@testable import TakeawayAssignment

class RestaurantStatusTests: XCTestCase {
    
    func test_InitWithLegalOpenString() {
        let status = RestaurantStatus(string: "open")
        XCTAssertTrue(status == .open, "Initialization with 'open' should produce correct value")
    }
    
    func test_InitWithLegalClosedString() {
        let status = RestaurantStatus(string: "closed")
        XCTAssertTrue(status == .closed, "Initialization with 'closed' should produce correct value")
    }
    
    func test_InitWithLegalOrderAheadString() {
        let status = RestaurantStatus(string: "order ahead")
        XCTAssertTrue(status == .orderAhead, "Initialization with 'order ahead' should produce correct value")
    }
    
    func test_InitWithInvalidString() {
        let status = RestaurantStatus(string: "invalid string")
        XCTAssertTrue(status == .unknown, "Initialization with an invalid string should produce correct value")
    }
    
    func test_ToStringWithOpenStatus() {
        let status = RestaurantStatus.open
        XCTAssertTrue(status.toString() == "Open")
    }
    
    func test_ToStringWithClosedStatus() {
        let status = RestaurantStatus.closed
        XCTAssertTrue(status.toString() == "Closed")
    }
    
    func test_ToStringWithOrderAheadStatus() {
        let status = RestaurantStatus.orderAhead
        XCTAssertTrue(status.toString() == "Order ahead")
    }
    
    func test_ToStringWithUnknownStatus() {
        let status = RestaurantStatus.unknown
        XCTAssertTrue(status.toString() == "Unknown")
    }
    
    func test_MoreThanOperator() {
        
        let openStatus = RestaurantStatus.open
        let closedStatus = RestaurantStatus.closed
        let orderAheadStatus = RestaurantStatus.orderAhead
        let unknownStatus = RestaurantStatus.unknown
        
        XCTAssertTrue(openStatus > orderAheadStatus)
        XCTAssertTrue(openStatus > closedStatus)
        XCTAssertTrue(openStatus > unknownStatus)
        XCTAssertFalse(openStatus > openStatus)
        
        XCTAssertTrue(orderAheadStatus > closedStatus)
        XCTAssertTrue(orderAheadStatus > unknownStatus)
        XCTAssertFalse(orderAheadStatus > openStatus)
        XCTAssertFalse(orderAheadStatus > orderAheadStatus)

        XCTAssertFalse(closedStatus > orderAheadStatus)
        XCTAssertFalse(closedStatus > closedStatus)
        XCTAssertTrue(closedStatus > unknownStatus)
        XCTAssertFalse(closedStatus > openStatus)
        
        XCTAssertFalse(unknownStatus > orderAheadStatus)
        XCTAssertFalse(unknownStatus > closedStatus)
        XCTAssertFalse(unknownStatus > unknownStatus)
        XCTAssertFalse(unknownStatus > openStatus)
    }
    
    func test_LessThanOperator() {
        
        let openStatus = RestaurantStatus.open
        let closedStatus = RestaurantStatus.closed
        let orderAheadStatus = RestaurantStatus.orderAhead
        let unknownStatus = RestaurantStatus.unknown
        
        XCTAssertFalse(openStatus < orderAheadStatus)
        XCTAssertFalse(openStatus < closedStatus)
        XCTAssertFalse(openStatus < unknownStatus)
        XCTAssertFalse(openStatus < openStatus)
        
        XCTAssertFalse(orderAheadStatus < closedStatus)
        XCTAssertFalse(orderAheadStatus < unknownStatus)
        XCTAssertTrue(orderAheadStatus < openStatus)
        XCTAssertFalse(orderAheadStatus < orderAheadStatus)
        
        XCTAssertTrue(closedStatus < orderAheadStatus)
        XCTAssertFalse(closedStatus < closedStatus)
        XCTAssertFalse(closedStatus < unknownStatus)
        XCTAssertTrue(closedStatus < openStatus)
        
        XCTAssertTrue(unknownStatus < orderAheadStatus)
        XCTAssertTrue(unknownStatus < closedStatus)
        XCTAssertFalse(unknownStatus < unknownStatus)
        XCTAssertTrue(unknownStatus < openStatus)
    }
}

