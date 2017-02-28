//
//  FilterAndOrder.swift
//  RealmTodoApp
//
//  Created by Pedro Martin Gomez on 28/2/17.
//  Copyright © 2017 Pedro Martin Gomez. All rights reserved.
//

import Foundation

enum SortDirection: Int {
    case Ascending = 0
    case Descending = 1
}

enum FilterAndOrderKeys: String {
    case priorityFilter = "priorityFilter"
    case prioritySortDirection = "prioritySortDirection"
    case dateFilterSortDirection = "dateFilterSortDirection"
}

class FilterAndOrder: NSObject, NSCoding {
    
    var priorityFilter: String
    var prioritySortDirection: SortDirection?
    var dateFilterSortDirection: SortDirection?
    
    init(priorityFilter: String, prioritySortDirection: SortDirection?, dateFilterSortDirection: SortDirection?) {
        self.priorityFilter = priorityFilter
        self.prioritySortDirection = prioritySortDirection
        self.dateFilterSortDirection = dateFilterSortDirection
    }
    
    required init(coder aDecoder: NSCoder) {
        
        let priorityFilter = aDecoder.decodeObject(forKey: FilterAndOrderKeys.priorityFilter.rawValue) as? String
        self.priorityFilter = priorityFilter!
        
        if let prioritySortDirection = aDecoder.decodeObject(forKey: FilterAndOrderKeys.prioritySortDirection.rawValue) as? Int {
            self.prioritySortDirection = prioritySortDirection == 0 ? SortDirection.Ascending : SortDirection.Descending
        }
        if let dateFilterSortDirection = aDecoder.decodeObject(forKey: FilterAndOrderKeys.dateFilterSortDirection.rawValue) as? Int {
            self.dateFilterSortDirection = dateFilterSortDirection == 0 ? SortDirection.Ascending : SortDirection.Descending
        }

    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(priorityFilter, forKey: FilterAndOrderKeys.priorityFilter.rawValue)
        
        if let prioritySortDirection = self.prioritySortDirection {
            aCoder.encode(prioritySortDirection.rawValue, forKey: FilterAndOrderKeys.prioritySortDirection.rawValue)
        }
        if let dateFilterSortDirection = self.dateFilterSortDirection {
            aCoder.encode(dateFilterSortDirection.rawValue, forKey: FilterAndOrderKeys.dateFilterSortDirection.rawValue)
        }
        
    }
    
}
