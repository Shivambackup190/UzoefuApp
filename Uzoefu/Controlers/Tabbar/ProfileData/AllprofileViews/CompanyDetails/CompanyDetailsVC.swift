//
//  CompanyDetailsVC.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 19/08/25.
// collection code here 

import UIKit

class CompanyDetailsVC: UIViewController {

    @IBOutlet weak var companyDetailCollectionView: UICollectionView!
    @IBOutlet weak var companyDetailCollectionViewSecond: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        companyDetailCollectionView.contentInsetAdjustmentBehavior = .never
        companyDetailCollectionViewSecond.contentInsetAdjustmentBehavior = .never
        
        companyDetailCollectionView.delegate = self
        companyDetailCollectionView.dataSource = self
        
        companyDetailCollectionViewSecond.delegate = self
        companyDetailCollectionViewSecond.dataSource = self
        
     
        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = .horizontal
        companyDetailCollectionView.collectionViewLayout = layout1
        companyDetailCollectionView.showsHorizontalScrollIndicator = false
        

        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .vertical
        companyDetailCollectionViewSecond.collectionViewLayout = layout2
        companyDetailCollectionViewSecond.showsHorizontalScrollIndicator = false
    }
    @IBAction func BackBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CompanyDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == companyDetailCollectionView {
            return 2
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == companyDetailCollectionView {
            let cell = companyDetailCollectionView.dequeueReusableCell(withReuseIdentifier: "CompanyDetailsCell", for: indexPath) as! CompanyDetailsCell
            return cell
        } else {
            let cell = companyDetailCollectionViewSecond.dequeueReusableCell(withReuseIdentifier: "CompanyDetailsCellSecond", for: indexPath) as! CompanyDetailsCellSecond
            return cell
        }
    }
    // MARK: - DidSelectionFunctions
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == companyDetailCollectionViewSecond {
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "ActivityScreenVC") as! ActivityScreenVC
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
    
    // MARK: - Flow Layout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == companyDetailCollectionView {
            
            return CGSize(width: companyDetailCollectionView.bounds.width, height: 240)
            
        } else {
            
            let width = self.companyDetailCollectionViewSecond.bounds.width-5
            return CGSize(width: width/2, height: 190)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == companyDetailCollectionViewSecond {
            return 10
        }
        else {
            return 5
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == companyDetailCollectionViewSecond {
            return 2
        }
        else {
            return 5
        }
        
    }
    
    
}

