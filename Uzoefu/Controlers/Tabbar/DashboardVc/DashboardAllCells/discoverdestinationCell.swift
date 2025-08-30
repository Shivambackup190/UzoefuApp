//
//  discoverdestinationCell.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 11/08/25.
//

import UIKit

class discoverdestinationCell: UICollectionViewCell {
    @IBOutlet weak var dasboradImg: UIImageView!
    
    @IBOutlet weak var viewlayer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewLayer()
        dasboradImg.cornerRadius = 10
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
    
}
