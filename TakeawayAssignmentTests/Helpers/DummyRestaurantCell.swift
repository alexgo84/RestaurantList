//
//  DummyRestaurantCell.swift
//  TakeawayAssignmentTests
//
//  Created by Alex Gordon on 23.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation
import UIKit
@testable import TakeawayAssignment

class DummyRestaurantCell: RestaurantCell {
    var dummyNameLabel: UILabel!
    override var nameLabel: UILabel! {
        set {
            dummyNameLabel = newValue
        }
        get {
            return dummyNameLabel
        }
    }
    
    var dummyStatusLabel: UILabel!
    override var statusLabel: UILabel! {
        set {
            dummyStatusLabel = newValue
        }
        get {
            return dummyStatusLabel
        }
    }
    
    var dummySortValueLabel: UILabel!
    override var sortValueLabel: UILabel! {
        set {
            dummySortValueLabel = newValue
        }
        get {
            return dummySortValueLabel
        }
    }
    
    init() {
        super.init(style: .default, reuseIdentifier: Restaurant.cellIdentifier())
        self.statusLabel = UILabel()
        self.nameLabel = UILabel()
        self.sortValueLabel = UILabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
