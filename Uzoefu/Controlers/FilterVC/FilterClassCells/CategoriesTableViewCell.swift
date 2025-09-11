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
    var selectedIndexes: [IndexPath] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        categorycollectionView.allowsMultipleSelection = true
        
        reloadCategoryCollection()
        
        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = .vertical
        categorycollectionView.collectionViewLayout = layout1
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCollectionViewHeight()
    }
    
    private func updateCollectionViewHeight() {
        self.categorycollectionView.layoutIfNeeded()
        self.categoryColectionHeightOutlet.constant = self.categorycollectionView.contentSize.height
    }
    
    func loadcategorycollectionView() {
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
        
        for i in 0..<15 { // total items
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
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categorycollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        // ✅ Set UI state based on selectedIndexes
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
        if collectionView == categorycollectionView {
                if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
                    if selectedIndexes.contains(indexPath) {
                        // Already selected → unselect
                        selectedIndexes.removeAll { $0 == indexPath }
                        collectionView.deselectItem(at: indexPath, animated: false)
                        cell.setSelected(false)
                    } else {
                        // Not selected → select
                        selectedIndexes.append(indexPath)
                        cell.setSelected(true)
                    }
                }
            }
        }
    

    func reloadCategoryCollection() {
        categorycollectionView.reloadData()
        loadcategorycollectionView()
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
