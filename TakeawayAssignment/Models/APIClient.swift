//
//  APIClient.swift
//  TakeawayAssignment
//
//  Created by Alex Gordon on 19.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

class APIClient {
    
    /*
     When there is a need to fetch results from remote - create a web service owned by APIClient.
     Then create a resource with a remote URL instead of calling 'Restaurant.allLocalRestaurants'.
     */
    private let webService: WebService = WebService()
    private let localService: LocalService = LocalService()
    private var localFavoritesStorage = LocalFavoritesStorage()
    
    @available(*, unavailable, message:"This wasn't implemented yet. To use this -- define a valid URL unside 'JSONURL.restaurants.urlToRemote'")
    func getAllRestaurantsFromRemote(completion: @escaping ([Restaurant]?, Error?) -> ()) {
        webService.load(resource: Restaurant.allFromRemote) { restaurants, error in
            completion(restaurants, error)
        }
    }
    
    /// Try to load all restaurants from local JSON
    func getAllRestaurants(completion: @escaping ([Restaurant]?, Error?) -> ()) {
        localService.load(resource: Restaurant.allFromStub) { restaurants, error in
            completion(restaurants, error)
        }
    }
    
    
    // Bridging methods to LocalStorage so that it stays private (maybe to later be put in separate model module)
    
    func isFavorite(name: String) -> Bool {
        return localFavoritesStorage.isFavorite(name: name)
    }
    
    func filter(favorite: Bool, restaurants: [Restaurant]) -> [Restaurant] {
        return localFavoritesStorage.filter(favorite: favorite, restaurants: restaurants)
    }
    
    func removeFromFavorites(name: String) {
        localFavoritesStorage.removeFromFavorites(name: name)
    }
    
    func addToFavorites(name: String) {
        localFavoritesStorage.addToFavorites(name: name)
    }
}
