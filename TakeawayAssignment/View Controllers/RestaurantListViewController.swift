//
//  RestaurantListViewController.swift
//  TakeawayAssignment
//
//  Created by Alex Gordon on 21.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation
import UIKit

class RestaurantListViewController: UIViewController {
    
    @IBOutlet weak var serachBar: UISearchBar!
    @IBOutlet weak var filterButton: UIButton!

    let APIClient = APIClient()
    var restaurantTableViewController: RestaurantTableViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RestaurantTableSegueIdentifier" {
            restaurantTableViewController = segue.destination as! RestaurantTableViewController
            restaurantTableViewController.apiClient = apiClient
            restaurantTableViewController.currentSortType = .bestMatch
        }
    }
}
