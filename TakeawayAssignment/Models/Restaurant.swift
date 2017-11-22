//
//  Restaurant.swift
//  TakeawayAssignment
//
//  Created by Alex Gordon on 19.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

public enum RestaurantStatus: Int {
    case open
    case orderAhead
    case closed
    case unknown
    
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
}

struct Restaurant: Identifiable, Sortable {
    var sortValues: SortValues?
    let name: String
    let status: RestaurantStatus
    
    static func cellIdentifier() -> String {
        return "RestaurantCell"
    }
}

extension Restaurant {
    
    init?(json: JSONDict) {
        guard
            let name = json["name"] as? String,
            let status = json["status"] as? String,
            let sortingValuesJSON = json["sortingValues"] as? JSONDict else {
            print("FAIL: invalid data in restaurant JSON: \(json)")
            return nil
        }
        
        self.name = name
        self.status = RestaurantStatus(string: status)
        
        if let sortingValues = SortValues(json: sortingValuesJSON) {
            self.sortValues = sortingValues
        } else {
            self.sortValues = nil
        }
    }
}

extension Restaurant {
    private static func defaultParseMethod(data: Data) throws -> [Restaurant]? {
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
                let restaurantsJSON = json["restaurants"] as? [JSONDict]
                return restaurantsJSON?.flatMap(Restaurant.init)
            }
        } catch {
            throw error
        }
        return nil
    }
    
    static let allFromStub = Resource<[Restaurant]>(url: JSONURL.restaurants.urlToLocalStub()) { data in
        return try defaultParseMethod(data: data)
    }
    
    static let allFromRemote = Resource<[Restaurant]>(url: JSONURL.restaurants.urlToRemote()) { data in
        return try defaultParseMethod(data: data)
    }
}

