//
//  ResourceTests.swift
//  TakeawayAssignmentTests
//
//  Created by Alex Gordon on 22.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import XCTest
@testable import TakeawayAssignment

class ResourceTests: XCTestCase {
    
    func test_JSONURLToLocal() {
        let localUrl = JSONURL.restaurants.urlToLocalStub()
        XCTAssertTrue(localUrl.pathComponents.last == "sample iOS.json")
    }
    
    func test_ResourceInitialization() {
        let resource = Resource<Restaurant>(url: JSONURL.restaurants.urlToLocalStub(), parseFunction: { data in
            return nil
        })
        XCTAssertNotNil(resource.url)
        XCTAssertNotNil(resource.parseFunction)
    }

}
