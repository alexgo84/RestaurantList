//
//  RestaurantSectionsFactory.swift
//  TakeawayAssignment
//
//  Created by Alex Gordon on 22.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

struct RestaurantSectionFactory {
    let apiClient: APIClient
    
    public func sections(restaurants: [Restaurant],
                         sortType: SortType = .bestMatch, searchTerm: String = "") -> [Section<Restaurant>] {
        
        let filteredRestaurants: [Restaurant]
        if searchTerm.count > 0 {
            filteredRestaurants = restaurants.filter { $0.name.lowercased().contains(searchTerm.lowercased()) }
        } else {
            filteredRestaurants = restaurants
        }
        
        let favoriteRestaurants = apiClient.filter(favorite: true, restaurants: filteredRestaurants)
        let notFavoriteRestaurants = apiClient.filter(favorite: false, restaurants: filteredRestaurants)
        var sections = [Section<Restaurant>]()
        
        if favoriteRestaurants.count > 0 {
            let sortedRestaurants = RestaurantSorter(sortType: sortType).sort(elements: favoriteRestaurants)
            sections.append(Section<Restaurant>(title: "Favorites ❤️", cellData: sortedRestaurants))
        }
        
        if notFavoriteRestaurants.count > 0 {
            let sortedRestaurants = RestaurantSorter(sortType: sortType).sort(elements: notFavoriteRestaurants)
            sections.append(Section<Restaurant>(title: "Restaurants 🥡", cellData: sortedRestaurants))
        }
                
        // If both sections are empty -- provide an empty dummy section
        if sections.count == 0 {
            sections = [Section<Restaurant>(title: "No results 🧐", cellData: [])]
        }

        return sections
    }
}
