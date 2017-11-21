//
//  DataSource.swift
//  TakeawayAssignment
//
//  Created by Alex Gordon on 19.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

import UIKit

public protocol Identifiable {
    static func cellIdentifier() -> String
}

struct Section <T: Identifiable>{
    public var title: String?
    public let cellData: [T]
    
    init(title: String?, cellData: [T]) {
        self.title = title
        self.cellData = cellData
    }
}


class DataSource<T>: NSObject, UITableViewDataSource where T: Identifiable & Sortable {
    
    public var currentSortType: SortType = .bestMatch
    
    public var sections: [Section<T>] {
        didSet {
            if sections.count == 0 {
                fatalError("Cannot set less than one section")
            }
        }
    }
    
    override init() {
        guard T.self == Restaurant.self else {
            fatalError("Data source for type \(T.self) is not supported!")
        }
        
        self.sections = [Section<T>(title: nil, cellData: [])] // we should have at least one section 
        super.init()
    }
    
    public func clearData() {
        sections = [Section<T>(title: nil, cellData: [])]
    }
    
    
    //MARK: - <UITableViewDataSource>
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cellData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let genericCell = tableView.dequeueReusableCell(withIdentifier: T.cellIdentifier()) else {
            fatalError("Unknown Identifier")
        }
        
        let cellData: T = sections[indexPath.section].cellData[indexPath.row]
        
        switch T.cellIdentifier() {
        case Restaurant.cellIdentifier():
            guard let restaurant = cellData as? Restaurant,
                  let cell = genericCell as? RestaurantCell else {
                fatalError("Invalid data type '\(cellData)' or cell '\(genericCell)' provided for data source \(T.cellIdentifier())")
            }
            
            RestaurantCellConfigurator(restaurant: restaurant,
                                       sortType: currentSortType).configure(cell: cell)
            
        default:
            fatalError("Unknown identifier '\(T.cellIdentifier())'")
        }
        
        return genericCell
    }
}
