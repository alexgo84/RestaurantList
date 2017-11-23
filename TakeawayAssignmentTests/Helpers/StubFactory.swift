//
//  StubFactory.swift
//  TakeawayAssignmentTests
//
//  Created by Alex Gordon on 23.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation
@testable import TakeawayAssignment

struct StubFactory {
    func restaurantsFromStub() -> [Restaurant] {
        let url = Bundle.main.url(forResource: "sample iOS", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data) as! JSONDict
        let restaurantsJSON = json["restaurants"] as! [JSONDict]
        return restaurantsJSON.flatMap(Restaurant.init)
    }
}
