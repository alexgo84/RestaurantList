//
//  LocalService.swift
//  TakeawayAssignment
//
//  Created by Alex Gordon on 22.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

final class LocalService {
    func load<A>(resource: Resource<A>, completion: @escaping (A?, Error?) -> ()) {
        do {
            let restaurantsData = try Data(contentsOf: resource.url)
            let parsedData = try resource.parseFunction(restaurantsData)
            completion(parsedData, nil)
        } catch {
            completion(nil, error)
        }
    }
}
