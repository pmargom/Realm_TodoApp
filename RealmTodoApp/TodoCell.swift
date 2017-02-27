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
    
    var todoInfo: TodoInfo? {
        didSet {
            if let todoInfo = todoInfo {
                todoTitle.text = todoInfo.title
                //todoDate.text = todoInfo.date
                todoPriority.image = UIImage.init(imageLiteralResourceName: Priority.high.rawValue)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
