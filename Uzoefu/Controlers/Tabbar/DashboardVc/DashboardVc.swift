import UIKit

class DashboardVc: UIViewController, ExploreexpericeFilterDelegate, filterDelegate {
    func filtervalues() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearcResultExplorVc") as! SearcResultExplorVc
        vc.ApplyFilterValues = "apply"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didSelectActivity(activityID: Int) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ActivityScreenVC") as! ActivityScreenVC
        vc.didselctletCategoryId = activityID
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myscrolleview: UIScrollView!
    @IBOutlet weak var experinceActiviyvollotionView: UICollectionView!
    @IBOutlet weak var discovercollectionView: UICollectionView!
    @IBOutlet weak var exploreCollectionView: UICollectionView!
    @IBOutlet weak var experinceActiviyvollotionViewSecond: UICollectionView!
    @IBOutlet weak var scroolView: UIScrollView!
    
        var isLoading = false

        var current_page = 0

        var total_pages = 0

        var pageId = 1

        var spinner = UIActivityIndicatorView()
    let noDataLabel: UILabel = {
                 let label = UILabel()
                 label.text = "No Activity Found!"
                 label.textAlignment = .center
                 label.textColor = .darkGray
                 label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
                 label.isHidden = true
                 return label
             }()
    
    
    var categoriesModelObj:ExploreCategoriesModel?
    var activityListModelObj:ActivityListModel?
    var wishListmodelObj:WishListModel?
    var activity_idselected:Int?
    var selectedIndexes: [IndexPath] = []
    var didselctletCategoryId :Int?
    var discoverdestinationObj:DiscoverDestinationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noDataLabel.frame = experinceActiviyvollotionViewSecond.bounds
        experinceActiviyvollotionViewSecond.backgroundView = noDataLabel
        
        
        pageId = 1
            isLoading = false
            discoverdestinationApi(page: pageId)

        exploreCollectionView.allowsMultipleSelection = true
        experinceActiviyvollotionViewSecond.delegate = self
        experinceActiviyvollotionViewSecond.dataSource = self
        experinceActiviyvollotionView.delegate = self
        experinceActiviyvollotionView.dataSource = self
        discovercollectionView.delegate = self
        discovercollectionView.dataSource = self
        exploreCollectionView.delegate = self
        exploreCollectionView.dataSource = self
        exploreCollectionView.allowsMultipleSelection = true
        
        myscrolleview.contentInsetAdjustmentBehavior = .never
        
        myImageView.layer.cornerRadius = 20
        myImageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        myImageView.clipsToBounds = true
        
        
        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = .horizontal
        experinceActiviyvollotionViewSecond.collectionViewLayout = layout1
        experinceActiviyvollotionViewSecond.showsHorizontalScrollIndicator = false
        
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .horizontal
        experinceActiviyvollotionView.collectionViewLayout = layout2
        experinceActiviyvollotionView.showsHorizontalScrollIndicator = false
    }
    override func viewWillAppear(_ animated: Bool) {
        exploreCategoriesApi()
        discoverdestinationApi(page: pageId)
        activityListApi(isInitialLoad: true)
    }
    
    @IBAction func discoverDestinationBtnAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "DestinationExploreVc") as! DestinationExploreVc
        
        nav.hidevalue = "ok"
        nav.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(nav, animated: true)
       // tabBarController?.selectedIndex = 1
        
    }
    
    @IBAction func AxerienceViewMoreAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "SearcResultExplorVc") as! SearcResultExplorVc
        
       // nav.hidevalue = "ok"
        nav.hidesBottomBarWhenPushed = true 
        
        self.navigationController?.pushViewController(nav, animated: true)
//
//        tabBarController?.selectedIndex = 1
    }
    
    @IBAction func exporeCatagoriesActionViewMore(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "ExporeCategoryVc") as! ExporeCategoryVc
        
        self.navigationController?.pushViewController(nav, animated: true)
    }
    @IBAction func filterBtnAction(_ sender: UIButton) {
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
@IBAction func exploreSearchAction(_ sender: UIButton) {
    let vc = storyboard?.instantiateViewController(withIdentifier: "ExploreexpericeFilter") as! ExploreexpericeFilter
        
       
        vc.delegate = self
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [.custom { _ in 850 }]
            } else {
                sheet.detents = [.large()]
            }
            sheet.prefersGrabberVisible = true
        }
        present(nav, animated: true)
    }
}
//nwcode

