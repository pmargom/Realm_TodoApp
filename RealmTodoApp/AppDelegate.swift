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
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }

    func setupMockData() -> [TodoInfo] {
        
        return [
            TodoInfo(date: Date(), title: "Title 01", description: "Description 01", priority: nil),
            TodoInfo(date: Date(), title: "Title 02", description: "Description 02", priority: Priority.low),
            TodoInfo(date: Date(), title: "Title 03", description: "Description 03", priority: Priority.intermediate),
            TodoInfo(date: Date(), title: "Title 04", description: "Description 04", priority: Priority.intermediate),
            TodoInfo(date: Date(), title: "Title 05", description: "Description 05", priority: Priority.high),
            TodoInfo(date: Date(), title: "Title 06", description: "Description 06", priority: Priority.high),
            TodoInfo(date: Date(), title: "Title 07", description: "Description 07", priority: nil),
            TodoInfo(date: Date(), title: "Title 08", description: "Description 08", priority: nil),
            TodoInfo(date: Date(), title: "Title 09", description: "Description 09", priority: nil),
            TodoInfo(date: Date(), title: "Title 10", description: "Description 10", priority: nil)
        ]
    }

}

