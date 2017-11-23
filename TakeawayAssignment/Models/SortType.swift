//
//  SortType.swift
//  TakeawayAssignment
//
//  Created by Alex Gordon on 22.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

public enum SortType: Int {
    case bestMatch = 0
    case newest
    case ratingAverage
    case distance
    case popularity
    case averageProductPrice
    case deliveryCosts
    case minCost
    
    public static func allValues() -> [SortType] {
        return [self.bestMatch,
                self.newest,
                self.ratingAverage,
                self.distance,
                self.popularity,
                self.averageProductPrice,
                self.deliveryCosts,
                self.minCost]
    }
    
    public func toString() -> String {
        switch self {
        case .bestMatch         : return "Best Match"
        case .newest            : return "Newest"
        case .ratingAverage     : return "Average Rating"
        case .distance          : return "Distance"
        case .popularity        : return "Popularity"
        case .averageProductPrice: return "Avg. Product Price"
        case .deliveryCosts     : return "Delivery Costs"
        case .minCost           : return "Min Cost"
        }
    }
    
    public func sortAscending() -> Bool {
        switch self {
            case .bestMatch, .newest, .ratingAverage, .popularity:
                return false
            case .distance, .averageProductPrice, .deliveryCosts, .minCost:
                return true
        }
    }
}
