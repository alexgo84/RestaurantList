//
//  RestaurantSectionsFactoryTests.swift
//  TakeawayAssignmentTests
//
//  Created by Alex Gordon on 22.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import XCTest
import Foundation
@testable import TakeawayAssignment

class RestaurantSectionsFactoryTests: XCTestCase {
    
    let restaurants: [Restaurant] = StubFactory().restaurantsFromStub()
    var dummyAPIClientWithFavorites = DummyAPIClient(allFavorite: true)
    var dummyAPIClientWithoutFavorites = DummyAPIClient(allFavorite: false)
    var dummyAPIClientMixedUp = DummyAPIClient(allFavorite: false, mixUp: true)

    func test_EmptyInputShouldReturnOneSection() {
        let sut = RestaurantSectionFactory(apiClient: dummyAPIClientWithFavorites)
        let sections = sut.sections(restaurants: [])
        XCTAssertTrue(sections.count == 1)
        XCTAssertTrue(sections[0].cellData.count == 0)
        XCTAssertTrue(sections[0].title == "No results 🧐")
    }
    
    func test_AllFavorites_FavoritesSectionShouldBeFull() {
        let sut = RestaurantSectionFactory(apiClient: dummyAPIClientWithFavorites)
        let sections = sut.sections(restaurants: restaurants)
        XCTAssert(sections.count == 1)
        XCTAssert(sections[0].cellData.count == 19)
        XCTAssert(sections[0].title == "Favorites ❤️")
    }
    
    func test_AllNonFavorites_RestaurantsSectionShouldBeFull() {
        let sut = RestaurantSectionFactory(apiClient: dummyAPIClientWithoutFavorites)
        let sections = sut.sections(restaurants: restaurants)
        XCTAssert(sections.count == 1)
        XCTAssert(sections[0].cellData.count == 19)
        XCTAssert(sections[0].title == "Restaurants 🥡")
    }
    
    func test_MixedFavorites_BothSectionsShouldBePresent() {
        let sut = RestaurantSectionFactory(apiClient: dummyAPIClientMixedUp)
        
        let sections = sut.sections(restaurants: restaurants)
        XCTAssert(sections.count == 2)
        XCTAssert(sections[0].title == "Favorites ❤️")
        XCTAssert(sections[1].title == "Restaurants 🥡")
        XCTAssert(sections[0].cellData.count > 0)
        XCTAssert(sections[1].cellData.count > 0)
    }
    
    func test_AllNonFavoritesWithEmptySearchTerm() {
        let sut = RestaurantSectionFactory(apiClient: dummyAPIClientWithoutFavorites)
        let sections = sut.sections(restaurants: restaurants, sortType: .bestMatch, searchTerm: "")
        XCTAssert(sections[0].cellData.count == 19)
    }
    
    func test_AllNonFavoritesWithValidSearchTerm() {
        let sut = RestaurantSectionFactory(apiClient: dummyAPIClientWithoutFavorites)
        let sections = sut.sections(restaurants: restaurants, sortType: .bestMatch, searchTerm: "Sushi One")
        XCTAssert(sections[0].cellData.count == 1)
    }
    
    func test_AllNonFavoritesWithValidSearchTermLowerCase() {
        let sut = RestaurantSectionFactory(apiClient: dummyAPIClientWithoutFavorites)
        let sections = sut.sections(restaurants: restaurants, sortType: .bestMatch, searchTerm: "sushi one")
        XCTAssert(sections[0].cellData.count == 1)
    }
    
    func test_AllNonFavoritesWithInvalidSearchTerm() {
        let sut = RestaurantSectionFactory(apiClient: dummyAPIClientWithoutFavorites)
        let sections = sut.sections(restaurants: restaurants, sortType: .bestMatch, searchTerm: "fhfhfhfhfhfhfhfhfhf")
        XCTAssert(sections[0].cellData.count == 0)
    }
    
    func test_AllNonFavoritesWithSushiSearchTerm() {
        let sut = RestaurantSectionFactory(apiClient: dummyAPIClientWithoutFavorites)
        let sections = sut.sections(restaurants: restaurants, sortType: .bestMatch, searchTerm: "sushi")
        XCTAssert(sections[0].cellData.count == 4)
    }
    
    func test_SearchResultsContainSearchTerm() {
        let sut = RestaurantSectionFactory(apiClient: dummyAPIClientWithoutFavorites)
        let searchTerm = "e"
        let sections = sut.sections(restaurants: restaurants, sortType: .bestMatch, searchTerm: searchTerm)
        for currentRestaurant in restaurants {
            let index = sections[0].cellData.index(where: { (restaurant) -> Bool in
                return restaurant.name == currentRestaurant.name
            })
            
            if let _ = index {
                XCTAssertTrue(currentRestaurant.name.contains(searchTerm))
            } else {
                XCTAssertFalse(currentRestaurant.name.contains(searchTerm))
            }
        }
    }
}

