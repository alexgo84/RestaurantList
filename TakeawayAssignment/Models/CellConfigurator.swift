//
//  CellConfigurator.swift
//  TakeawayAssignment
//
//  Created by Alex Gordon on 19.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation
import UIKit

protocol CellConfigurator {
    func configure(cell: RestaurantCell)
}

struct RestaurantCellConfigurator {
    let restaurant: Restaurant
    let sortType: SortType
    
    func configure(cell: RestaurantCell) {
        cell.nameLabel.text = restaurant.name
        configureStatusLabel(cell: cell)
        configureSortLabel(cell: cell)
        cell.layoutSubviews()
    }
}

private extension RestaurantCellConfigurator {
    
    private func configureStatusLabel(cell: RestaurantCell) {
        cell.statusLabel.text = restaurant.status.toString()
        switch restaurant.status {
        case .open:
            cell.statusLabel.textColor = UIColor.green
        case .orderAhead:
            cell.statusLabel.textColor = UIColor.brown
        case .closed:
            cell.statusLabel.textColor = UIColor.red
        case .unknown:
            cell.statusLabel.textColor = UIColor.black
        }
    }
    
    private func configureSortLabel(cell: RestaurantCell) {
        
        cell.sortValueLabel.isHidden = true
        
        switch sortType {
        case .bestMatch:
            if let bestMatchValue = restaurant.sortValues?.bestMatch {
                cell.sortValueLabel.isHidden = false
                cell.sortValueLabel.text = "Best match: \(bestMatchValue)"
            }
        case .deliveryCosts:
            if let deliveryCostsValue = restaurant.sortValues?.deliveryCosts {
                cell.sortValueLabel.isHidden = false
                cell.sortValueLabel.text = "Delivery costs: \(deliveryCostsValue)"
            }
        case .distance:
            if let distanceValue = restaurant.sortValues?.distance {
                cell.sortValueLabel.isHidden = false
                cell.sortValueLabel.text = "Distance: \(distanceValue)"
            }
        case .minCost:
            if let minCostValue = restaurant.sortValues?.minCost {
                cell.sortValueLabel.isHidden = false
                cell.sortValueLabel.text = "Min cost: \(minCostValue)"
            }
        case .newest:
            if let newestValue = restaurant.sortValues?.newest {
                cell.sortValueLabel.isHidden = false
                cell.sortValueLabel.text = "Newest: \(newestValue)"
            }
        case .popularity:
            if let popularityValue = restaurant.sortValues?.popularity {
                cell.sortValueLabel.isHidden = false
                cell.sortValueLabel.text = "Popularity: \(popularityValue)"
            }
        case .averageProductPrice:
            if let averageProductPriceValue = restaurant.sortValues?.averageProductPrice {
                cell.sortValueLabel.isHidden = false
                cell.sortValueLabel.text = "Average Product Price: \(averageProductPriceValue)"
            }
        case .ratingAverage:
            if let ratingAverageValue = restaurant.sortValues?.ratingAverage {
                cell.sortValueLabel.isHidden = false
                cell.sortValueLabel.text = "Rating average: \(ratingAverageValue)"
            }
        }
    }
}
