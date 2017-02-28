//
//  TodoFilters.swift
//  RealmTodoApp
//
//  Created by Pedro Martin Gomez on 28/2/17.
//  Copyright © 2017 Pedro Martin Gomez. All rights reserved.
//

import UIKit
import RealmSwift

class TodoFilters: UIViewController {
    
    @IBOutlet weak var todoPriorityFilter: UISegmentedControl!
    @IBOutlet weak var todoDateFilter: UISegmentedControl!
    @IBOutlet weak var prioritySort: UISegmentedControl!
    
    var dateSortDirection: Bool = false
    var prioritySortDirection: Bool = false
    var priorityFilter: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }
    
    var todoInfosFiltered: Results<TodoInfo>?
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = "Filter/Sort"
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        let filterButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(applyFilter))
        self.navigationController?.navigationBar.topItem?.setLeftBarButton(cancelButton, animated: true)
        self.navigationController?.navigationBar.topItem?.setRightBarButton(filterButton, animated: true)
    }
    
    func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func applyFilter() {
        if let realm = try? Realm() {
            let todoInfos = realm.objects(TodoInfo.self)
            
            todoInfosFiltered = todoInfos.sorted(by: [
                SortDescriptor(keyPath: "priority", ascending: prioritySortDirection ),
                SortDescriptor(keyPath: "date", ascending: dateSortDirection),
                ])
        }
        
        dismissVC()
    }
    
    @IBAction func priorityFilterChanged(_ sender: Any) {
        
        let segmentedControl = sender as! UISegmentedControl
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            print("First Segment Selected")
        case 1:
            print("Second Segment Selected")
        case 2:
            print("Third Segment Selected")
        default:
            break
        }
        
    }

    @IBAction func dateFilterChanged(_ sender: Any) {
        let segmentedControl = sender as! UISegmentedControl
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            dateSortDirection = true
        case 1:
            dateSortDirection = false
        default:
            break
        }
    }
    
    @IBAction func prioritySortChanged(_ sender: Any) {
        let segmentedControl = sender as! UISegmentedControl
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            prioritySortDirection = true
        case 1:
            prioritySortDirection = false
        default:
            break
        }
    }
    
}