// MARK: - UICollectionView Delegate & DataSource
extension DashboardVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == discovercollectionView {
            return discoverdestinationObj?.data?.count ?? 0
        } else if collectionView == experinceActiviyvollotionView {
            return activityListModelObj?.data?.count ?? 0
            
        } else if collectionView == exploreCollectionView {
            return categoriesModelObj?.data?.count ?? 0
        } else if collectionView == experinceActiviyvollotionViewSecond {
//            return activityListModelObj?.data?.count ?? 0
            self.noDataLabel.isHidden = activityListModelObj?.data?.count   == 0 ? false : true
                return activityListModelObj?.data?.count ?? 0
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == discovercollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "discovercell", for: indexPath) as! discoverdestinationCell
            cell.branch_name.text = discoverdestinationObj?.data?[indexPath.row].branch_name
            let activityCount = discoverdestinationObj?.data?[indexPath.row].activity_count ?? 0
            cell.branchCount.text = "(\(activityCount) Activities)"

            
            if let activities = discoverdestinationObj?.data, indexPath.row < activities.count {
                let activity = activities[indexPath.row]
                if let icon = activity.activity_image {
                    let cleanedIcon = icon.replacingOccurrences(of: "\\/", with: "/")
                    let fullURLString = (activityListModelObj?.imagePath ?? "") + "/" + cleanedIcon
                    if let url = URL(string: fullURLString) {
                        cell.dasboradImg.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
                    } else {
                        cell.dasboradImg.image = UIImage(named: "placeholder")
                    }
                }
                
            }
           return cell
            
        } else if collectionView == experinceActiviyvollotionView {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "experiencecell", for: indexPath) as! ExperinceactivityCell
            
            if let activities = self.activityListModelObj?.data,
               indexPath.row < activities.count {
                
                let activity = activities[indexPath.row]
        
                cell.activityName.text = activity.name
                
                cell.todayHours.setTodayHoursText(hours: activity.today_hours)
                
//                cell.rating.text = "\(activity.rating ?? "0.0") (\(activity.rating_count ?? 0))"
                
                let ratingValueDouble = activity.rating ?? "0.0"
            
                let ratingCount = " (\(activity.rating_count ?? 0))"
                let text = ratingValueDouble + ratingCount

                let attr = NSMutableAttributedString(string: text)
                attr.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 14), range: NSRange(location: 0, length: ratingValueDouble.count))
                attr.addAttribute(.foregroundColor, value: #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1), range: NSRange(location: 0, length: ratingValueDouble.count))


                attr.addAttribute(.font, value: UIFont.systemFont(ofSize: 13), range: NSRange(location: ratingValueDouble.count, length: ratingCount.count))
                attr.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: ratingValueDouble.count, length: ratingCount.count))

                cell.rating.attributedText = attr

                cell.activity_price.setPriceText(price: activity.activity_price ?? "")
                
                cell.activityName.text = activity.name
                cell.wishListImg.image = activity.is_wish == true
                    ? #imageLiteral(resourceName: "greenheart")
                    : #imageLiteral(resourceName: "hearttt")

                cell.likeBtn = { [weak self] in
                    guard let self = self else { return }
                    

                    if let id = activity.id {
                        self.wishListApi(activity_id: id)
                    }
                    self.activityListModelObj?.data?[indexPath.row].is_wish?.toggle()
                    self.experinceActiviyvollotionView.reloadData()
                }
            }
            if let activities = activityListModelObj?.data, indexPath.row < activities.count {
                let activity = activities[indexPath.row]
                if let icon = activity.image {
                    let cleanedIcon = icon.replacingOccurrences(of: "\\/", with: "/")
                    let fullURLString = (activityListModelObj?.imagePath ?? "") + "/" + cleanedIcon
                    if let url = URL(string: fullURLString) {
                        cell.experinceImg.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
                    } else {
                        cell.experinceImg.image = UIImage(named: "placeholder")
                    }
                }
            }

            return cell
            //==================================
       
            
        } else if collectionView == exploreCollectionView {
            let cell = exploreCollectionView.dequeueReusableCell(withReuseIdentifier: "explorecell", for: indexPath) as! ExplreCatagoriesCell
            cell.categoryLable.text = categoriesModelObj?.data?[indexPath.row].name
            
            if let icon = categoriesModelObj?.data?[indexPath.row].icon {
                let cleanedIcon = icon.replacingOccurrences(of: "\\/", with: "/")
                  let fullURLString = image_Url + cleanedIcon
                
                if let url = URL(string: fullURLString) {
                    cell.iconImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
                } else {
                    cell.iconImageView.image = UIImage(named: "placeholder")
                }
            }
            didselctletCategoryId = categoriesModelObj?.data?[indexPath.row].id
        
            cell.setSelected(selectedIndexes.contains(indexPath))
            return cell
            
        } else if collectionView == experinceActiviyvollotionViewSecond {
            let cell = experinceActiviyvollotionViewSecond.dequeueReusableCell(withReuseIdentifier: "experiencecellSecond", for: indexPath) as! ExploreActivitySecondCell
            let activityDict = activityListModelObj?.data?[indexPath.row]

            
            cell.activityName.text = activityDict?.name
            
            cell.todayHours.setTodayHoursText(hours: activityDict?.today_hours)
            
//            cell.rating.text = activityDict?.rating ?? ""
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
            
            if let activity = self.activityListModelObj?.data?[indexPath.row] {
                cell.activityName.text = activity.name
                cell.wishListImg.image = activity.is_wish == true
                    ? #imageLiteral(resourceName: "greenheart")
                    : #imageLiteral(resourceName: "hearttt")

                cell.likeBtn = { [weak self] in
                    guard let self = self else { return }
                 

                    if let id = activity.id {
                        self.wishListApi(activity_id: id)
                    }
                    self.activityListModelObj?.data?[indexPath.row].is_wish?.toggle()
                    self.experinceActiviyvollotionViewSecond.reloadData()
                }
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
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == discovercollectionView {
            let size = (discovercollectionView.frame.width - 2) / 2
            return CGSize(width: size, height: size)
        } else if collectionView == experinceActiviyvollotionView {
            let size = (experinceActiviyvollotionView.frame.width - 2) / 2
            return CGSize(width: size, height: 220)
        } else if collectionView == exploreCollectionView {
            let size = exploreCollectionView.frame.width - 2
            return CGSize(width: size, height: 220)
        } else if collectionView == experinceActiviyvollotionViewSecond {
            let size = (experinceActiviyvollotionViewSecond.frame.width - 2) / 2
            return CGSize(width: size, height: 220)
        }
        let defaultSize = (collectionView.frame.width - 2) / 2
        return CGSize(width: defaultSize, height: defaultSize)
    }
    //kfndkjnv
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == exploreCollectionView {
            guard let categoryId = categoriesModelObj?.data?[indexPath.row].id,
                  let cell = collectionView.cellForItem(at: indexPath) as? ExplreCatagoriesCell else { return }
            
            if selectedIndexes.contains(indexPath) {
                // Deselect
                selectedIndexes.removeAll { $0 == indexPath }
                collectionView.deselectItem(at: indexPath, animated: false)
                cell.setSelected(false)
            } else {
                // Clear previous selection (single selection only)
                selectedIndexes.removeAll()
                for visibleIndex in collectionView.indexPathsForVisibleItems {
                    if let visibleCell = collectionView.cellForItem(at: visibleIndex) as? ExplreCatagoriesCell {
                        visibleCell.setSelected(false)
                    }
                }
                selectedIndexes.append(indexPath)
                cell.setSelected(true)
                
                // Call API with selected categoryId
                didselctletCategoryId = categoryId
                activityListApi(category_id: categoryId)
            }
        }
        else if collectionView == experinceActiviyvollotionView {
            
            if let activities = activityListModelObj?.data,
               indexPath.row < activities.count,
               let cell = collectionView.cellForItem(at: indexPath) as? ExperinceactivityCell {
                
                let categoryId = activities[indexPath.row].id ?? 0
                UserDefaults.standard.set(categoryId, forKey: "id")
                
//                let acname = activities[indexPath.row].name ?? ""
//                UserDefaults.standard.set(acname, forKey: "name")
                
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "ActivityScreenVC") as! ActivityScreenVC
                nav.didselctletCategoryId = categoryId
                
                nav.openTime = activities[indexPath.row].today_hours ?? ""
                self.navigationController?.pushViewController(nav, animated: true)
                
            }
        }
        else if collectionView == experinceActiviyvollotionViewSecond {
            guard let categoryId = activityListModelObj?.data?[indexPath.row].id,
                  let cell = collectionView.cellForItem(at: indexPath) as? ExploreActivitySecondCell else { return }
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "ActivityScreenVC") as! ActivityScreenVC
            nav.didselctletCategoryId = categoryId
            self.navigationController?.pushViewController(nav, animated: true)
        }
        else if collectionView == discovercollectionView {
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "SearcResultExplorVc") as! SearcResultExplorVc
       
            nav.myvalue = "\(discoverdestinationObj?.data?[indexPath.row].branch_name ?? "") (\(discoverdestinationObj?.data?[indexPath.row].activity_count ?? 0))"
            nav.didselctletCategoryId = discoverdestinationObj?.data?[indexPath.row].branch_id
            nav.myvalueapicallS = "apicalls"
            self.navigationController?.pushViewController(nav, animated: true)
        }
        
    }
    
}
    
    extension DashboardVc {
        func exploreCategoriesApi() {
            let param = [String:Any]()
            
            print(param)
            
            ExploreCategoriesViewModel.exploreCategoriesApi(viewController: self, parameters: param as NSDictionary) {(response) in
                self.categoriesModelObj = response
                print("jai hind")
                self.exploreCollectionView.reloadData()
            }
        }
        func activityListApi(category_id: Int? = nil, isInitialLoad: Bool = false) {
            var param: [String: Any] = [:]
            
            if let id = category_id {
                param["category_id"] = id
            } else {
                param["category_id"] = ""
            }
            
            print("API Params:", param)
            
            ActivityListViewModel.activityListApi(viewController: self, parameters: param as NSDictionary) { response in
                self.activityListModelObj = response
                
                if isInitialLoad {
                    self.experinceActiviyvollotionView.reloadData()
                    self.experinceActiviyvollotionViewSecond.reloadData()
                } else {
                    self.experinceActiviyvollotionViewSecond.reloadData()
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
//        func discoverdestinationApi() {
//            let param = [String:Any]()
//            
//            print(param)
//            
//            DiscoverDestinationViewModel.discoverDestinationApi(viewController: self, parameters: param as NSDictionary) {(response) in
//                self.discoverdestinationObj = response
//                print("jai hind")
//                self.discovercollectionView.reloadData()
//            }
//        }
        func discoverdestinationApi(page: Int) {
            let param = ["page": page]
            print("📤 Params:", param)

            DiscoverDestinationViewModel.discoverDestinationApi(viewController: self, parameters: param as NSDictionary) { response in
                guard let response = response else { return }

                if page == 1 {
                    // 🔄 First page: Replace
                    self.discoverdestinationObj = response
                } else {
                    // 📥 Next pages: Append new data
                    var existingData = self.discoverdestinationObj?.data ?? []
                    existingData.append(contentsOf: response.data ?? [])
                    self.discoverdestinationObj?.data = existingData
                }

                // 📊 Update pagination info
                self.current_page = response.current_page ?? 1
                self.total_pages = response.last_page ?? 1
                self.isLoading = false

                print("✅ Page \(self.current_page) of \(self.total_pages)")
                self.discovercollectionView.reloadData()
            }
        }



    }
extension DashboardVc {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == discovercollectionView {
            let totalItems = discoverdestinationObj?.data?.count ?? 0

            // When last cell is about to show
            if indexPath.row == totalItems - 1 && !isLoading && current_page < total_pages {
                isLoading = true
                pageId += 1
                discoverdestinationApi(page: pageId)
            }
        }
    }

}
