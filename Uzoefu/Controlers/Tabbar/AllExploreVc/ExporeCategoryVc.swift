//
//  ExporeCategoryVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 12/08/25.
//

import UIKit

class ExporeCategoryVc: UIViewController {
    
    @IBOutlet weak var exporeCatagoriesCollection: UICollectionView!
    
    var categoryNames = [
        "Near Me",
        "Adventure",
        "Culture",
        "Food",
        "Entertainment",
        "Family Fun",
        "Services",
        "Religion",
        "Outdoors",
        "Wildlife",
        "Wellness",
        "Historical",
        "Sport",
        "Urban",
        "Nature",
        "Tours"
    ]
    var countValues: [Int] = [
        400,
        600,
        450,
        1700,
        350,
        18,
        250,
        66,
        131,
        65,
        50,
        67,
        47,
        32,
        200,
        123
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exporeCatagoriesCollection.delegate = self
        exporeCatagoriesCollection.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        exporeCatagoriesCollection.collectionViewLayout = layout
        
    }
    @IBAction func backActionBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension ExporeCategoryVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ExporeCategoryCollectionViewCell
        cell.categoryLable.text = categoryNames[indexPath.row]
        cell.countLable.text = "(\(countValues[indexPath.row]))"
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 2
        let spacing: CGFloat = 5
        let sectionInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let totalSpacing = sectionInsets.left + sectionInsets.right + (spacing * (itemsPerRow - 1))
        let availableWidth = collectionView.frame.width - totalSpacing
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "SearcResultExplorVc") as! SearcResultExplorVc
        nav.myvalue = "\(categoryNames[indexPath.row]) (\(countValues[indexPath.row]))"

        self.navigationController?.pushViewController(nav, animated: true)

     
    }
}

