//
//  DestinationExploreVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 12/08/25.

import UIKit

class DestinationExploreVc: UIViewController {
    @IBOutlet weak var weidthBackConstraint: NSLayoutConstraint!
    @IBOutlet weak var backHideShowBtn: UIButton!
    @IBOutlet weak var exploreDestinationColltionView: UICollectionView!
    
    @IBOutlet weak var destinationplacesCollectionView: UICollectionView!
    var hidevalue:String?
    var categoryNames = [
         "Pretotia",
         "Drakensberg",
         "Victoria Falls",
         "Kimberly",
         "Brits",
         "Polokwane",
         "Hout Bay",
         "Njelele",
         "New Castle",
         "Sabie",
         "Pretotia",
         "Drakensberg",
         "Victoria Falls",
         "Kimberly",
         "Brits",
         "Polokwane",
         "Hout Bay",
         "Njelele",
         "New Castle",
         "Sabie"
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
        123,47,
        32,
        200,
        123
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if hidevalue == "ok" {
            backHideShowBtn.isHidden = false
            weidthBackConstraint.constant = 40
            
        
        }
        else {
            backHideShowBtn.isHidden = true
            weidthBackConstraint.constant = 0
            
        }
        exploreDestinationColltionView.register(
            UINib(nibName: "DestinationExploreCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "cell")
        exploreDestinationColltionView.delegate = self
        exploreDestinationColltionView.dataSource = self
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        exploreDestinationColltionView.collectionViewLayout = layout
        
        
        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = .vertical
        destinationplacesCollectionView.collectionViewLayout = layout1
        
    }
    
    @IBAction func bckActionBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func notificationbtnAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVc") as! NotificationVc
        self.navigationController?.pushViewController(nav, animated: true)
    }
    @IBAction func menuActionBtn(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        self.navigationController?.pushViewController(nav, animated: true)
    }
}
extension DestinationExploreVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == exploreDestinationColltionView {
            return 4
        }
        else {
            return 16
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == destinationplacesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DestinationplacesCollectionViewCell
            cell.categoryLable.text = categoryNames[indexPath.row]
            cell.countLable.text = "(\(countValues[indexPath.row]))"
            
            return cell
        } else {
            let cell = exploreDestinationColltionView.dequeueReusableCell(
                withReuseIdentifier: "cell",
                for: indexPath) as! DestinationExploreCollectionViewCell
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == destinationplacesCollectionView {
            let itemsPerRow: CGFloat = 2
            let spacing: CGFloat = 10
            let sectionInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
            
            let totalSpacing = sectionInsets.left + sectionInsets.right + (spacing * (itemsPerRow - 1))
            let availableWidth = collectionView.frame.width - totalSpacing
            let widthPerItem = availableWidth / itemsPerRow
            
            return CGSize(width: widthPerItem, height: 60)
        } else {
            let itemsPerRow: CGFloat = 2
            let spacing: CGFloat = 10
            let sectionInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
            
            let totalSpacing = sectionInsets.left + sectionInsets.right + (spacing * (itemsPerRow - 1))
            let availableWidth = collectionView.frame.width - totalSpacing
            let widthPerItem = availableWidth / itemsPerRow
            
            return CGSize(width: widthPerItem, height: 120)
        }
        
        
    }
    
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5) // smaller side padding
        }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == destinationplacesCollectionView {
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "SearcResultExplorVc") as! SearcResultExplorVc
            nav.myvalue = "\(categoryNames[indexPath.row]) (\(countValues[indexPath.row]))"

            self.navigationController?.pushViewController(nav, animated: true)
        }
        else {
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "SearcResultExplorVc") as! SearcResultExplorVc
          
            self.navigationController?.pushViewController(nav, animated: true)
            
        }
        
    }
}
