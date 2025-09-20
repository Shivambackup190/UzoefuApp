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
    
    
    @IBOutlet weak var addressTf: FloatingTextField!
    @IBOutlet weak var mobileNumberTf: FloatingTextField!
    
    var getProfileModelObj:ProfileModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getprofileApi()
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookActivityStep3rdVc") as! BookActivityStep3rdVc
        self.navigationController?.pushViewController(nav, animated: false)
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
            
            self.mobileNumberTf.text = self.getProfileModelObj?.data?.mobile ?? ""
            self.addressTf.text = self.getProfileModelObj?.data?.city ?? ""
            
          
            
            
        }
    }
}
