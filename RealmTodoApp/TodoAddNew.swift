//
//  TodoAddNew.swift
//  RealmTodoApp
//
//  Created by Pedro Martin Gomez on 27/2/17.
//  Copyright © 2017 Pedro Martin Gomez. All rights reserved.
//

import UIKit

class TodoAddNew: UIViewController {

    @IBOutlet weak var todoTitle: UITextField!
    @IBOutlet weak var todoDescription: UITextView!
    @IBOutlet weak var todoPriorityValue: UILabel!
    @IBOutlet weak var todoPriority: UISlider!
    @IBOutlet weak var todoDate: UITextField!
    
    var todoInfo: TodoInfo?
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        createDatePicker()
        loadData()
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = todoInfo == nil ? "Add new" : "Edit todo"
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTodo))
        self.navigationController?.navigationBar.topItem?.setLeftBarButton(cancelButton, animated: true)
        self.navigationController?.navigationBar.topItem?.setRightBarButton(saveButton, animated: true)
    }
    
    func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveTodo() {
        
        let alert = UIAlertController(title: "Alert", message: "Adding todo", preferredStyle: .alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.navigationController?.present(alert, animated: true, completion: nil)
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
    
    func loadData() {
        guard let model = todoInfo else {
            return
        }
        
        self.todoTitle.text = model.title
        self.todoDescription.text = model.description
        self.todoDate.text = model.date.asShortDate
        datePicker.setDate(model.date, animated: false)
        
        switch model.priority {
        case Priority.intermediate:
            self.todoPriority.value = 1
            todoPriorityValue.text = Priority.intermediate.rawValue
        case Priority.high:
            self.todoPriority.value = 2
            todoPriorityValue.text = Priority.high.rawValue
        default:
            self.todoPriority.value = 0
            todoPriorityValue.text = Priority.low.rawValue
        }
        
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
