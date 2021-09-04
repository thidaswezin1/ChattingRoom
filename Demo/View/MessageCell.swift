//
//  MessageCell.swift
//  Demo
//
//  Created by ISGM on 02/09/2021.
//  Copyright © 2021 thida. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var youImageView: UIImageView!
    @IBOutlet weak var meImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var messageView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageView.layer.cornerRadius = messageView.frame.size.height/10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
