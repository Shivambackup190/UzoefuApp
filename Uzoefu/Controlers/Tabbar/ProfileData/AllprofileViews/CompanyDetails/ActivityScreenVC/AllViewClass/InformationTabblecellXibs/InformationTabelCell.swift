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

    @IBOutlet weak var mondayLbl: UILabel!
    @IBOutlet weak var tuesdayLbl: UILabel!
    
    @IBOutlet weak var wednesdayLbl: UILabel!
    @IBOutlet weak var thrusdayLbl: UILabel!
    
    @IBOutlet weak var fidayLbl: UILabel!
    
    @IBOutlet weak var saturdayLbl: UILabel!
    
    @IBOutlet weak var sundayLbl: UILabel!
    
    @IBOutlet weak var publicLbl: UILabel!
    
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
