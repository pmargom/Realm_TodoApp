//
//  TodoInfo.swift
//  RealmTodoApp
//
//  Created by Pedro Martin Gomez on 27/2/17.
//  Copyright © 2017 Pedro Martin Gomez. All rights reserved.
//

import Foundation
import RealmSwift

enum Priority: String {
    case low
    case intermediate
    case high
}

class TodoInfo: Object {
    
    dynamic var todoId = NSUUID().uuidString
    
    dynamic var date = Date()
    dynamic var title = ""
    dynamic var todoDescription = ""
    dynamic var priority = Priority.low.rawValue
    
    override class func primaryKey() -> String? {
        return "todoId"
    }
    
    override class func indexedProperties() -> [String] {
        return ["done"]
    }
    
    convenience init(date: Date, title: String, description: String, priority: Priority?) {
        self.init()
        self.date = date
        self.title = title
        self.todoDescription = description
        self.priority = priority.map { $0.rawValue }!
    }
}
