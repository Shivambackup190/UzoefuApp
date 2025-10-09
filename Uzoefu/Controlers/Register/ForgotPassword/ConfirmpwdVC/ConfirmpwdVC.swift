//
//  ConfirmpwdVC.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 19/09/25.
//

import UIKit

class ConfirmpwdVC: UIViewController {
   
    @IBOutlet weak var newPasswordTf: UITextField!
    
    @IBOutlet weak var confirmPasswordTf: UITextField!
    var loginId:Int?
    var confirmModelObj:confirmModel?
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetBtn(_ sender: UIButton) {
        confirmApi()
    }    
}
extension ConfirmpwdVC {
    func confirmApi() {
        var param = [String:Any]()
        param = ["password":newPasswordTf.text ?? "","password_confirmation":confirmPasswordTf.text ?? "","id":loginId ?? 0]
        ForgetPasswordViewModel.confirmApi(viewController: self, parameters: param as NSDictionary) {response in
            self.confirmModelObj = response
            CommonMethods.showAlertMessageWithHandler(title: "", message: response?.message ?? "", view: self) {
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                self.navigationController?.pushViewController(nav, animated: false)
            }
        }
    }
}
