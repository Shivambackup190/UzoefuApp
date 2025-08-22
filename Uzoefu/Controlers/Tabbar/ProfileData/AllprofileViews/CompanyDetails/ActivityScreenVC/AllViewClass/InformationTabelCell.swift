//
//  InformationTabelCell.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 19/08/25.
//

import UIKit

class InformationTabelCell: UITableViewCell {

    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLable: UILabel!
    var minusButtom : (()->()) = {}
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func minusbtnAction(_ sender: UIButton) {
        minusButtom()
    }
    
}
