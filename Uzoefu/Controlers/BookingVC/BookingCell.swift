//
//  BookingCell.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 20/08/25.
//

import UIKit

class BookingCell: UITableViewCell {
    
    @IBOutlet weak var bookingImg: UIImageView!
    @IBOutlet weak var viewlayer: UIView!
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var activityName: UILabel!
    
    @IBOutlet weak var reebookBtn: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    var reebookBtnAction:(()->()) = {}
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewLayer()
        bookingImg.layer.cornerRadius = 5
    }
    
    func setupViewLayer() {
        viewlayer.layer.cornerRadius = 10
        viewlayer.layer.borderWidth = 0.5
        viewlayer.layer.shadowColor = UIColor.gray.cgColor
        viewlayer.layer.shadowOffset = CGSize(width: 0, height: 0)
        viewlayer.layer.shadowRadius = 2
        viewlayer.layer.shadowOpacity = 0.3
        viewlayer.layer.masksToBounds = false
        
        
    }
    
    @IBAction func reebookButtonAction(_ sender: UIButton) {
        reebookBtnAction()
    }
}
