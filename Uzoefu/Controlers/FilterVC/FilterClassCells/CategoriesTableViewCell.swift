//
//  CategoriesTableViewCell.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 10/09/25.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryColectionHeightOutlet: NSLayoutConstraint!
    @IBOutlet weak var categorycollectionView: UICollectionView!
    var categoriesModelObj: ExploreCategoriesModel?
    var selectedIndexes: [IndexPath] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // categorycollectionView.allowsMultipleSelection = true
        
        setupCategoryCollectionView()
        reloadCategoryCollection()
        
        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = .vertical
        categorycollectionView.collectionViewLayout = layout1
    }
    func configure(with model: ExploreCategoriesModel?) {
        self.categoriesModelObj = model
        reloadCategoryCollection()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCollectionViewHeight()
    }
    
    private func updateCollectionViewHeight() {
        self.categorycollectionView.layoutIfNeeded()
        self.categoryColectionHeightOutlet.constant = self.categorycollectionView.contentSize.height
    }
    
    func setupCategoryCollectionView() {
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        categorycollectionView.register(nib, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        categorycollectionView.delegate = self
        categorycollectionView.dataSource = self
        categorycollectionView.showsHorizontalScrollIndicator = false
        categorycollectionView.showsVerticalScrollIndicator = false
    }
    
    @IBAction func selctAllBtnAction(_ sender: UIButton) {
        // Clear existing selection
        selectedIndexes.removeAll()
        
        // Get actual item count
        let totalItems = categoriesModelObj?.data?.count ?? 0
        
        for i in 0..<totalItems {
            let indexPath = IndexPath(item: i, section: 0)
            selectedIndexes.append(indexPath)
            categorycollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            
            if let cell = categorycollectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
                cell.setSelected(true)
            }
        }
    }
}
extension CategoriesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesModelObj?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categorycollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
                
                if let category = categoriesModelObj?.data?[indexPath.row] {
                    cell.categoryLable.text = category.name
                    // image load
                    if let icon = categoriesModelObj?.data?[indexPath.row].icon {
                        // Remove unwanted slashes if needed
                        let cleanedIcon = icon.replacingOccurrences(of: "\\/", with: "/")
                        
                        // Append baseURL
                        let fullURLString = image_Url + cleanedIcon
                        
                        if let url = URL(string: fullURLString) {
                            cell.iconImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
                        } else {
                            cell.iconImageView.image = UIImage(named: "placeholder")
                        }
                    }
                }
                
                cell.setSelected(selectedIndexes.contains(indexPath))
                return cell
            }
      
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 3
        let spacing: CGFloat = 10
        let sectionInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        
        let totalSpacing = sectionInsets.left + sectionInsets.right + (spacing * (itemsPerRow - 1))
        let availableWidth = collectionView.frame.width - totalSpacing
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 60)
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexes.contains(indexPath) {
            selectedIndexes.removeAll { $0 == indexPath }
            (collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell)?.setSelected(false)
        } else {
            selectedIndexes.append(indexPath)
            (collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell)?.setSelected(true)
        }
        
    }

    func reloadCategoryCollection() {
        categorycollectionView.reloadData()
        setupCategoryCollectionView()
        DispatchQueue.main.async {
            self.categorycollectionView.layoutIfNeeded()
            self.updateCollectionViewHeight()
            
         
            if let tableView = self.superview as? UITableView {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }
    }

}
