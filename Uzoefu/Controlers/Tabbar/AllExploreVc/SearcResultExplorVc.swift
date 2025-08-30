//
//  SearcResultExplorVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 11/08/25.
//

import UIKit

class SearcResultExplorVc: UIViewController {
    
    @IBOutlet weak var fileterView: UIView!
    @IBOutlet weak var hideView: UIView!
    @IBOutlet weak var exploreCollectionView: UICollectionView!
    
    @IBOutlet weak var hideViewheight: NSLayoutConstraint!
    
    @IBOutlet weak var fileterViewHeight: NSLayoutConstraint!
    @IBOutlet weak var expolreTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        expolreTableview.showsVerticalScrollIndicator = false
        expolreTableview.showsVerticalScrollIndicator = false
    }
    
    @IBAction func backActionBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true
        )
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
        return CGSize(width: widthPerItem, height: 200)
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
}
extension SearcResultExplorVc : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExploreFilterTableCell
        return cell
    }
    
    
}
