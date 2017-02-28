//
//  TodoFilters.swift
//  RealmTodoApp
//
//  Created by Pedro Martin Gomez on 28/2/17.
//  Copyright © 2017 Pedro Martin Gomez. All rights reserved.
//

import UIKit
import RealmSwift

protocol FilterControllerDelegate {
    func back(_ todoItems: Results<TodoInfo>)
}

class TodoFilters: UIViewController {
    
    @IBOutlet weak var todoPriorityFilter: UISegmentedControl!
    @IBOutlet weak var todoDateFilter: UISegmentedControl!
    @IBOutlet weak var prioritySort: UISegmentedControl!
    
    var filterDelegate: FilterControllerDelegate?
    private var filterAndOrder: FilterAndOrder?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        filterAndOrder = loadFilterAndOrder()
        setupNavigationBar()
    }
    
    private var todoInfosFiltered: Results<TodoInfo>?
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = "Filter/Sort"
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        let filterButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(applyFilter))
        self.navigationController?.navigationBar.topItem?.setLeftBarButton(cancelButton, animated: true)
        self.navigationController?.navigationBar.topItem?.setRightBarButton(filterButton, animated: true)
    }
    
    func dismissVC() {
        
        if (todoInfosFiltered != nil) {
            self.filterDelegate?.back(todoInfosFiltered!)
        }
        
        if filterAndOrder != nil {
            saveFilterAndOrder(filterAndOrder: filterAndOrder!)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func applyFilter() {
        if let realm = try? Realm() {
            let todoInfos = realm.objects(TodoInfo.self)
            
            todoInfosFiltered = todoInfos.sorted(by: [
                SortDescriptor(keyPath: "priority",
                               ascending: filterAndOrder?.prioritySortDirection == SortDirection.Ascending
                                ? true
                                : false),
                SortDescriptor(keyPath: "date",
                               ascending: filterAndOrder?.dateFilterSortDirection == SortDirection.Ascending
                                ? true
                                : false),
                ])
        }
        
        dismissVC()
    }
    
    @IBAction func priorityFilterChanged(_ sender: Any) {
        
        let segmentedControl = sender as! UISegmentedControl
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            filterAndOrder?.priorityFilter = Priority.low.rawValue
        case 1:
            filterAndOrder?.priorityFilter = Priority.intermediate.rawValue
        case 2:
            filterAndOrder?.priorityFilter = Priority.high.rawValue
        default:
            break
        }
        
    }

    @IBAction func dateFilterChanged(_ sender: Any) {
        let segmentedControl = sender as! UISegmentedControl
        
        filterAndOrder?.dateFilterSortDirection = segmentedControl.selectedSegmentIndex == 0 ? .Ascending : .Descending
        
    }
    
    @IBAction func prioritySortChanged(_ sender: Any) {
        let segmentedControl = sender as! UISegmentedControl
        
        filterAndOrder?.prioritySortDirection = segmentedControl.selectedSegmentIndex == 0 ? .Ascending : .Descending
        
    }
    
}
