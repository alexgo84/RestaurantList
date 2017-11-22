//
//  SortTypeButton.swift
//  TakeawayAssignment
//
//  Created by Alex Gordon on 22.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation
import UIKit

class SortTypeButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(sortType: SortType) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        isSelected = false

        contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10)
        setTitle(sortType.toString(), for: .normal)
        tag = sortType.rawValue
        sizeToFit()
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = UIColor.gray
            } else {
                backgroundColor = UIColor.lightGray
            }
        }
    }
}
