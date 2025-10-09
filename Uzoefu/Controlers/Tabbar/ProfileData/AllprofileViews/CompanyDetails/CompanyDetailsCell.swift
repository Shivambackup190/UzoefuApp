//
//  CompanyDetailsCell.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 19/08/25.
//

import UIKit

class CompanyDetailsCell: UICollectionViewCell {

    @IBOutlet weak var imageViewPic: UIImageView!
    @IBOutlet weak var likeBtnAction: UIButton!
    var likeBtn: (() -> ()) = {}
    @IBOutlet weak var wishListImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func likeBtnAction(_ sender: Any) {
        likeBtn()
    }
    
}
