//
//  SelectFavouriteActivityCell.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 18/08/25.
//

import UIKit

class SelectFavouriteActivityCell: UICollectionViewCell {

    @IBOutlet weak var activityLable: UILabel!
    @IBOutlet weak var activityImage: UIImageView!
    @IBOutlet weak var viewlayer: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewLayer()
        
    }
    private func setupViewLayer() {
        viewlayer.layer.cornerRadius = 10
        viewlayer.layer.borderWidth = 0.5
//        viewlayer.layer.borderColor = UIColor.gray.cgColor
        viewlayer.layer.shadowColor = UIColor.black.cgColor
       // viewlayer.layer.shadowOpacity = 0.2
       // viewlayer.layer.shadowOffset = CGSize(width: 0, height: 2)
      //  viewlayer.layer.shadowRadius = 4
        setSelected(false)    }
    
    func setSelected(_ selected: Bool) {
        if selected {
            viewlayer.backgroundColor = #colorLiteral(red: 0.9215686275, green: 1, blue: 0.8039215686, alpha: 1)
            viewlayer.borderColor = #colorLiteral(red: 0, green: 0.4117647059, blue: 0.2509803922, alpha: 1)
            activityLable.textColor = #colorLiteral(red: 0, green: 0.4117647059, blue: 0.2509803922, alpha: 1)
            activityImage.tintColor = #colorLiteral(red: 0, green: 0.4117647059, blue: 0.2509803922, alpha: 1)
        } else {
            viewlayer.backgroundColor = .white
            activityLable.textColor = .lightGray
            activityImage.tintColor = .lightGray
        }
    }

}
