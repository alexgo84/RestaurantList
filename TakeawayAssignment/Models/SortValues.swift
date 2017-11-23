//
//  SortValues.swift
//  TakeawayAssignment
//
//  Created by Alex Gordon on 21.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

public struct SortValues {
    let bestMatch: Double
    let newest: Double
    let ratingAverage: Double
    let distance: Double
    let popularity: Double
    let averageProductPrice: Double
    let deliveryCosts: Double
    let minCost: Double
}

extension SortValues {

    init?(json: JSONDict) {
        guard
            let bestMatch =             json["bestMatch"] as?           Double,
            let newest =                json["newest"] as?              Double,
            let ratingAverage =         json["ratingAverage"] as?       Double,
            let distance =              json["distance"] as?            Double,
            let popularity =            json["popularity"] as?          Double,
            let averageProductPrice =   json["averageProductPrice"] as? Double,
            let deliveryCosts =         json["deliveryCosts"] as?       Double,
            let minCost =               json["minCost"] as?             Double else {
                print("FAIL: invalid data in restaurant sorting values JSON: \(json)")
                return nil
        }
        
        self.bestMatch = bestMatch
        self.newest = newest
        self.ratingAverage = ratingAverage
        self.distance = distance
        self.popularity = popularity
        self.averageProductPrice = averageProductPrice
        self.deliveryCosts = deliveryCosts
        self.minCost = minCost
    }
    
    public func valueFor(sortType: SortType) -> Double {
        switch sortType {
        case .bestMatch:
            return bestMatch
        case .newest:
            return newest
        case .ratingAverage:
            return ratingAverage
        case .distance:
            return distance
        case .popularity:
            return popularity
        case .averageProductPrice:
            return averageProductPrice
        case .deliveryCosts:
            return deliveryCosts
        case .minCost:
            return minCost
        }
    }
    
    public func compare(sortValues: SortValues, sortType: SortType) -> Bool {
        if sortType.sortAscending() {
            return self.valueFor(sortType: sortType) < sortValues.valueFor(sortType: sortType)
        } else {
            return self.valueFor(sortType: sortType) > sortValues.valueFor(sortType: sortType)
        }
    }
}
