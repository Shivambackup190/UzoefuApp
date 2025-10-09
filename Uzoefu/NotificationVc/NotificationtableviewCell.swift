//
//  NotificationtableviewCell.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 11/09/25.
//

import UIKit

class NotificationtableviewCell: UITableViewCell {
    @IBOutlet weak var seenBtn: UIImageView!
    
    @IBOutlet weak var notifivationtittle: UILabel!
    
    @IBOutlet weak var durationLable: UILabel!
    var deleteBtn: (()->()) = {}
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    @IBAction func deleteBtnAction(_ sender: UIButton) {
        deleteBtn()
    }
    
}
