//
//  AppDelegate.swift
//  RealmTodoApp
//
//  Created by Pedro Martin Gomez on 27/2/17.
//  Copyright © 2017 Pedro Martin Gomez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var todoItems: [TodoInfo] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.backgroundColor = UIColor.white
        
        todoItems = setupMockData()
        
        let todoTableVC = TodoTableViewController(nibId: "TodoCell", cellId: "TodoCellId", items: todoItems, style: .plain)
        
        let navigationController = UINavigationController(rootViewController: todoTableVC)
        navigationController.navigationBar.topItem?.title = "Realm TODO APP"
//        navigationController
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }

    func setupMockData() -> [TodoInfo] {
        
        let today = Date()
        let intervalDays = 60 * 60 * 24

        return [
            TodoInfo(date: Date(timeInterval: TimeInterval(-1 * intervalDays), since: today), title: "Title 01", description: "Description 01", priority: nil),
            TodoInfo(date: Date(timeInterval: TimeInterval(-100 * intervalDays), since: today), title: "Title 02", description: "Description 02", priority: Priority.low),
            TodoInfo(date: Date(timeInterval: TimeInterval(-80 * intervalDays), since: today), title: "Title 03", description: "Description 03", priority: Priority.intermediate),
            TodoInfo(date: Date(timeInterval: TimeInterval( -30 * intervalDays), since: today), title: "Title 04", description: "Description 04", priority: Priority.intermediate),
            TodoInfo(date: Date(timeInterval: TimeInterval(-43 * intervalDays), since: today), title: "Title 05", description: "Description 05", priority: Priority.high),
            TodoInfo(date: Date(timeInterval: TimeInterval(0 * intervalDays), since: today), title: "Title 06", description: "Description 06", priority: Priority.high),
            TodoInfo(date: Date(timeInterval: TimeInterval(-100 * intervalDays), since: today), title: "Title 07", description: "Description 07", priority: nil),
            TodoInfo(date: Date(timeInterval: TimeInterval(-60 * intervalDays), since: today), title: "Title 08", description: "Description 08", priority: nil),
            TodoInfo(date: Date(timeInterval: TimeInterval(-80 * intervalDays), since: today), title: "Title 09", description: "Description 09", priority: nil),
            TodoInfo(date: Date(timeInterval: TimeInterval(-120 * intervalDays), since: today), title: "Title 10", description: "Description 10", priority: nil)
        ]
    }

}

