//
//  BookActivityStep5thVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 26/08/25.
//

import UIKit

class BookActivityStep5thVc: UIViewController {
    var activityname: String?
    @IBOutlet weak var activitynameLbl: UILabel!
    var notificationcountModelObj:NotificationCountModel?
    @IBOutlet weak var countLable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityname = UserDefaults.standard.string(forKey: "name") ?? ""
        activitynameLbl.text = activityname
        
    }
    override func viewWillAppear(_ animated: Bool) {
        notificationCountListApi()
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
        
    }
    @IBAction func nextBtnAction(_ sender: Any) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        self.navigationController?.pushViewController(nav, animated: false)
    }
    
    @IBAction func notificationAction(_ sender: Any) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVc") as! NotificationVc
              self.navigationController?.pushViewController(nav, animated: true)
    }
}
extension BookActivityStep5thVc {
    func notificationCountListApi(){
                let param = [String:Any]()
                NotificationListViewModel.notificationCountListApi(viewController: self, parameters: param as NSDictionary) {  response in
                    self.notificationcountModelObj = response
                    self.countLable.text = "\(self.notificationcountModelObj?.data ?? 0)"

                    print("Success")
                }
            }
}
