//
//  ReviewCellClass.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 20/08/25.
//

import UIKit

class ReviewCellClass: UITableViewCell {

    @IBOutlet weak var reviewsPhotoCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        loadreviewsPhotoCollectionView()
        
        
    }

    func loadreviewsPhotoCollectionView() {
        let nib = UINib(nibName: "ReviewPhotoCollectionCell", bundle: nil)
        reviewsPhotoCollectionView.register(nib, forCellWithReuseIdentifier: "ReviewPhotoCollectionCell")
        reviewsPhotoCollectionView.delegate = self
        reviewsPhotoCollectionView.dataSource = self
    }
    
}
extension ReviewCellClass :UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = reviewsPhotoCollectionView.dequeueReusableCell(withReuseIdentifier: "ReviewPhotoCollectionCell", for: indexPath) as! ReviewPhotoCollectionCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == reviewsPhotoCollectionView {
            let size = reviewsPhotoCollectionView.bounds.width / 5
            return CGSize(width: size, height: 80)
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
    
    

