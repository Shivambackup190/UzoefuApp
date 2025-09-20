//
//  WishListVC.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 12/08/25.
//woking Code

import UIKit

class WishListVC: UIViewController, UITextFieldDelegate {
    var hidevalue: String?
    @IBOutlet weak var creteTripBtnOutlet: UIButton!
    @IBOutlet weak var selectTripPopUpUiview: UIView!
    @IBOutlet weak var createTripPopUpUiview: UIView!
    @IBOutlet weak var selectTripCellTableView: UITableView!
    @IBOutlet weak var editButtonOutlet: UIButton!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var weidthBackConstraint: NSLayoutConstraint!
    @IBOutlet weak var backHideShowBtn: UIButton!
    @IBOutlet weak var wishListTableView: UITableView!
    @IBOutlet weak var showTripView: UIView!
    @IBOutlet weak var tittletripTF: FloatingTextField!
    @IBOutlet weak var destinationTextField: FloatingTextField!
    @IBOutlet weak var createTripUiview: UIView!
    
    @IBOutlet weak var createTittleTf: FloatingTextField!
    
    @IBOutlet weak var createdestinationTf: FloatingTextField!
    
    var wishlistdataModelobj: WishlistDataModel?
    var wishlistdataDeleteModelobj: WishlistDataDeleteModel?
    var adtivityId: Int?
    var selectedActivityIds: [Int] = []
    var isEditingMode = false
    var TripListModelObj:TripListModel?
    var createTripModelObj:AddTripModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        wishListTableView.allowsSelection = true
        tittletripTF.forwardDelegate = self
        destinationTextField.forwardDelegate = self
        
        showTripView.layer.cornerRadius = 20
        showTripView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        showTripView.clipsToBounds = true
        
        createTripUiview.layer.cornerRadius = 20
        createTripUiview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        createTripUiview.clipsToBounds = true
        
        blurView.isHidden = true
        selectTripPopUpUiview.isHidden = true
        createTripPopUpUiview.isHidden = true
        
        if hidevalue == "ok" {
            backHideShowBtn.isHidden = false
            weidthBackConstraint.constant = 40
        } else {
            backHideShowBtn.isHidden = true
            weidthBackConstraint.constant = 0
        }
        
        let nib = UINib(nibName: "WishListTableViewCell", bundle: nil)
        wishListTableView.register(nib, forCellReuseIdentifier: "cell")
        
