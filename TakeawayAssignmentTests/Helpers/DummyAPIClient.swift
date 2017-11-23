//
//  DummyAPIClient.swift
//  TakeawayAssignmentTests
//
//  Created by Alex Gordon on 22.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

@testable import TakeawayAssignment
import Foundation

class DummyAPIClient: APIClient {
    let allFavorite: Bool
    let mixUp: Bool
    
    init(allFavorite: Bool, mixUp: Bool = false) {
        self.mixUp = mixUp
        self.allFavorite = allFavorite
    }
    
    override func getAllRestaurants(completion: @escaping ([Restaurant]?, Error?) -> ()) {
        let restaurants = StubFactory().restaurantsFromStub()
        completion(restaurants, nil)
    }
    
    override func isFavorite(name: String) -> Bool {
        guard mixUp == false else {
            return name.hashValue % 2 == 0 // if mixUp is true -- try to return false for some values and true for others
        }
        return allFavorite ? true : false
    }
    
    override func filter(favorite: Bool, restaurants: [Restaurant]) -> [Restaurant] {
        guard mixUp == false else {
            let leftSplit: ArraySlice<Restaurant> = restaurants[0 ..< restaurants.count / 2]
            let rightSplit: ArraySlice<Restaurant> = restaurants[restaurants.count / 2 ..< restaurants.count]
            
            let leftArray: [Restaurant] = Array(leftSplit)
            let rightArray: [Restaurant] = Array(rightSplit)
            return favorite ? leftArray : rightArray
        }
        
        return allFavorite == favorite ? restaurants : []
    }
    
    override func removeFromFavorites(name: String) {}
    
    override func addToFavorites(name: String) {}
}
