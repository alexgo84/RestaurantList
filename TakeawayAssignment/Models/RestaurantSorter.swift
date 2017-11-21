//
//  RestaurantSorter.swift
//  TakeawayAssignment
//
//  Created by Alex Gordon on 21.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

protocol Sortable {
    var sortValues: SortValues? { get }
}

protocol Sorting {
    var sortType: SortType { get set }
    func sort(elements: [Sortable]) -> [Sortable]
}

extension Sorting {
    public func sort(elements: [Sortable]) -> [Sortable] {
        return elements.sorted { (element1, element2) -> Bool in
            guard let sortValues1 = element1.sortValues else {
                return true
            }
            guard let sortValues2 = element2.sortValues else {
                return false
            }
            return sortValues1.valueFor(sortType: sortType) < sortValues2.valueFor(sortType: sortType)
        }
    }
}

struct RestaurantSorter: Sorting {
    var sortType: SortType
}
