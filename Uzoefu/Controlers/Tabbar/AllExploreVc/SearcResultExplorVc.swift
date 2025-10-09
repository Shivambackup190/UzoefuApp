//
//  SearcResultExplorVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 11/08/25.
//jnhnfgbv

import UIKit

class SearcResultExplorVc: UIViewController, filterDelegate {
    func filtervalues() {
        self.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.ApplyFilterValues = "apply"
            self.hideView.isHidden = false
            self.hideViewheight.constant = 35
            self.filterActivityListApi()
        }
    }

    
  
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var fileterView: UIView!
    @IBOutlet weak var hideView: UIView!
    @IBOutlet weak var exploreCollectionView: UICollectionView!
    
    @IBOutlet weak var countLable: UILabel!
    @IBOutlet weak var hideViewheight: NSLayoutConstraint!
    
    @IBOutlet weak var fileterViewHeight: NSLayoutConstraint!
    @IBOutlet weak var expolreTableview: UITableView!
    var myvalue:String?
    var myvalueapicall:String?
    var myvalueapicallS:String?
    var activityListModelObj:ActivityListModel?
    var didselctletCategoryId :Int?
    var branchId:Int?
    var wishListmodelObj:WishListModel?
    var filteractivtyObj:FilterActivitiesModel?
    var ApplyFilterValues:String?
    var notificationcountModelObj:NotificationCountModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        if ApplyFilterValues == "apply" {
            hideView.isHidden = false
            hideViewheight.constant = 35
        }
        else {
            hideViewheight.constant = 0
            hideView.isHidden = true
        }
        
        categoryLbl.text = myvalue
        
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
    override func viewWillAppear(_ animated: Bool) {
        if myvalueapicall == "apicall" {
            activityListApi( category_id: didselctletCategoryId ?? 0)
        } else if myvalueapicallS == "apicalls" {
            activityListApi(branch_id: didselctletCategoryId ?? 0)
        } else {
            activityListApi()
        }
        notificationCountListApi()
    }
    
    
    @IBAction func backActionBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true
        )
       
    }
    
    @IBAction func notificationAction(_ sender: UIButton) {
        
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVc") as! NotificationVc
                      self.navigationController?.pushViewController(nav, animated: true)
    }
    @IBAction func menuBtnAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
                     self.navigationController?.pushViewController(nav, animated: true)
    }
    
    @IBAction func filterActionBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        vc.delegate = self
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
//        return activityListModelObj?.data?.count ?? 0
        let count = activityListModelObj?.data?.count ?? 0
            return min(count, 2)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearcResultExplorCell
        let activityDict = activityListModelObj?.data?[indexPath.row]
        
        cell.activityName.text = activityDict?.name
     
        cell.todayHours.setTodayHoursText(hours: activityDict?.today_hours)

