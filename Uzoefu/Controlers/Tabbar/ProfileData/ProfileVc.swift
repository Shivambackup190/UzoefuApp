import UIKit

class ProfileVc: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var overviewButton: UIButton!
    
    @IBOutlet weak var overViewLable: UILabel!
    
    @IBOutlet weak var overViewcolor: UIView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var rewardsButton: UIButton!
    @IBOutlet weak var companiesButton: UIButton!
    
    @IBOutlet weak var profileColor: UIView!
    
    
    @IBOutlet weak var companiesLabel: UILabel!
    @IBOutlet weak var rewardsColor: UIView!
    
    @IBOutlet weak var profileLabel: UILabel!
    
    @IBOutlet weak var rewardsLabel: UILabel!
    
    
    @IBOutlet weak var companiesColor: UIView!
    
    var currentIndex = 0
    private var currentView: UIView?
    var firstView:FirstView!
    var secondView:SecondView!
    var thirdView:ThirdView!
    var fourthView:FourthView!
    var loadNib = [UIView]()
    
    var logoutObj:LogOutModel?
    var getProfileModelObj:ProfileModel?
    var updateProfileModelObj:UpdateProfileModel?
    var updateProfileImageModelObj:UpdateProfileImageModel?
    var categoriesModelObj:ExploreCategoriesModel?
    var didselctletCategoryId:Int?
    var profieImg:UIImage?
    var selectedIndexes: [IndexPath] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstView = (Bundle.main.loadNibNamed("FirstView", owner: self, options: nil)![0] as! FirstView)
        secondView = (Bundle.main.loadNibNamed("SecondView", owner: self, options: nil)![0] as! SecondView)
        thirdView = (Bundle.main.loadNibNamed("ThirdView", owner: self, options: nil)![0] as! ThirdView)
        fourthView = (Bundle.main.loadNibNamed("FourthView", owner: self, options: nil)![0] as! FourthView)
        
        
        loadNib.append(firstView)
        loadNib.append(secondView)
        loadNib.append(thirdView)
        loadNib.append(fourthView)
        
        for i in loadNib {
            i.frame = containerView.bounds
            containerView.addSubview(i)
            
        }
        containerView.clipsToBounds = true
        containerView.bringSubviewToFront(loadNib[0])
        
        
        loadthirdViewCell()
        
        selectFavourteNib()
        
        bookingBtnAction()
        logOutAction()
        getprofileApi()
        exploreCategoriesApi()
        
        wishlistBtnAction()
        plusCompannyActionBtn()
        nearbyActionBtn()
        saveProfileAction()
        profilechangeBtnAction()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        containerView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        containerView.addGestureRecognizer(swipeRight)
        
    }
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            if currentIndex < loadNib.count - 1 {
                changeTab(index: currentIndex + 1)
            }
        } else if gesture.direction == .right {
            if currentIndex > 0 {
                changeTab(index: currentIndex - 1)
            }
        }
    }
    
    func changeTab(index: Int) {
        guard index != currentIndex else { return }
        
        let oldView = loadNib[currentIndex]
        let newView = loadNib[index]
        let direction: CGFloat = index > currentIndex ? 1 : -1
        let width = containerView.bounds.width
        
        newView.frame = containerView.bounds.offsetBy(dx: direction * width, dy: 0)
        containerView.addSubview(newView)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            oldView.frame = self.containerView.bounds.offsetBy(dx: -direction * width, dy: 0)
            newView.frame = self.containerView.bounds
        }, completion: { _ in
            oldView.removeFromSuperview()
        })
        
        resetAllTabs()
        switch index {
        case 0: selectTab(colorView: overViewcolor, label: overViewLable)
        case 1: selectTab(colorView: profileColor, label: profileLabel)
        case 2: selectTab(colorView: rewardsColor, label: rewardsLabel)
       // case 3: selectTab(colorView: companiesColor, label: companiesLabel)
        default: break
        }
        
        currentIndex = index
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // MARK: - Button Actions
    @IBAction func overViewBtnAction(_ sender: UIButton) {
        changeTab(index: 0)
    }
    
    @IBAction func profileBtnAction(_ sender: UIButton) {
        changeTab(index: 1)
    }
    
    @IBAction func rewardBtnAction(_ sender: UIButton) {
        changeTab(index: 2)
    }
    
    @IBAction func companiesBtnAction(_ sender: UIButton) {
        changeTab(index: 3)
    }
    
    func loadthirdViewCell() {
        let nib = UINib(nibName: "CompanyTableCell", bundle: nil)
        thirdView.rewardTableView.register(nib, forCellReuseIdentifier: "CompanyTableCell")
        
        thirdView.rewardTableView.delegate = self
        thirdView.rewardTableView.dataSource = self
        thirdView.rewardTableView.allowsSelection = true
    }
    func selectFavourteNib() {
        let nibb = UINib(nibName: "SelectFavouriteActivityCell", bundle: nil)
        secondView.selectFoavariteCollection.register(nibb, forCellWithReuseIdentifier: "SelectFavouriteActivityCell")
        
        secondView.selectFoavariteCollection.delegate = self
        secondView.selectFoavariteCollection.dataSource = self
    }
    
}
extension ProfileVc:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = thirdView.rewardTableView.dequeueReusableCell(withIdentifier: "CompanyTableCell", for: indexPath) as! CompanyTableCell
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //   let nav = self.storyboard?.instantiateViewController(identifier: "CompanyDetailsVC") as! CompanyDetailsVC
       // self.navigationController?.pushViewController(nav, animated: true)
    }
    func resetAllTabs() {
        let defaultColor = #colorLiteral(red: 0.4512393475, green: 0.4832214117, blue: 0.4951165318, alpha: 1)
        let defaultText = #colorLiteral(red: 0.4512393475, green: 0.4832214117, blue: 0.4951165318, alpha: 1)
        overViewcolor.isHidden = true
        profileColor.isHidden = true
        rewardsColor.isHidden = true
     
        
        overViewcolor.backgroundColor = defaultColor
        profileColor.backgroundColor = defaultColor
        rewardsColor.backgroundColor = defaultColor
    
        overViewLable.textColor = defaultText
        profileLabel.textColor = defaultText
        rewardsLabel.textColor = defaultText
   
    }
    func selectTab(colorView: UIView, label: UILabel) {
        let selectedColor = #colorLiteral(red: 0.1960784314, green: 0.8039215686, blue: 0.03807460484, alpha: 1)
        
        colorView.isHidden = false
        colorView.backgroundColor = selectedColor
        label.textColor = selectedColor
    }
    
}
extension ProfileVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesModelObj?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectFavouriteActivityCell", for: indexPath) as! SelectFavouriteActivityCell
        cell.activityLable.text = categoriesModelObj?.data?[indexPath.row].name
        
        if let icon = categoriesModelObj?.data?[indexPath.row].icon {
          
            let cleanedIcon = icon.replacingOccurrences(of: "\\/", with: "/")
            
            let fullURLString = image_Url + cleanedIcon
            
            if let url = URL(string: fullURLString) {
                cell.activityImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
            } else {
                cell.activityImage.image = UIImage(named: "placeholder")
            }
        }
        didselctletCategoryId = categoriesModelObj?.data?[indexPath.row].id
        cell.setSelected(selectedIndexes.contains(indexPath))
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = secondView.selectFoavariteCollection.dequeueReusableCell(withReuseIdentifier: "SelectFavouriteActivityCell", for: indexPath) as! SelectFavouriteActivityCell
        if selectedIndexes.contains(indexPath) {
            selectedIndexes.removeAll { $0 == indexPath }
            secondView.selectFoavariteCollection.deselectItem(at: indexPath, animated: false)
            cell.setSelected(false)
        } else {
           
            selectedIndexes.removeAll()
            for visibleIndex in secondView.selectFoavariteCollection.indexPathsForVisibleItems {
                if let visibleCell = secondView.selectFoavariteCollection.cellForItem(at: visibleIndex) as? ExplreCatagoriesCell {
                    visibleCell.setSelected(false)
                }
            }
            selectedIndexes.append(indexPath)
            cell.setSelected(true)
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        let width = collectionView.bounds.width/3
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func bookingBtnAction() {
        firstView.BookingAction = {
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookingVC") as! BookingVC
            
            self.navigationController?.pushViewController(nav, animated: true)
        }
        
    }
    func logOutAction() {
        firstView.logOutActionAction = {
            let alert = UIAlertController(
                title: "Logout !",
                message: "Are you sure you want to log out?",
                preferredStyle: .alert
            )
            
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            cancelAction.setValue(UIColor.systemGreen, forKey: "titleTextColor")
            
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.logOutApi()
                
                
            }
            okAction.setValue(UIColor.systemGreen, forKey: "titleTextColor")
            
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    func profilechangeBtnAction() {
        firstView.profileimageChangeActionAction = {
            let alert = UIAlertController(title: "Select Photo", message: "Select From", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.showImagePicker(selectedSource: .camera)
                
            }))
            
            alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                self.showImagePicker(selectedSource: .photoLibrary)
            }))
            
            // Cancel Button - Dismisses the alert
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    //MARK: - Select  Photo from Gallery
    func showImagePicker(selectedSource: UIImagePickerController.SourceType){
        guard UIImagePickerController.isSourceTypeAvailable(selectedSource) else {
            print("Selected source not Available")
            return
        }
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = selectedSource
        picker.allowsEditing = false
        self.present(picker, animated: true, completion: nil)
    }
      
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let img = info[.originalImage]as? UIImage{
                self.firstView.profileImageOutLet.image = img
                profileImageUpdateApi()
                //self.selectedProfile = img
            }
            self.dismiss(animated: true, completion: nil)
        }
    
    
    func wishlistBtnAction() {
        firstView.WishListAction = {
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "WishListVC") as! WishListVC
            nav.hidevalue = "ok"
            self.navigationController?.pushViewController(nav, animated: true)
            
            //            self.tabBarController?.selectedIndex = 2
        }
    }
    func plusCompannyActionBtn() {
        fourthView.addMoreCampanyActionBtn = {
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "BussinessProfileSetupVc") as! BussinessProfileSetupVc
            
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
    func nearbyActionBtn() {
        secondView.nearloactionBtn = { [weak self] in
            guard let self = self else { return }
            
            let alert = UIAlertController(title: "Select Your Range", message: nil, preferredStyle: .actionSheet)
            
            let ranges = ["5 Km", "10 Km", "15 Km", "20 Km"]
            
            for range in ranges {
                let action = UIAlertAction(title: range, style: .default, handler: { _ in
                    self.secondView.rangeTextField.text = range
                })
                action.setValue(UIColor.gray, forKey: "titleTextColor")
                alert.addAction(action)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            cancelAction.setValue(UIColor.systemGreen, forKey: "titleTextColor")
            alert.addAction(cancelAction)
            
            
            if let popover = alert.popoverPresentationController {
                popover.sourceView = self.view
                popover.sourceRect = CGRect(x: self.view.bounds.midX,
                                            y: self.view.bounds.midY,
                                            width: 0,
                                            height: 0)
                popover.permittedArrowDirections = []
            }
            self.present(alert, animated: true, completion: nil)
        }
    }
    func saveProfileAction() {
        secondView.profileSaveBtnAction = {
            self.UpdateProfileApi()
        }
    }
    
    
}
extension ProfileVc {
    func logOutApi() {
        let param = [String:Any]()
        
        print(param)
        
        LogoutViewModel.logoutApi(viewController: self, parameters: param as NSDictionary) {(response) in
            
            self.logoutObj = response
            
            print("jai hind")
            
            CommonMethods.showAlertMessageWithHandler(title: "", message: self.logoutObj?.message ?? "", view: self)
            {
                
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                self.navigationController?.pushViewController(nav, animated: false)
            }
        }
    }
    
    func getprofileApi() {
        let param = [String:Any]()
        
        print(param)
        
        ProfileViewModel.getProfileApi(viewController: self, parameters: param as NSDictionary) {(response) in
            self.getProfileModelObj = response
            self.firstView.userNameLabel.text = "\(self.getProfileModelObj?.data?.name ?? "") \(self.getProfileModelObj?.data?.lastname ?? "")"
            
            self.secondView.firstNameLable.text = self.getProfileModelObj?.data?.name ?? ""
            self.secondView.lastNameLable.text = self.getProfileModelObj?.data?.lastname ?? ""
            self.secondView.fullnameTxt.text = "\(self.getProfileModelObj?.data?.name ?? "") \(self.getProfileModelObj?.data?.lastname ?? "")"
            self.secondView.emailTf.text = self.getProfileModelObj?.data?.email ?? ""
            self.secondView.mobiletf.text = self.getProfileModelObj?.data?.mobile ?? ""
            self.secondView.addressTf.text = self.getProfileModelObj?.data?.city ?? ""
            self.secondView.dobTf.text = self.getProfileModelObj?.data?.dateofbirth ?? ""
            self.secondView.rangeTextField.text = "\(self.getProfileModelObj?.data?.distance ?? "") Km"
            
            
        }
    }
    
    func UpdateProfileApi() {
        var param = [String: Any]()
        
        param = [
            "first_name": secondView.firstNameLable.text ?? "",
            "surname": secondView.lastNameLable.text ?? "",
            "username": secondView.fullnameTxt.text ?? "",
            "mobile": secondView.mobiletf.text ?? "",
            "city": secondView.addressTf.text ?? "",
            "dateofbirth": secondView.dobTf.text ?? "",
            "distance": secondView.rangeTextField.text?.replacingOccurrences(of: " Km", with: "") ?? "","category_id": [1,2]
        ]
        
        print("Update Profile Params:", param)
        
        
        ProfileViewModel.updateProfileApi(viewController: self, parameters: param as NSDictionary) {(response) in
            self.updateProfileModelObj = response
            CommonMethods.showAlertMessage(title: "", message: response?.message ?? "", view: self)
            print( "Succes Updated")
        }
    }
    
    func profileImageUpdateApi() {
        var param = [String: Any]()
        param = ["image":firstView.profileImageOutLet.image ?? ""]
        
        print(param)
        self.profieImg = firstView.profileImageOutLet.image
        let imgData = (self.profieImg?.jpegData(compressionQuality: 0.4)!)!
        ProfileViewModel.updateProfileImageApi(viewController: self, parameters: param as NSDictionary,image: imgData, imageName: "image") { response in
            self.updateProfileImageModelObj = response
            print("API success!")
            CommonMethods.showAlertMessageWithHandler(title: "", message: self.updateProfileImageModelObj?.message ?? "", view: self) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func exploreCategoriesApi() {
        let param = [String:Any]()
        
        print(param)
        
        ExploreCategoriesViewModel.exploreCategoriesApi(viewController: self, parameters: param as NSDictionary) {(response) in
            self.categoriesModelObj = response
            print("jai hind")
            self.secondView.selectFoavariteCollection.reloadData()
        }
    }
}
