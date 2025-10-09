//
//  Settings.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 27/08/25.
//

import UIKit

class SettingsVC: UIViewController {
    @IBOutlet weak var setttleTbleView: UITableView!
    
    @IBOutlet weak var showSettingPopUp: UIView!
    @IBOutlet weak var SettingblurView: UIView!
    @IBOutlet weak var countLable: UILabel!
    var notificationcountModelObj:NotificationCountModel?
    let menuItems: [(icon: String, title: String)] = [
        ("about_icon", "About"),
        ("settings_icon", "Settings"),
        ("help_icon", "Help Centre"),
        ("feedback_icon", "Feedback"),
        ("legal_icon", "Legal"),
        ("share_icon", "Share"),
        ("signout_icon", "Sign Out")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSettingPopUp.layer.cornerRadius = 20
        showSettingPopUp.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        showSettingPopUp.clipsToBounds = true
      //  SettingblurView.isHidden = true
        setttleTbleView.separatorStyle = .none
       
    }
    override func viewWillAppear(_ animated: Bool) {
        notificationCountListApi()
    }
    
    
    @IBAction func dissMissblurViewAction(_ sender: UIButton) {
        SettingblurView.isHidden = true
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func opensettingBtn(_ sender: UIButton) {
        SettingblurView.isHidden = false
    }
    
}
extension SettingsVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = setttleTbleView.dequeueReusableCell(withIdentifier: "SettingTableCellID") as! SettingTableCell
        cell.titleLable.text = menuItems[indexPath.row].title
        
        cell.iconImage.image = UIImage(named: menuItems[indexPath.row].icon)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nav = self.storyboard?.instantiateViewController(identifier: "SettingsVC") as! SettingsVC
        SettingblurView.isHidden = true
    }
}
extension SettingsVC {
    func notificationCountListApi(){
           let param = [String:Any]()
           NotificationListViewModel.notificationCountListApi(viewController: self, parameters: param as NSDictionary) {  response in
               self.notificationcountModelObj = response
               self.countLable.text = "\(self.notificationcountModelObj?.data ?? 0)"

               print("Success")
           }
       }
}
