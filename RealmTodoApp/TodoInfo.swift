//
//  TodoInfo.swift
//  RealmTodoApp
//
//  Created by Pedro Martin Gomez on 27/2/17.
//  Copyright © 2017 Pedro Martin Gomez. All rights reserved.
//

import Foundation

enum Priority: String {
    case low
    case intermediate
    case high
}

struct TodoInfo {
    let date: Date
    let title: String
    let description: String
    let priority: Priority
    
    init(date: Date, title: String, description: String, priority: Priority?) {
        self.date = date
        self.title = title
        self.description = description
        self.priority = priority ?? Priority.low
    }
}
