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
    
    var apiClient = APIClient()
    var currentSearchTerm = ""
    var currentSortType: SortType = .bestMatch
    
    weak var restaurantTableViewController: RestaurantTableViewController?
    var searchTypeButtons = [UIButton]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sortTypeScrollView: UIScrollView!
    
    override func viewDidLoad() {
        if restaurantTableViewController == nil {
            assertionFailure("Restaurant table view controller should be set before view loads")
            restaurantTableViewController = childViewControllers.flatMap({
                $0 as? RestaurantTableViewController }).first // Try to recover. flatMap filters out nils
        }
        
        super.viewDidLoad()
        configureSortTypeScrollView()
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RestaurantTableViewControllerSegue" {
            
            guard let destinationViewController = segue.destination as? RestaurantTableViewController else {
                fatalError("Expected RestaurantTableViewController, instead got: \(segue.destination)")
            }
            
            destinationViewController.apiClient = apiClient
            restaurantTableViewController = destinationViewController
            fetchRestaurantsAsync()
        }
    }
}

// MARK: - Private methods

private extension RestaurantListViewController {
    
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
                self.restaurantTableViewController?.restaurants = restaurants
                self.updateResultsInRestaurantTableViewController()
            } else {
                // this is the case where error == restaurants == nil. this should not happen.
                // assertion stays here as this is a pitfal (hidden expectation)
                ErrorMessage.unknownError().show(on: self)
                assertionFailure("Received nil restaurants and nil error from API. Both shouldn't be nil - please investigate.")
            }
        }
    }
    
    func updateResultsInRestaurantTableViewController() {
        let searchTerm = searchBar.text
        restaurantTableViewController?.updateContent(sortType: currentSortType, searchTerm: searchTerm)
    }
}

// MARK: - <UISearchBarDelegate>

extension RestaurantListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateResultsInRestaurantTableViewController()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        self.searchBar(searchBar, textDidChange: "")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

// MARK: - Sort type related configurations

private extension RestaurantListViewController {
        
    func configureSortTypeScrollView() {
        
        let buttonPadding: CGFloat = 10
        var xOffset: CGFloat = 10
        
        let allSortTypes = SortType.allValues()
        for i in 0..<allSortTypes.count {
            let sortType = allSortTypes[i]

            let button = SortTypeButton(sortType: sortType)
            let buttonVerticalPadding = (sortTypeScrollView.bounds.height - button.bounds.height) / 2
            button.frame = button.frame.offsetBy(dx: CGFloat(xOffset), dy: buttonVerticalPadding)
            
            button.addTarget(self, action: #selector(sortTypeButtonAction(sender:)), for: .touchUpInside)
            searchTypeButtons.append(button)
            sortTypeScrollView.addSubview(button)
            
            xOffset = xOffset + CGFloat(buttonPadding) + button.frame.size.width
        }
        
        sortTypeScrollView.contentSize = CGSize(width: xOffset, height: 0)
    }
    
    @objc
    func sortTypeButtonAction(sender: UIButton) {
        for button in searchTypeButtons {
            if button == sender {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
        
        if let sortType = SortType(rawValue: sender.tag) {
            currentSortType = sortType
            updateResultsInRestaurantTableViewController()
        } else {
            fatalError("Illegal tag on sort by type button: \(sender.tag)")
        }
    }
}
