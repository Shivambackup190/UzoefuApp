//
//  WishListVC.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 12/08/25.
//

import UIKit


class WishListVC: UIViewController,UITextFieldDelegate {
    var hidevalue:String?
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
    override func viewDidLoad() {
        super.viewDidLoad()
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
        }
        else {
            backHideShowBtn.isHidden = true
            weidthBackConstraint.constant = 0
        }
        
     
        let nib = UINib(nibName: "WishListTableViewCell", bundle: nil)
        wishListTableView.register(nib, forCellReuseIdentifier: "cell")
        
        wishListTableView.delegate = self
        wishListTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        blurView.isHidden = true
        editButtonOutlet.isHidden = false
    }
    @IBAction func backActionBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        blurView.isHidden = true
        editButtonOutlet.isHidden = false
        backHideShowBtn.isHidden = true
        
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
    }
    
    @IBAction func selecttripPlannerAction(_ sender: UIButton) {
        selectTripPopUpUiview.isHidden = false
    }
    
    @IBAction func createNewTripActionBtn(_ sender: UIButton) {
        createTripPopUpUiview.isHidden = false
        selectTripPopUpUiview.isHidden = true
        creteTripBtnOutlet.backgroundColor = #colorLiteral(red: 0.9176, green: 0.9255, blue: 0.9294, alpha: 1.0)

        creteTripBtnOutlet.titleLabel?.textColor = .gray
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
            return 10
        }
        else {
            return 10
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == selectTripCellTableView {
            let cell = selectTripCellTableView.dequeueReusableCell(withIdentifier: "selectTripCell", for: indexPath) as! selectTripCell
            return cell
        }
        else {
            let cell = wishListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WishListTableViewCell
            return cell
        }
        
    }
    
    
}
extension WishListVC {
    // MARK: - UITextFieldDelegate
       func textFieldDidBeginEditing(_ textField: UITextField) {
           
           creteTripBtnOutlet.backgroundColor = #colorLiteral(red: 0.4941176471, green: 0.8235294118, blue: 0, alpha: 1)
           creteTripBtnOutlet.titleLabel?.textColor = .white
       }
    
    
   }

 
