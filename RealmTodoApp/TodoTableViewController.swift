//
//  kk.swift
//  RealmTodoApp
//
//  Created by Pedro Martin Gomez on 27/2/17.
//  Copyright © 2017 Pedro Martin Gomez. All rights reserved.
//

import UIKit

final class TodoTableViewController: UITableViewController {
    var items: [TodoInfo]
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
        cell.parentTableViewController = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let todoInfoSelectedItem = items[indexPath.row]
        
        let todoInfoEditVC = TodoAddNew(nibName: "TodoAddNew", bundle: nil)
        todoInfoEditVC.todoInfo = todoInfoSelectedItem
        
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
            items.remove(at: deletionIndexPath.row)
            tableView.deleteRows(at: [deletionIndexPath], with: .fade)
        }
    }
    
}
