//
//  ChatCell.swift
//  WhatsAppDelete
//
//  Created by Faraz on 16/12/18.
//  Copyright © 2018 Faraz. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var contactImageView: UIImageView!
    
    var index : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        if editing {
            selectionStyle = (index % 2 == 0) ? .blue : .none
        } else {
            selectionStyle = .gray
        }
    }
    
}