        wishListTableView.delegate = self
        wishListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        blurView.isHidden = true
        editButtonOutlet.isHidden = false
        wishlistdataApi()
        isEditingMode = false
        tripListApi()
    }
    
    
    @IBAction func createTripAction(_ sender: UIButton) {
        createtripListApi()
    }
    @IBAction func backActionBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        blurView.isHidden = true
        editButtonOutlet.isHidden = false
        backHideShowBtn.isHidden = true
    }
    
    @IBAction func deleteButtonActtion(_ sender: UIButton) {
        if selectedActivityIds.isEmpty {
                let alert = UIAlertController(title: "No Selection",
                                              message: "Please select items to delete.",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
            } else {
              
                let alert = UIAlertController(title: "Are you sure?",
                                              message: "Do you really want to delete the selected items from your wishlist?",
                                              preferredStyle: .alert)
                
                // Cancel button
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                
                // Confirm delete
                alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
                    self?.wishlistdeletedataApi()
                }))
                
                present(alert, animated: true)
            }
    }
    
    @IBAction func notificationAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVc") as! NotificationVc
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    @IBAction func dissmissselctTripAction(_ sender: UIButton) {
        selectTripPopUpUiview.isHidden = true
    }
    
    @IBAction func dissmissCreateTripAction(_ sender: UIButton) {
        createTripPopUpUiview.isHidden = true
        selectTripPopUpUiview.isHidden = false
    }
    
    @IBAction func editbuttonAction(_ sender: UIButton) {
        blurView.isHidden = false
        editButtonOutlet.isHidden = true
        backHideShowBtn.isHidden = true
        weidthBackConstraint.constant = 0
        wishListTableView.reloadData()
        isEditingMode = true
    }
    
    @IBAction func selecttripPlannerAction(_ sender: UIButton) {
        selectTripPopUpUiview.isHidden = false
    }
    
    @IBAction func createNewTripActionBtn(_ sender: UIButton) {
        createTripPopUpUiview.isHidden = false
        selectTripPopUpUiview.isHidden = true
        creteTripBtnOutlet.backgroundColor = #colorLiteral(red: 0.9176, green: 0.9255, blue: 0.9294, alpha: 1.0)
        creteTripBtnOutlet.setTitleColor(.gray, for: .normal)
    }
    
    @IBAction func menuBtnAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        self.navigationController?.pushViewController(nav, animated: true)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension WishListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == selectTripCellTableView {
            return TripListModelObj?.data?.count ?? 0
        } else {
            return wishlistdataModelobj?.data?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == selectTripCellTableView {
            let cell = selectTripCellTableView.dequeueReusableCell(withIdentifier: "selectTripCell", for: indexPath) as! selectTripCell
            cell.triptittle.text = TripListModelObj?.data?[indexPath.row].title
            cell.tripDestination.text = TripListModelObj?.data?[indexPath.row].destination
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = wishListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WishListTableViewCell
            let wishDict = wishlistdataModelobj?.data?[indexPath.row]
            
            cell.editImageOutlet.isHidden = !isEditingMode
            
           
            if let id = wishDict?.id, selectedActivityIds.contains(id) {
                cell.editImageOutlet.image = #imageLiteral(resourceName: "radioslected")
            } else {
                cell.editImageOutlet.image = UIImage(named: "circleimg")
            }
            
            cell.wishlistName.text = wishDict?.name
            cell.priceable.text = String(wishDict?.price ?? 0)
            cell.rating_count.text = "(\(wishDict?.ratingCount ?? 0))"
            
            if let icon = wishDict?.image {
                let cleanedIcon = icon.replacingOccurrences(of: "\\/", with: "/")
                let fullURLString = imagePathUrl + cleanedIcon
                if let url = URL(string: fullURLString) {
                    cell.wishlistImg.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
                } else {
                    cell.wishlistImg.image = UIImage(named: "wishListImg")
                }
            }
            
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == wishListTableView {
            guard let id = wishlistdataModelobj?.data?[indexPath.row].id else { return }
            
            if isEditingMode {
                // ✅ Only toggle selection in edit mode
                if let cell = tableView.cellForRow(at: indexPath) as? WishListTableViewCell {
                    if selectedActivityIds.contains(id) {
                        selectedActivityIds.removeAll { $0 == id }
                        cell.editImageOutlet.image = UIImage(named: "circleimg")
                    } else {
                        selectedActivityIds.append(id)
                        cell.editImageOutlet.image = UIImage(named: "radioslected")
                    }
                }
            } else {
                // ✅ Normal mode → navigate//ikmoikomo
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "ActivityScreenVC") as! ActivityScreenVC
                nav.didselctletCategoryId = wishlistdataModelobj?.data?[indexPath.row].activity_id
                self.navigationController?.pushViewController(nav, animated: true)
            }
            
        } else if tableView == selectTripCellTableView {
            print("Trip cell selected at row \(indexPath.row)")
        }
    }

}

extension WishListVC {
    // MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        creteTripBtnOutlet.backgroundColor = #colorLiteral(red: 0.4941176471, green: 0.8235294118, blue: 0, alpha: 1)
        creteTripBtnOutlet.setTitleColor(.white, for: .normal)
    }
    
    func wishlistdataApi() {
        let param = [String: Any]()
        WishListViewModel.wishListDataApi(viewController: self, parameters: param as NSDictionary) { [weak self] response in
            guard let self = self else { return }
            self.wishlistdataModelobj = response
            
            self.selectedActivityIds.removeAll()
            
            self.wishListTableView.reloadData()
        }
    }

    
    func wishlistdeletedataApi() {
        let validIds = Set(wishlistdataModelobj?.data?.compactMap { $0.id } ?? [])
        let filteredIds = selectedActivityIds.filter { validIds.contains($0) }
        
        let param: [String: Any] = ["wishlist_id": filteredIds]
        print(param)
        
        WishListViewModel.wishListDataDeleteApi(viewController: self, parameters: param as NSDictionary) { [weak self] response in
            guard let self = self else { return }
            self.wishlistdataDeleteModelobj = response
            self.wishlistdataApi()
        }
    }
    func tripListApi() {
       
        let param = [String:Any]()
        print(param)
        
        TripviewModel.TripListApi(viewController: self, parameters: param as NSDictionary) { [weak self] response in
            guard let self = self else { return }
            self.TripListModelObj = response
            self.selectTripCellTableView.reloadData()
            
        }
    }
    func createtripListApi() {
       
        var param = [String:Any]()
        param = ["title":createTittleTf.text ?? "","destination":destinationTextField.text ?? ""]
        print(param)
        
        TripviewModel.AddTripListApi(viewController: self, parameters: param as NSDictionary) { [weak self] response in
            guard let self = self else { return }
            self.createTripModelObj = response
            CommonMethods.showAlertMessage(title: "", message: response?.message ?? "", view: self)
            print("sucess")
            createTittleTf.text = ""
            destinationTextField.text = ""
            tripListApi()
            
        }
    }

}
