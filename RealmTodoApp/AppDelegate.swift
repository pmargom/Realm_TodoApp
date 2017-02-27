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

    
    final class TodoTableViewController: UITableViewController {
        let items: [TodoInfo]
        let nibId: String
        let cellId: String
        
        init(nibId: String, cellId: String, items: [TodoInfo], style: UITableViewStyle) {
            self.nibId = nibId
            self.cellId = cellId
            self.items = items
            super.init(style:style)
            self.registerCustomCell()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! TodoCell
            
            cell.todoInfo = items[indexPath.row]
            
            return cell
        }
        
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
        
        // MARK: Private Methods
        private func registerCustomCell() {
            tableView.register(UINib(nibName: self.nibId, bundle: nil), forCellReuseIdentifier: self.cellId)
        }
        
        
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

