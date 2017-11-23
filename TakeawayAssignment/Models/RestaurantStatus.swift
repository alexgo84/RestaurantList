//
//  RestaurantStatus.swift
//  TakeawayAssignment
//
//  Created by Alex Gordon on 22.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

public enum RestaurantStatus: Int {
    case unknown = 0
    case closed = 1
    case orderAhead = 2
    case open = 3
    
    init(string: String) {
        switch string.lowercased() {
        case "open"        : self = RestaurantStatus.open
        case "order ahead" : self = RestaurantStatus.orderAhead
        case "closed"      : self = RestaurantStatus.closed
        default            : self = RestaurantStatus.unknown
        }
    }
    
    public func toString() -> String {
        switch self {
        case .open      : return "Open"
        case .orderAhead: return "Order ahead"
        case .closed    : return "Closed"
        case .unknown   : return "Unknown"
        }
    }
}

extension RestaurantStatus: Equatable {
    static func <(lhs: RestaurantStatus, rhs: RestaurantStatus) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    static func >(lhs: RestaurantStatus, rhs: RestaurantStatus) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
}
