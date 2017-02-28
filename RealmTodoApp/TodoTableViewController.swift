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
    
    private let nibId: String
    private let cellId: String
    
    var items: Results<TodoInfo>!
    var subscription: NotificationToken?
    
    var dataFilterDelegate: FilterControllerDelegate?

    init(nibId: String, cellId: String, items: Results<TodoInfo>, style: UITableViewStyle) {
        self.nibId = nibId
        self.cellId = cellId
        self.items = items
        super.init(style:style)
        self.registerCustomCell()
        subscription = notificationSubscription(items: self.items)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func notificationSubscription(items: Results<TodoInfo>) -> NotificationToken {
        return items.addNotificationBlock {[weak self] (changes: RealmCollectionChange<Results<TodoInfo>>) in
            self?.updateUI(changes: changes)
        }
    }
    
    func updateUI(changes: RealmCollectionChange<Results<TodoInfo>>) {
        switch changes {
        case .initial(_):
            tableView.reloadData()
        case .update(_, let deletions, let insertions, _):
            
            tableView.beginUpdates()

            tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
            tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
            
            tableView.endUpdates()
            break
        case .error(let error):
            print(error)
        }
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
    
}

extension TodoTableViewController: FilterControllerDelegate {
    
    func back(_ todoItems: Results<TodoInfo>) {
        self.items = todoItems
        subscription = notificationSubscription(items: self.items)
    }
    
}











