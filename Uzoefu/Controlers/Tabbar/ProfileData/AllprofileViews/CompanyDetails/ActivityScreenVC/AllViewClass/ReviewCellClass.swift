//
//  ReviewCellClass.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 20/08/25.
//

import UIKit
import Cosmos

class ReviewCellClass: UITableViewCell {
    var images: [String] = []
    @IBOutlet weak var ratingView: CosmosView!
 
    @IBOutlet weak var ratingeditBtnAction: UIButton!
    @IBOutlet weak var ratingeditBtn: UIImageView!
    @IBOutlet weak var reviewsPhotoCollectionView: UICollectionView!
    
    @IBOutlet weak var desciptionOfReviewer: UILabel!
    @IBOutlet weak var imageOfReviewer: UIImageView!
    @IBOutlet weak var nameofreviewer: UILabel!
    
    var editCommentBtn :(()->()) = {}
    override func awakeFromNib() {
        super.awakeFromNib()
        loadreviewsPhotoCollectionView()
        ratingView.settings.updateOnTouch = false
        
    }
    
    func loadreviewsPhotoCollectionView() {
        let nib = UINib(nibName: "ReviewPhotoCollectionCell", bundle: nil)
        reviewsPhotoCollectionView.register(nib, forCellWithReuseIdentifier: "ReviewPhotoCollectionCell")
        reviewsPhotoCollectionView.delegate = self
        reviewsPhotoCollectionView.dataSource = self
        reviewsPhotoCollectionView.showsHorizontalScrollIndicator = false
        reviewsPhotoCollectionView.showsVerticalScrollIndicator = false
    }
    
    
    @IBAction func commebtEditAction(_ sender: UIButton) {
        editCommentBtn()
    }
}
extension ReviewCellClass :UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = reviewsPhotoCollectionView.dequeueReusableCell(withReuseIdentifier: "ReviewPhotoCollectionCell", for: indexPath) as! ReviewPhotoCollectionCell
        let imgURL = images[indexPath.item]
                // if using SDWebImage
                cell.reviewPic.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "placeholder"))

      
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == reviewsPhotoCollectionView {
            let size = reviewsPhotoCollectionView.bounds.width / 5
            return CGSize(width: size, height: 100)
        } else {
            let size = collectionView.bounds.width / 5
            return CGSize(width: size, height: 80)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat { return 5 }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 5 }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}



