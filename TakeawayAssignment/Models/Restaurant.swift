//
//  Restaurant.swift
//  TakeawayAssignment
//
//  Created by Alex Gordon on 19.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

public struct Restaurant: Identifiable, Sortable {
    var sortValues: SortValues?
    let name: String
    let status: RestaurantStatus
    
    public static func cellIdentifier() -> String {
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
            if let json = try JSONSerialization.jsonObject(with: data) as? JSONDict {
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