//        cell.rating.text = activityDict?.rating ?? ""
        let ratingValueDouble = activityDict?.rating ?? "0.0"
    
        let ratingCount = " (\(activityDict?.rating_count ?? 0))"
        let text = ratingValueDouble + ratingCount

        let attr = NSMutableAttributedString(string: text)
        attr.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 14), range: NSRange(location: 0, length: ratingValueDouble.count))
        attr.addAttribute(.foregroundColor, value: #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1), range: NSRange(location: 0, length: ratingValueDouble.count))


        attr.addAttribute(.font, value: UIFont.systemFont(ofSize: 13), range: NSRange(location: ratingValueDouble.count, length: ratingCount.count))
        attr.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: ratingValueDouble.count, length: ratingCount.count))
        cell.rating.attributedText = attr
        cell.activity_price.setPriceText(price: activityDict?.activity_price ?? "")
        
        
        cell.wishListImg.image = activityDict?.is_wish == true
            ? UIImage(named: "greenheart")
            : UIImage(named: "hearttt")


                        cell.likeBtn = { [weak self] in
                            guard let self = self else { return }
                            

                            if let id = activityListModelObj?.data?[indexPath.row].id {
                                self.wishListApi(activity_id: id)
                            }
                            self.activityListModelObj?.data?[indexPath.row].is_wish?.toggle()
                            self.exploreCollectionView.reloadData()
                        }
        if let icon = activityListModelObj?.data?[indexPath.row].image {
            let cleanedIcon = icon.replacingOccurrences(of: "\\/", with: "/")
            
            let fullURLString = imagePathUrl + cleanedIcon
            
            if let url = URL(string: fullURLString) {
                cell.experinceImg.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
                print(fullURLString)
            } else {
                cell.experinceImg.image = UIImage(named: "placeholder")
            }
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearcResultExplorCell
        
        let nav = self.storyboard?.instantiateViewController(identifier: "ActivityScreenVC") as! ActivityScreenVC
        nav.didselctletCategoryId = activityListModelObj?.data?[indexPath.row].id
        self.navigationController?.pushViewController(nav, animated: true)
        
    }
}
extension SearcResultExplorVc : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return activityListModelObj?.data?.count ?? 0
        let totalCount = activityListModelObj?.data?.count ?? 0
        return totalCount > 2 ? totalCount - 2 : 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExploreFilterTableCell
        
        
        let activityDict = activityListModelObj?.data?[indexPath.row + 2]
        
        cell.activityName.text = activityDict?.name
        cell.todayHours.setTodayHoursText(hours: activityDict?.today_hours)

        let ratingValueDouble = activityDict?.rating ?? "0.0"
        let ratingCount = " (\(activityDict?.rating_count ?? 0))"
        let text = ratingValueDouble + ratingCount

        let attr = NSMutableAttributedString(string: text)
        attr.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 14), range: NSRange(location: 0, length: ratingValueDouble.count))
        attr.addAttribute(.foregroundColor, value: #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1), range: NSRange(location: 0, length: ratingValueDouble.count))
        attr.addAttribute(.font, value: UIFont.systemFont(ofSize: 13), range: NSRange(location: ratingValueDouble.count, length: ratingCount.count))
        attr.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: ratingValueDouble.count, length: ratingCount.count))
        cell.rating.attributedText = attr
        cell.activity_price.setPriceText(price: activityDict?.activity_price ?? "")

        cell.wishListImg.image = activityDict?.is_wish == true ? UIImage(named: "greenheart") : UIImage(named: "hearttt")

        cell.likeBtn = { [weak self] in
            guard let self = self else { return }
            if let id = self.activityListModelObj?.data?[indexPath.row + 2].id {
                self.wishListApi(activity_id: id)
            }
            self.activityListModelObj?.data?[indexPath.row + 2].is_wish?.toggle()
            self.expolreTableview.reloadData()
        }

        if let icon = activityListModelObj?.data?[indexPath.row + 2].image {
            let cleanedIcon = icon.replacingOccurrences(of: "\\/", with: "/")
            let fullURLString = imagePathUrl + cleanedIcon
            if let url = URL(string: fullURLString) {
                cell.searchimg.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
            } else {
                cell.searchimg.image = UIImage(named: "placeholder")
            }
        }
        cell.selectionStyle = .none
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nav = self.storyboard?.instantiateViewController(identifier: "ActivityScreenVC") as! ActivityScreenVC
        nav.didselctletCategoryId = activityListModelObj?.data?[indexPath.row].id
        self.navigationController?.pushViewController(nav, animated: true)
    }
}
extension SearcResultExplorVc {
    
    //    func activityListApi(category_id: Int) {
    //        let param: [String: Any] = ["category_id": category_id]
    //        print("API Params:", param)
    //
    //        ActivityListViewModel.activityListApi(viewController: self, parameters: param as NSDictionary) { response in
    //            self.activityListModelObj = response
    //            self.exploreCollectionView.reloadData()
    //            self.expolreTableview.reloadData()
    //        }
    //    }branch_id
    func activityListApi(branch_id: Int? = nil, category_id: Int? = nil, isInitialLoad: Bool = false) {
        var param: [String: Any] = [:]
        
        //  Add branch_id if available
        if let branchId = branch_id {
            param["branch_id"] = branchId
        } else {
            param["branch_id"] = ""
        }
        
        //  Add category_id if available
        if let categoryId = category_id {
            param["category_id"] = categoryId
        } else {
            param["category_id"] = ""
        }
        
        print("📡 API Params:", param)
        
        
        
        ActivityListViewModel.activityListApi(viewController: self, parameters: param as NSDictionary) { response in
            self.activityListModelObj = response
            
            if isInitialLoad {
                
                self.expolreTableview.reloadData()
                self.exploreCollectionView.reloadData()
            } else {
                
                self.exploreCollectionView.reloadData()
                self.expolreTableview.reloadData()
            }
        }
    }
    func wishListApi(activity_id:Int) {
        let param = ["activity_id":activity_id]
        
        print(param)
        
        WishListViewModel.wishListApi(viewController: self, parameters: param as NSDictionary) {(response) in
            self.wishListmodelObj = response
            print("jai hind")
            self.exploreCollectionView.reloadData()
        }
    }
    
}
//for searching FileterValues
extension SearcResultExplorVc {
    func filterActivityListApi() {
        var param = [String: Any]()
        param = [
                "province_id": 3239,
                "price": "0-2599",
                "rating": 2.5,
                "category_id": 2
            ]
            
         
        FilterActivitiesViewModel.filterActivitiesListApi(viewController: self, parameters: param as NSDictionary) { response in
             self.filteractivtyObj = response
             DispatchQueue.main.async {
                 self.exploreCollectionView.reloadData()
                 self.expolreTableview.reloadData()
             }
         }
     }
    func notificationCountListApi(){
          let param = [String:Any]()
          NotificationListViewModel.notificationCountListApi(viewController: self, parameters: param as NSDictionary) {  response in
              self.notificationcountModelObj = response
              self.countLable.text = "\(self.notificationcountModelObj?.data ?? 0)"

              print("Success")
          }
      }


}
