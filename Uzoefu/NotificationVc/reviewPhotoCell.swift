//
//  reviewPhotoCell.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 12/09/25.
//

import UIKit

class reviewPhotoCell: UICollectionViewCell {
    var cancelButton : (()->()) = {}
    @IBOutlet weak var uploardimages: UIImageView!
    
    @IBOutlet weak var deleteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func delteButtonAction(_ sender: UIButton) {
        cancelButton()
    }
}
