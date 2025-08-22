//
//  ExplreCatagoriesCell.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 11/08/25.
//

import UIKit

class ExplreCatagoriesCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var categoryLable: UILabel!
    @IBOutlet weak var viewlayer: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewLayer()
        setupUI()
    }
    private func setupViewLayer() {
        viewlayer.layer.cornerRadius = 10
        viewlayer.layer.borderWidth = 0.5
        viewlayer.layer.shadowColor = UIColor.gray.cgColor
        viewlayer.layer.shadowOffset = CGSize(width: 0, height: 0)
        viewlayer.layer.shadowRadius = 2
        viewlayer.layer.shadowOpacity = 0.3
        viewlayer.layer.masksToBounds = false
        
    }
    private func setupUI() {
        viewlayer.layer.cornerRadius = 10
        viewlayer.layer.borderWidth = 0.5
        viewlayer.layer.borderColor = UIColor.lightGray.cgColor
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


