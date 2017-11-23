//
//  Resource.swift
//  TakeawayAssignment
//
//  Created by Alex Gordon on 19.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

public typealias JSONDict = [String: AnyObject]

enum JSONURL {
    case restaurants
    
    func urlToLocalStub() -> URL {
        switch self {
        case .restaurants:
            let localStubName = "sample iOS"
            guard let url = Bundle.main.url(forResource: localStubName, withExtension: "json") else {
                fatalError("FAIL: couldn't find '\(localStubName)' JSON data on main bundle")
            }
            return url
        }
    }
    
    func urlToRemote() -> URL {
        switch self {
        case .restaurants:
            // When we want to fetch from remote - return here the URL for the REST API that returns
            // the restaurants JSON data
            fatalError("Not implemented!")
        }
    }
}

struct Resource<T> {
    let url: URL
    let parseFunction: (Data) throws -> T?
}
