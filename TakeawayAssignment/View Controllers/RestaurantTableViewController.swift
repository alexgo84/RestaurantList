//
//  ViewController.swift
//  TakeawayAssignment
//
//  Created by Alex Gordon on 19.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    let apiClient = APIClient()
    let dataSource = DataSource<Restaurant>()
    var currentSortType: SortType = .bestMatch {
        didSet {
            dataSource.currentSortType = currentSortType
        }
    }
    
    // MARK: - UITableViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "RestaurantCell", bundle: nil),
                                forCellReuseIdentifier: Restaurant.cellIdentifier())
        self.tableView.dataSource = dataSource
        tableView.delegate = self
        fetchRestaurantsAsync()
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let restaurant = dataSource.sections[indexPath.section].cellData[indexPath.row]
        let alreadyFavorite = apiClient.isFavorite(name: restaurant.name)
        
        if alreadyFavorite {
            return [removeFromFavoritesAction(restaurant: restaurant)]
        } else {
            return [addToFavoritesAction(restaurant: restaurant)]
        }
    }
}

private extension RestaurantTableViewController {
    
    func fetchRestaurantsAsync() {
        apiClient.getAllRestaurants {(restaurants, error) in
            
            // If an error occured -- allow the user to try again.
            
            if let error = error {
                ErrorMessage.custom(error: error).show(on: self,
                                                       customActionTitle: "Try Again",
                                                       customAction: {
                    self.fetchRestaurantsAsync()
                })
            }
            
            if let restaurants = restaurants {
                self.assignSections(restaurants: restaurants)
            } else {
                ErrorMessage.unknownError().show(on: self)
                assert(false)
            }
        }
    }
    
    func assignSections(restaurants: [Restaurant]) {
        
        var sections: [Section<Restaurant>] = []
        let favoriteRestaurants = apiClient.filter(favorite: true, restaurants: restaurants)
        let notFavoriteRestaurants = apiClient.filter(favorite: false, restaurants: restaurants)
        
        if favoriteRestaurants.count > 0 {
            let sortedRestaurants = RestaurantSorter(sortType: currentSortType).sort(elements: favoriteRestaurants) as! [Restaurant]
            sections.append(Section<Restaurant>(title: "Favorites ❤️", cellData: sortedRestaurants))
        }
        
        if notFavoriteRestaurants.count > 0 {
            let sortedRestaurants = RestaurantSorter(sortType: currentSortType).sort(elements: notFavoriteRestaurants) as! [Restaurant]
            sections.append(Section<Restaurant>(title: "Restaurants 🍏", cellData: sortedRestaurants))
        }
        
        dataSource.sections = sections
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func addToFavoritesAction(restaurant: Restaurant) -> UITableViewRowAction {
        let favorite = UITableViewRowAction(style: .normal, title: "Add to favorites") { (action, indexPath) in
            self.apiClient.addToFavorites(name: restaurant.name)
            self.fetchRestaurantsAsync()
        }
        
        favorite.backgroundColor = UIColor.green
        return favorite
    }
    
    func removeFromFavoritesAction(restaurant: Restaurant) -> UITableViewRowAction {
        let favorite = UITableViewRowAction(style: .normal, title: "Remove from favorites") { (action, indexPath) in
            self.apiClient.removeFromFavorites(name: restaurant.name)
            self.fetchRestaurantsAsync()
        }
        
        favorite.backgroundColor = UIColor.red
        return favorite
    }
}
