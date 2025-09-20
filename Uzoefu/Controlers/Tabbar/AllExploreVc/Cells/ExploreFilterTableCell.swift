//
//  ExploreFilterTableCell.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 12/08/25.
//

import UIKit
import Cosmos

class ExploreFilterTableCell: UITableViewCell {
    
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var searchimg: UIImageView!
    @IBOutlet weak var viewlayer: UIView!
    
    @IBOutlet weak var todayHours: UILabel!
    
    @IBOutlet weak var activityName: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var activity_price: UILabel!
    
    @IBOutlet weak var wishListImg: UIImageView!
    var likeBtn :(()->()) = {}
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewLayer()
        
        
        searchimg.layer.cornerRadius = 10
        searchimg.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        searchimg.clipsToBounds = true
        
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
    
    @IBAction func likeBtnaction(_ sender: UIButton) {
        likeBtn()
    }
}
    

