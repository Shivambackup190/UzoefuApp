//
//  CategoryCollectionViewCell.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 10/09/25.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var categoryLable: UILabel!
    @IBOutlet weak var viewlayer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setSelected(false)
    }
    func setSelected(_ selected: Bool) {
        if selected {
            viewlayer.backgroundColor = #colorLiteral(red: 0.9215686275, green: 1, blue: 0.8039215686, alpha: 1)
            viewlayer.borderColor = #colorLiteral(red: 0, green: 0.4117647059, blue: 0.2509803922, alpha: 1)
            categoryLable.textColor = #colorLiteral(red: 0, green: 0.4117647059, blue: 0.2509803922, alpha: 1)
            iconImageView.tintColor = #colorLiteral(red: 0, green: 0.4117647059, blue: 0.2509803922, alpha: 1)
        } else {
            viewlayer.backgroundColor = .white
            categoryLable.textColor = .lightGray
            iconImageView.tintColor = .lightGray
        }
    }

}
