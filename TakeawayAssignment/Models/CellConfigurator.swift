//
//  CellConfigurator.swift
//  TakeawayAssignment
//
//  Created by Alex Gordon on 19.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

protocol CellConfigurator {
    func configure(cell: RestaurantCell)
}

struct RestaurantCellConfigurator {
    let restaurant: Restaurant
    let sortType: SortType
    
    func configure(cell: RestaurantCell) {
        cell.nameLabel.text = restaurant.name
        cell.statusLabel.text = restaurant.status.toString()
        configureSortValue(cell: cell)
        cell.layoutSubviews()
    }
}

private extension RestaurantCellConfigurator {
    private func configureSortValue(cell: RestaurantCell) {
        
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
