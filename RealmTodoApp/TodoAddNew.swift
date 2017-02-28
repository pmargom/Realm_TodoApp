//
//  TodoAddNew.swift
//  RealmTodoApp
//
//  Created by Pedro Martin Gomez on 27/2/17.
//  Copyright © 2017 Pedro Martin Gomez. All rights reserved.
//

import UIKit
import RealmSwift

class TodoAddNew: UIViewController {

    @IBOutlet weak var todoTitle: UITextField!
    @IBOutlet weak var todoDescription: UITextView!
    @IBOutlet weak var todoPriorityValue: UILabel!
    @IBOutlet weak var todoPriority: UISlider!
    @IBOutlet weak var todoDate: UITextField!
    
    var todoId: String?
    let datePicker = UIDatePicker()
    
    private var todoInfo: TodoInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        createDatePicker()
        
        if todoId != nil {
            todoInfo = loadData(id: todoId!)
        }
        
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = todoId == nil ? "Add new" : "Edit todo"
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(storeDate))
        self.navigationController?.navigationBar.topItem?.setLeftBarButton(cancelButton, animated: true)
        self.navigationController?.navigationBar.topItem?.setRightBarButton(saveButton, animated: true)
    }
    
    func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addTodo() {
        
        if let realm = try? Realm(),
            let newTodoToStore = prepareDataToStore() {
            try! realm.write {
                realm.add(newTodoToStore)
            }
        }
    
    }
    
    func loadData(id: String) -> TodoInfo? {
        
        var todoInfoInDb: TodoInfo?
        
        if let realm = try? Realm(),
            let existingTodoToStore = realm.object(ofType: TodoInfo.self, forPrimaryKey: id as AnyObject) {
            
            self.todoTitle.text = existingTodoToStore.title
            self.todoDescription.text = existingTodoToStore.todoDescription
            self.todoDate.text = existingTodoToStore.date.asShortDate
            datePicker.setDate(existingTodoToStore.date, animated: false)
            
            switch existingTodoToStore.priority {
            case Priority.intermediate.rawValue:
                self.todoPriority.value = 1
                todoPriorityValue.text = Priority.intermediate.rawValue
            case Priority.high.rawValue:
                self.todoPriority.value = 2
                todoPriorityValue.text = Priority.high.rawValue
            default:
                self.todoPriority.value = 0
                todoPriorityValue.text = Priority.low.rawValue
            }
            
            todoInfoInDb = existingTodoToStore
        }
        
        return todoInfoInDb
    }
    
    func updateTodo(id: String) {
        
        if let todoModified = prepareDataToStore(),
            let realm = try? Realm(),
            let existingTodoToStore = realm.object(ofType: TodoInfo.self, forPrimaryKey: id as AnyObject) {
            try! realm.write {
                existingTodoToStore.date = todoModified.date
                existingTodoToStore.title = todoModified.title
                existingTodoToStore.todoDescription = todoModified.todoDescription
                existingTodoToStore.priority = todoModified.priority
            }
        }
    }
    
    func storeDate()  {

        if todoId == nil {
            addTodo()
        }
        else {
            updateTodo(id: self.todoId!)
        }
        
        dismissVC()
    }
    
    func createDatePicker() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(updateDate))
        toolBar.setItems([doneButton], animated: true)
        
        todoDate.inputAccessoryView = toolBar
        todoDate.inputView = datePicker
        
    }
    
    func updateDate() {
        self.todoDate.text = datePicker.date.asShortDate
        self.view.endEditing(true)
    }

    
    func prepareDataToStore() -> TodoInfo? {
        

        return TodoInfo(date: datePicker.date, title: (self.todoTitle?.text!)!, description: self.todoDescription.text, priority: self.todoPriorityValue.text.map { Priority(rawValue: $0) }!)
        
    }
    
    @IBAction func changePriority(_ sender: UISlider) {
        
        let intValue = Int(sender.value)
        
        switch intValue {
        case 1:
            todoPriorityValue.text = Priority.intermediate.rawValue
        case 2:
            todoPriorityValue.text = Priority.high.rawValue
        default:
            todoPriorityValue.text = Priority.low.rawValue
        }
    }

}
