//
//  ExperinceactivityCell.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 11/08/25.
//

import UIKit
import Cosmos

class ExperinceactivityCell: UICollectionViewCell {
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var viewlayer: UIView!
    @IBOutlet weak var experinceImg: UIImageView!
    
    
    @IBOutlet weak var todayHours: UILabel!
    @IBOutlet weak var activityName: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var activity_price: UILabel!
    
    @IBOutlet weak var wishListImg: UIImageView!
    var likeBtn: (() -> ()) = {}

   
    
    @IBOutlet weak var heatBackView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewLayer()
        
        experinceImg.layer.cornerRadius = 10
        experinceImg.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        experinceImg.clipsToBounds = true
        
    }
    func setupViewLayer() {
        viewlayer.layer.cornerRadius = 10
        viewlayer.layer.borderWidth = 0.5
        viewlayer.layer.shadowColor = UIColor.gray.cgColor
        viewlayer.layer.shadowOffset = CGSize(width: 0, height: 0)
        viewlayer.layer.shadowRadius = 2
        viewlayer.layer.shadowOpacity = 0.3
        viewlayer.layer.masksToBounds = true
        
        
    }
    @IBAction func likeBtnAction(_ sender: UIButton) {
        likeBtn()
    }
}
