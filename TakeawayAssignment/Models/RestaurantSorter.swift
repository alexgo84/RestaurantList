//
//  RestaurantSorter.swift
//  TakeawayAssignment
//
//  Created by Alex Gordon on 21.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

protocol Sortable {
    var status: RestaurantStatus { get }
    var sortValues: SortValues? { get }
}

struct RestaurantSorter {
    var sortType: SortType
    
    public func sort(elements: [Restaurant]) -> [Restaurant] {
        return elements.sorted { (restaurant1, restaurant2) -> Bool in
            guard restaurant1.status == restaurant2.status else  {
                return restaurant1.status < restaurant2.status
            }
            guard let sortValues1 = restaurant1.sortValues else {
                return true
            }
            guard let sortValues2 = restaurant2.sortValues else {
                return false
            }
            return sortValues1.valueFor(sortType: sortType) < sortValues2.valueFor(sortType: sortType)
        }
    }

}
