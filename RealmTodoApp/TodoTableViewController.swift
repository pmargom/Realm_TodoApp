//
//  kk.swift
//  RealmTodoApp
//
//  Created by Pedro Martin Gomez on 27/2/17.
//  Copyright © 2017 Pedro Martin Gomez. All rights reserved.
//

import UIKit
import RealmSwift

final class TodoTableViewController: UITableViewController {
    
    //var items: [TodoInfo]
    let nibId: String
    let cellId: String
    
    var items: Results<TodoInfo>!

    
    init(nibId: String, cellId: String, items: Results<TodoInfo>, style: UITableViewStyle) {
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
        return Int(items.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! TodoCell
        
        cell.todoInfo = items[indexPath.row] as TodoInfo
        cell.parentTableViewController = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let todoInfoSelectedItem = items[indexPath.row] as TodoInfo
        
        let todoInfoEditVC = TodoAddNew(nibName: "TodoAddNew", bundle: nil)
        todoInfoEditVC.todoId = todoInfoSelectedItem.todoId
        
        let todoAddNewVC = UINavigationController(rootViewController: todoInfoEditVC)
        self.navigationController?.present(todoAddNewVC, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // MARK: Private Methods
    private func registerCustomCell() {
        tableView.register(UINib(nibName: self.nibId, bundle: nil), forCellReuseIdentifier: self.cellId)
    }
    
    func deleteItem(cell: UITableViewCell) {
        
        if let deletionIndexPath = tableView.indexPath(for: cell) {
            let todoInfoToDelete = items[deletionIndexPath.row]
            let realm = try! Realm()
            try! realm.write {
                realm.delete(todoInfoToDelete)
            }
            tableView.deleteRows(at: [deletionIndexPath], with: .fade)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
}
