//
//  ViewController.swift
//  TakeawayAssignment
//
//  Created by Alex Gordon on 19.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    
    var apiClient = APIClient()
    let dataSource = DataSource<Restaurant>()
    var restaurants = [Restaurant]()

    
    // MARK: - UITableViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "RestaurantCell", bundle: nil),
                                forCellReuseIdentifier: Restaurant.cellIdentifier())
        self.tableView.dataSource = dataSource
        tableView.delegate = self
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

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .center
        header.tintColor = UIColor(red: 20.0 / 255, green: 116.0 / 255, blue: 155.0 / 255, alpha: 1)
    }
    
    // MARK: public methods
    
    private var currentSearchTerm: String = ""
    private var currentSortType: SortType = .bestMatch

    public func updateContent(sortType: SortType? = nil, searchTerm: String? = nil) {
        if let sortType = sortType {
            currentSortType = sortType
        }
        if let searchTerm = searchTerm {
            currentSearchTerm = searchTerm
        }
        
        let factory = RestaurantSectionFactory(apiClient: apiClient)
        let sections = factory.sections(restaurants: restaurants,
                                        sortType: currentSortType,
                                        searchTerm: currentSearchTerm)
        
            
        dataSource.sections = sections
        dataSource.currentSortType = currentSortType
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

private extension RestaurantTableViewController {
    func addToFavoritesAction(restaurant: Restaurant) -> UITableViewRowAction {
        let favorite = UITableViewRowAction(style: .normal, title: "Add to favorites") { (action, indexPath) in
            self.apiClient.addToFavorites(name: restaurant.name)
            self.updateContent()
        }
        
        favorite.backgroundColor = UIColor.green
        return favorite
    }
    
    func removeFromFavoritesAction(restaurant: Restaurant) -> UITableViewRowAction {
        let favorite = UITableViewRowAction(style: .normal, title: "Remove from favorites") { (action, indexPath) in
            self.apiClient.removeFromFavorites(name: restaurant.name)
            self.updateContent()
        }
        
        favorite.backgroundColor = UIColor.red
        return favorite
    }
}
