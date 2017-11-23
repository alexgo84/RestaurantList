//
//  LocalFavoritesStorage.swift
//  TakeawayAssignment
//
//  Created by Alex Gordon on 20.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

struct LocalFavoritesStorage {
    
    private let kFavorites = "kFavoriteRestaurantsNames"
    private var favoriteRestaurantNames: [String]
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
        guard let namesFromLocalStorage = userDefaults.object(forKey: kFavorites) as? [String] else {
            favoriteRestaurantNames = []
            return
        }
        favoriteRestaurantNames = namesFromLocalStorage
    }
    
    public mutating func addToFavorites(name: String) {
        guard favoriteRestaurantNames.contains(name) == false else {
            print("FAIL: trying to add \(name) to favorites, but it's already there.")
            return
        }
        
        favoriteRestaurantNames.append(name)
        userDefaults.setValue(favoriteRestaurantNames, forKey: kFavorites)
    }
    
    public mutating func removeFromFavorites(name: String) {
        guard favoriteRestaurantNames.contains(name) else {
            print("FAIL: trying to add \(name) to favorites, but it's already there.")
            return
        }
        
        if let index = favoriteRestaurantNames.index(where: {$0 == name}) {
            favoriteRestaurantNames.remove(at: index)
        }

        userDefaults.setValue(favoriteRestaurantNames, forKey: kFavorites)
    }
    
    public func isFavorite(name: String) -> Bool {
        if favoriteRestaurantNames.contains(name) {
            return true
        }
        return false
    }
    
    public func filter(favorite: Bool, restaurants: [Restaurant]) -> [Restaurant] {
        var filteredRestaurants: [Restaurant] = []
        
        for restaurant in restaurants {
            if isFavorite(name: restaurant.name) == favorite {
                filteredRestaurants.append(restaurant)
            }
        }
        
        return filteredRestaurants
    }
}
