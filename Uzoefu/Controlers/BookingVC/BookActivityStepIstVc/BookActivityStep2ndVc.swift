//
//  BookActivityStep2ndVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 26/08/25.
//

import UIKit

class BookActivityStep2ndVc: UIViewController {
    
    @IBOutlet weak var fullNameTf: FloatingTextField!
    @IBOutlet weak var sirNameTF: FloatingTextField!
    @IBOutlet weak var firstNameTf: FloatingTextField!
    
    
    @IBOutlet weak var countLable: UILabel!
    @IBOutlet weak var addressTf: FloatingTextField!
    @IBOutlet weak var mobileNumberTf: FloatingTextField!
    var notificationcountModelObj:NotificationCountModel?
    var getProfileModelObj:ProfileModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getprofileApi()
        notificationCountListApi()
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookActivityStep3rdVc") as! BookActivityStep3rdVc
        self.navigationController?.pushViewController(nav, animated: false)
        UserDefaults.standard.setValue(self.mobileNumberTf.text, forKey: "mobile")
        UserDefaults.standard.setValue(self.addressTf.text, forKey: "add")
        UserDefaults.standard.setValue(self.fullNameTf.text, forKey: "user")
    }
    
    
    @IBAction func notificationAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVc") as! NotificationVc
              self.navigationController?.pushViewController(nav, animated: true)
    }
}
extension BookActivityStep2ndVc {
    func getprofileApi() {
        let param = [String:Any]()
        
        print(param)
        
        ProfileViewModel.getProfileApi(viewController: self, parameters: param as NSDictionary) {(response) in
            self.getProfileModelObj = response
            self.fullNameTf.text = "\(self.getProfileModelObj?.data?.name ?? "") \(self.getProfileModelObj?.data?.lastname ?? "")"
            
            self.firstNameTf.text = self.getProfileModelObj?.data?.name ?? ""
            self.sirNameTF.text = self.getProfileModelObj?.data?.lastname ?? ""
            self.fullNameTf.text = "\(self.getProfileModelObj?.data?.name ?? "") \(self.getProfileModelObj?.data?.lastname ?? "")"
            
            
            
            
            
            if let apiMobile = self.getProfileModelObj?.data?.mobile, !apiMobile.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                // API ne non-empty value di
                self.mobileNumberTf.text = apiMobile
            } else {
                // API value empty ya nil hai -> user ka input allow karein
                // Textfield ko blank hi rehne dein
                self.mobileNumberTf.text = self.mobileNumberTf.text
                UserDefaults.standard.setValue(self.mobileNumberTf.text, forKey: "mobile")
            }
            if let apiadd = self.getProfileModelObj?.data?.city, !apiadd.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                // API ne non-empty value di
                self.addressTf.text = apiadd
            } else {
                // API value empty ya nil hai -> user ka input allow karein
                // Textfield ko blank hi rehne dein
                self.addressTf.text = self.mobileNumberTf.text
                UserDefaults.standard.setValue(self.mobileNumberTf.text, forKey: "add")
            }
            if let apiuser = self.getProfileModelObj?.data?.username, !apiuser.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                // API ne non-empty value di
                self.fullNameTf.text = apiuser
            } else {
                // API value empty ya nil hai -> user ka input allow karein
                // Textfield ko blank hi rehne dein
                self.fullNameTf.text = self.fullNameTf.text
                UserDefaults.standard.setValue(self.fullNameTf.text, forKey: "user")
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
