//
//  Utils.swift
//  RealmTodoApp
//
//  Created by Pedro Martin Gomez on 27/2/17.
//  Copyright © 2017 Pedro Martin Gomez. All rights reserved.
//

import Foundation

extension Date {
    
    var asShortDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.string(from: self)
    }
    
}

func saveFilterAndOrder(filterAndOrder: FilterAndOrder) {

    let encodedData = NSKeyedArchiver.archivedData(withRootObject: filterAndOrder)
    UserDefaults.standard.set(encodedData, forKey: "filterAndOrder")

}

func loadFilterAndOrder() -> FilterAndOrder {

    if let data = UserDefaults.standard.object(forKey: "filterAndOrder") {
        let filterAndOrder = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
        return FilterAndOrder(priorityFilter: "", prioritySortDirection: nil, dateFilterSortDirection: nil)
    }
    
    return FilterAndOrder(priorityFilter: "", prioritySortDirection: nil, dateFilterSortDirection: nil)
}


