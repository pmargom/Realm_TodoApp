//
//  AppDelegate.swift
//  RealmTodoApp
//
//  Created by Pedro Martin Gomez on 27/2/17.
//  Copyright © 2017 Pedro Martin Gomez. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var todoItems: Results<TodoInfo>!
    var navigationVC: UINavigationController = UINavigationController()
    var todoTableVC: TodoTableViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.backgroundColor = UIColor.white
        
        initRealm()
        
        todoTableVC = TodoTableViewController(nibId: "TodoCell", cellId: "TodoCellId", items: todoItems!, style: .plain)
        todoTableVC?.dataFilterDelegate = self
        
        navigationVC = UINavigationController(rootViewController: todoTableVC!)
        navigationVC.navigationBar.topItem?.title = "Realm TODO APP"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
        let filterButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(filterTodos))
        navigationVC.navigationBar.topItem?.setLeftBarButton(filterButton, animated: true)
        navigationVC.navigationBar.topItem?.setRightBarButton(addButton, animated: true)
        
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()

        return true
    }
    
    func addTodo() {
        let todoAddNewVC = UINavigationController(rootViewController: TodoAddNew(nibName: "TodoAddNew", bundle: nil))
        navigationVC.present(todoAddNewVC, animated: true)
    }
    
    func filterTodos() {
        let todoFilterVC = TodoFilters(nibName: "TodoFilters", bundle: nil)
        todoFilterVC.filterDelegate = self
        let rootFiltersVC = UINavigationController(rootViewController: todoFilterVC)
        navigationVC.present(rootFiltersVC, animated: true)
    }
    
    func initRealm() {
        let realm = try! Realm()
        todoItems = realm.objects(TodoInfo.self)
    }

}

extension AppDelegate: FilterControllerDelegate {
    
    func back(_ todoItems: Results<TodoInfo>) {
        todoTableVC?.back(todoItems)
    }
    
}

