//
//  MessageCellTableViewCell.swift
//  ChatClient
//
//  Created by Mike Tehranian on 10/27/16.
//  Copyright © 2016 Mike Tehranian. All rights reserved.
//

import UIKit

class MessageCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var messageImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
