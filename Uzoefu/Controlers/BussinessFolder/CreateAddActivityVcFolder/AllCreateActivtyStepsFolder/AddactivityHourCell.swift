//
//  AddactivityHourCell.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 02/09/25.
//

import UIKit
protocol OperatingHoursCellDelegate: AnyObject {
    func didTapSelectButton(in cell: AddactivityHourCell)
}

class AddactivityHourCell: UITableViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var startTimeField: UILabel!

    @IBOutlet weak var endTimeField: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    weak var delegate: OperatingHoursCellDelegate?
       
    
    override func awakeFromNib() {
        super.awakeFromNib()
     

    updateButton(isSelected: false)
     }
     
     func updateButton(isSelected: Bool) {
         if isSelected {
             selectButton.setImage(UIImage(named: "plusIcon"), for: .normal)
         } else {
             selectButton.setImage(UIImage(named: "plusIcon"), for: .normal)
         }
             
     }
  
     @IBAction func selectButtonTapped(_ sender: UIButton) {
         delegate?.didTapSelectButton(in: self)
     }
 }


