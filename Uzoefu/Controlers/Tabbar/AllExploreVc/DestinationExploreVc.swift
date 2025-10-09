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
    
    @IBOutlet weak var countLable: UILabel!
    @IBOutlet weak var destinationplacesCollectionView: UICollectionView!
    var hidevalue:String?
    var notificationcountModelObj:NotificationCountModel?

    var discoverdestinationObj:DiscoverDestinationModel?
    var isLoading = false
    var current_page = 1
    var total_pages = 1
    var pageId = 1
    var spinner = UIActivityIndicatorView(style: .medium)

    var destinationList: [DestinationData] = []
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
    override func viewWillAppear(_ animated: Bool) {
        pageId = 1
           isLoading = false
           discoverdestinationApi(page: pageId)
        notificationCountListApi()
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
            return discoverdestinationObj?.data?.count ?? 0
        }
        else {
            return discoverdestinationObj?.data?.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == destinationplacesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DestinationplacesCollectionViewCell
            cell.categoryLable.text = discoverdestinationObj?.data?[indexPath.row].branch_name
            cell.countLable.text = "(\(discoverdestinationObj?.data?[indexPath.row].activity_count ?? 0))"
            
            return cell
        } else {
            let cell = exploreDestinationColltionView.dequeueReusableCell(
                withReuseIdentifier: "cell",
                for: indexPath) as! DestinationExploreCollectionViewCell
            cell.branchName.text = discoverdestinationObj?.data?[indexPath.row].branch_name
            let activityCount = discoverdestinationObj?.data?[indexPath.row].activity_count ?? 0
            cell.branchCount.text = "(\(activityCount) Activities)"

            
            if let activities = discoverdestinationObj?.data, indexPath.row < activities.count {
                let activity = activities[indexPath.row]
                if let icon = activity.activity_image {
                    let cleanedIcon = icon.replacingOccurrences(of: "\\/", with: "/")
                    let fullURLString = (discoverdestinationObj?.image_path ?? "") + "/" + cleanedIcon
                    if let url = URL(string: fullURLString) {
                        cell.discoverImge.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
                    } else {
                        cell.discoverImge.image = UIImage(named: "placeholder")
                    }
                }
                
                
            }
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
       
            nav.myvalue = "\(discoverdestinationObj?.data?[indexPath.row].branch_name ?? "") (\(discoverdestinationObj?.data?[indexPath.row].activity_count ?? 0))"
            nav.didselctletCategoryId = discoverdestinationObj?.data?[indexPath.row].branch_id
            nav.myvalueapicallS = "apicalls"

            self.navigationController?.pushViewController(nav, animated: true)
        }
        else {
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "SearcResultExplorVc") as! SearcResultExplorVc
            nav.myvalue = "\(discoverdestinationObj?.data?[indexPath.row].branch_name ?? "") (\(discoverdestinationObj?.data?[indexPath.row].activity_count ?? 0))"
            nav.didselctletCategoryId = discoverdestinationObj?.data?[indexPath.row].branch_id
            nav.myvalueapicallS = "apicalls"

            self.navigationController?.pushViewController(nav, animated: true)
            
           
            
        }
        
    }
}
extension DestinationExploreVc {
    //    func discoverdestinationApi() {
    //        let param = [String:Any]()
    //
    //        print(param)
    //
    //        DiscoverDestinationViewModel.discoverDestinationApi(viewController: self, parameters: param as NSDictionary) {(response) in
    //            self.discoverdestinationObj = response
    //            print("jai hind")
    //            self.exploreDestinationColltionView.reloadData()
    //            self.destinationplacesCollectionView.reloadData()
    //        }
    //    }
    func discoverdestinationApi(page: Int) {
        let param = ["page": page]
        print(" Params:", param)
        
        DiscoverDestinationViewModel.discoverDestinationApi(viewController: self, parameters: param as NSDictionary) { response in
            guard let response = response else { return }
            
            if page == 1 {
                
                self.discoverdestinationObj = response
            } else {
                
                var existingData = self.discoverdestinationObj?.data ?? []
                existingData.append(contentsOf: response.data ?? [])
                self.discoverdestinationObj?.data = existingData
            }
            
            
            self.current_page = response.current_page ?? 1
            self.total_pages = response.last_page ?? 1
            self.isLoading = false
            
            print(" Page \(self.current_page) of \(self.total_pages)")
            self.destinationplacesCollectionView.reloadData()
            self.exploreDestinationColltionView.reloadData()
            
        }
    }
}
extension DestinationExploreVc {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == destinationplacesCollectionView {
            let totalItems = discoverdestinationObj?.data?.count ?? 0
            
            // 👇 When reaching the last cell, load next page if available
            if indexPath.row == totalItems - 1 && !isLoading && current_page < total_pages {
                isLoading = true
                pageId += 1
                discoverdestinationApi(page: pageId)
            }
        } else {
            let totalItems = discoverdestinationObj?.data?.count ?? 0
            
            // 👇 When reaching the last cell, load next page if available
            if indexPath.row == totalItems - 1 && !isLoading && current_page < total_pages {
                isLoading = true
                pageId += 1
                discoverdestinationApi(page: pageId)
            }
        }
        
    }
}
extension DestinationExploreVc {
    func notificationCountListApi(){
          let param = [String:Any]()
          NotificationListViewModel.notificationCountListApi(viewController: self, parameters: param as NSDictionary) {  response in
              self.notificationcountModelObj = response
              self.countLable.text = "\(self.notificationcountModelObj?.data ?? 0)"

              print("Success")
          }
      }
}
