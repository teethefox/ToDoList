//
//  tableCell.swift
//  ToDoList
//
//  Created by Tiffani Fox on 11/14/17.
//  Copyright © 2017 Tiffani Fox. All rights reserved.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
