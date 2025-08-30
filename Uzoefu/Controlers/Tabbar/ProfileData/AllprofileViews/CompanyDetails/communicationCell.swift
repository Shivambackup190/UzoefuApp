//
//  communicationCell.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 26/08/25.
//

import UIKit

class communicationCell: UICollectionViewCell {
    @IBOutlet weak var communicationLabel: UILabel!
    
    @IBOutlet weak var communicationImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        communicationImage.tintColor = .gray

    }
}
