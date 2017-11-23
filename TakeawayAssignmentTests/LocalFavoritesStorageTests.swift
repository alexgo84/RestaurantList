//
//  LocalFavoritesStorageTests.swift
//  TakeawayAssignmentTests
//
//  Created by Alex Gordon on 22.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import XCTest
@testable import TakeawayAssignment

class LocalFavoritesStorageTests: XCTestCase {
    
    var userDefaults: UserDefaults!
    let userDefaultsSuiteName = "group.com.AlexGordon.TakeawayAssignment.TestSuite"
    var sut: LocalFavoritesStorage?
    
    override func setUp() {
        super.setUp()
        UserDefaults().removePersistentDomain(forName: userDefaultsSuiteName)
        userDefaults = UserDefaults(suiteName: userDefaultsSuiteName)
        sut = LocalFavoritesStorage(userDefaults: userDefaults)
    }
    
    func test_localFavoritesStorageIntialization() {
        XCTAssertNotNil(sut)
    }
    
    func test_addingNames() {
        guard var sut = sut else { XCTFail();return}
        let newName = "Foo"
        XCTAssertFalse(sut.isFavorite(name: newName))
        sut.addToFavorites(name: newName)
        XCTAssertTrue(sut.isFavorite(name: newName))
    }
    
    func test_removingNames() {
        guard var sut = sut else { XCTFail();return}
        let newName = "Foo"
        XCTAssertFalse(sut.isFavorite(name: newName))
        sut.addToFavorites(name: newName)
        XCTAssertTrue(sut.isFavorite(name: newName))
        sut.removeFromFavorites(name: newName)
        XCTAssertFalse(sut.isFavorite(name: newName))
    }
    
    func test_PersistenceOnReinitialization() {
        guard var sut = sut else { XCTFail();return}
        let newName = "Bar"
        sut.addToFavorites(name: newName)
        XCTAssertTrue(sut.isFavorite(name: newName))
        sut = LocalFavoritesStorage(userDefaults: UserDefaults(suiteName: userDefaultsSuiteName)!)
        XCTAssertTrue(sut.isFavorite(name: newName))
    }
}
