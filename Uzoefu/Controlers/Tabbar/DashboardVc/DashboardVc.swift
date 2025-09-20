import UIKit

class DashboardVc: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myscrolleview: UIScrollView!
    @IBOutlet weak var experinceActiviyvollotionView: UICollectionView!
    @IBOutlet weak var discovercollectionView: UICollectionView!
    @IBOutlet weak var exploreCollectionView: UICollectionView!
    @IBOutlet weak var experinceActiviyvollotionViewSecond: UICollectionView!
    

  
    @IBOutlet weak var scroolView: UIScrollView!
    var categoriesModelObj:ExploreCategoriesModel?
    var activityListModelObj:ActivityListModel?
    var wishListmodelObj:WishListModel?
    var activity_idselected:Int?
    var selectedIndexes: [IndexPath] = []
    var didselctletCategoryId :Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = vc.sheetPresentationController {
            if #available(iOS 16.0, *) {     sheet.detents = [
                .custom { _ in
                    return 850
                }
            ]
            } else {
                sheet.detents = [.large()]
            }
            sheet.prefersGrabberVisible = true
        }
        
        present(vc, animated: true)
    }
}
//nwcode

// MARK: - UICollectionView Delegate & DataSource
extension DashboardVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == discovercollectionView {
            return 9
        } else if collectionView == experinceActiviyvollotionView {
            return activityListModelObj?.data?.activities?.count ?? 0
            
        } else if collectionView == exploreCollectionView {
            return categoriesModelObj?.data?.count ?? 0
        } else if collectionView == experinceActiviyvollotionViewSecond {
            return activityListModelObj?.data?.activities?.count ?? 0
            
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == discovercollectionView {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "discovercell", for: indexPath) as! discoverdestinationCell
        } else if collectionView == experinceActiviyvollotionView {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "experiencecell", for: indexPath) as! ExperinceactivityCell
            
            if let activities = self.activityListModelObj?.data?.activities,
               indexPath.row < activities.count {
                
                let activity = activities[indexPath.row]
        
                cell.activityName.text = activity.name
                
                cell.todayHours.setTodayHoursText(hours: activity.today_hours)
                
                cell.rating.text = activity.rating ?? ""
                cell.activity_price.setPriceText(price: activity.activity_price ?? 0)
                
                
                
                
                cell.activityName.text = activity.name
                cell.wishListImg.image = activity.is_wish == true
                    ? #imageLiteral(resourceName: "greenheart")
                    : #imageLiteral(resourceName: "hearttt")

                cell.likeBtn = { [weak self] in
                    guard let self = self else { return }
                    

                    if let id = activity.id {
                        self.wishListApi(activity_id: id)
                    }
                    self.activityListModelObj?.data?.activities?[indexPath.row].is_wish?.toggle()
                    self.experinceActiviyvollotionView.reloadData()
                }
            }

            
            
            if let activities = activityListModelObj?.data?.activities, indexPath.row < activities.count {
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
            let activityDict = activityListModelObj?.data?.activities?[indexPath.row]

            
            cell.activityName.text = activityDict?.name
            
            cell.todayHours.setTodayHoursText(hours: activityDict?.today_hours)
            
            cell.rating.text = activityDict?.rating ?? ""
            cell.activity_price.setPriceText(price: activityDict?.activity_price ?? 0)
            
            if let activity = self.activityListModelObj?.data?.activities?[indexPath.row] {
                cell.activityName.text = activity.name
                cell.wishListImg.image = activity.is_wish == true
                    ? #imageLiteral(resourceName: "greenheart")
                    : #imageLiteral(resourceName: "hearttt")

                cell.likeBtn = { [weak self] in
                    guard let self = self else { return }
                 

                    if let id = activity.id {
                        self.wishListApi(activity_id: id)
                    }
                    self.activityListModelObj?.data?.activities?[indexPath.row].is_wish?.toggle()
                    self.experinceActiviyvollotionViewSecond.reloadData()
                }
            }
            
            
            if let icon = activityListModelObj?.data?.activities?[indexPath.row].image {
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
            
            if let activities = activityListModelObj?.data?.activities,
               indexPath.row < activities.count,
               let cell = collectionView.cellForItem(at: indexPath) as? ExperinceactivityCell {
                
                let categoryId = activities[indexPath.row].id ?? 0
                
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "ActivityScreenVC") as! ActivityScreenVC
                nav.didselctletCategoryId = categoryId
                self.navigationController?.pushViewController(nav, animated: true)
                
            }
        }
        else if collectionView == experinceActiviyvollotionViewSecond {
            guard let categoryId = activityListModelObj?.data?.activities?[indexPath.row].id,
                  let cell = collectionView.cellForItem(at: indexPath) as? ExploreActivitySecondCell else { return }
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "ActivityScreenVC") as! ActivityScreenVC
            nav.didselctletCategoryId = categoryId
            self.navigationController?.pushViewController(nav, animated: true)
        }
        
    }
    
}
    
    extension DashboardVc {
        func exploreCategoriesApi() {
            var param = [String:Any]()
            
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
        
        
        
    }
