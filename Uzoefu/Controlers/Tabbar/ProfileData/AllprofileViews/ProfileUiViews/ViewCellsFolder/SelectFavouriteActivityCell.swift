//
//  SelectFavouriteActivityCell.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 18/08/25.
//

import UIKit

class SelectFavouriteActivityCell: UICollectionViewCell {

    @IBOutlet weak var viewlayer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewLayer()
    }
    private func setupViewLayer() {
        viewlayer.layer.cornerRadius = 10
        viewlayer.layer.borderWidth = 0.5
        viewlayer.layer.borderColor = UIColor.gray.cgColor
        viewlayer.layer.shadowColor = UIColor.black.cgColor
        viewlayer.layer.shadowOpacity = 0.2
        viewlayer.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewlayer.layer.shadowRadius = 4
        
    }

}
