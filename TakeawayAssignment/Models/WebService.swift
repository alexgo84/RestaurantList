//
//  WebService.swift
//  TakeawayAssignment
//
//  Created by Alex Gordon on 19.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

final class WebService {
    func load<A>(resource: Resource<A>, completion: @escaping (A?, Error?) -> ()) {
        URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                let parsedData = try resource.parseFunction(data)
                completion(parsedData, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
