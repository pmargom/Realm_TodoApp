//
//  TodoCellTableViewCell.swift
//  RealmTodoApp
//
//  Created by Pedro Martin Gomez on 27/2/17.
//  Copyright © 2017 Pedro Martin Gomez. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {
    
    @IBOutlet weak var todoTitle: UILabel!
    @IBOutlet weak var todoPriority: UIImageView!
    @IBOutlet weak var todoDate: UILabel!
    
    var parentTableViewController: TodoTableViewController?
    
    var todoInfo: TodoInfo? {
        didSet {
            if let todoInfo = todoInfo {
                todoTitle.text = todoInfo.title
                todoDate.text = todoInfo.date.asShortDate
                todoPriority.image = UIImage.init(imageLiteralResourceName: todoInfo.priority.rawValue)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func deleteItem(_ sender: Any) {
//        let alert = UIAlertController(title: "Alert", message: "Adding todo", preferredStyle: .alert)
//        
//        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
//            self.parentTableViewController?.deleteItem(cell: self)
//        }
//        
//        alert.addAction(okAction)
//        alert.addAction(cancelAction)
//        
//        self.parentTableViewController?.present(alert, animated: true, completion: nil)
        
        self.parentTableViewController?.deleteItem(cell: self)
        
    }
}
