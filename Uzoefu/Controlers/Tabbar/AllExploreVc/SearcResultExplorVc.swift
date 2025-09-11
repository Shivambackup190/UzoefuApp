//
//  SearcResultExplorVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 11/08/25.
//

import UIKit

class SearcResultExplorVc: UIViewController {
  
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var fileterView: UIView!
    @IBOutlet weak var hideView: UIView!
    @IBOutlet weak var exploreCollectionView: UICollectionView!
    
    @IBOutlet weak var hideViewheight: NSLayoutConstraint!
    
    @IBOutlet weak var fileterViewHeight: NSLayoutConstraint!
    @IBOutlet weak var expolreTableview: UITableView!
    var myvalue:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryLbl.text = myvalue
        hideViewheight.constant = 0
        hideView.isHidden = true
        exploreCollectionView.register(
            UINib(nibName: "SearcResultExplorCell", bundle: nil),
            forCellWithReuseIdentifier: "cell"
        )
        
        exploreCollectionView.delegate = self
        exploreCollectionView.dataSource = self
        
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        exploreCollectionView.collectionViewLayout = layout
        
        expolreTableview.delegate = self
        expolreTableview.dataSource = self

        expolreTableview.showsVerticalScrollIndicator = false
        expolreTableview.showsVerticalScrollIndicator = false
    }
    
    @IBAction func backActionBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true
        )
    }
    
    @IBAction func filterActionBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        vc.modalPresentationStyle = .pageSheet

        if let sheet = vc.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [.custom { _ in 300 }, .large()] // starting height
            } else {
                sheet.detents = [.medium(), .large()]
            }
            sheet.prefersGrabberVisible = true
        }

        present(vc, animated: true)
    }
}

extension SearcResultExplorVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        ) as? SearcResultExplorCell else {
            return UICollectionViewCell()
        }
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 15
        let availableWidth = collectionView.frame.width - padding
        let widthPerItem = availableWidth / 2
        let height = widthPerItem * 1.3
        
        print(height)
        return CGSize(width: widthPerItem, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nav = self.storyboard?.instantiateViewController(identifier: "CompanyDetailsVC") as! CompanyDetailsVC
        self.navigationController?.pushViewController(nav, animated: true)
    }
}
extension SearcResultExplorVc : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExploreFilterTableCell
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nav = self.storyboard?.instantiateViewController(identifier: "CompanyDetailsVC") as! CompanyDetailsVC
        self.navigationController?.pushViewController(nav, animated: true)
    }
}
    

