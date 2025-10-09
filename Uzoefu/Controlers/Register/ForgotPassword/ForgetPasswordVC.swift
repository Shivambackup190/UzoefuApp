//
//  ForgetPasswordVC.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 19/09/25.
//

import UIKit

class ForgetPasswordVC: UIViewController {

    @IBOutlet weak var emailTf: UITextField!
    var forgetModelobJ:ForgetPasswordModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func backActionBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func sedOtpActionBtn(_ sender: Any) {
        forgetPasswordApi()
    }
}
extension ForgetPasswordVC {
    func forgetPasswordApi() {
        var param = [String:Any]()
        param = ["email":emailTf.text ?? "" ]
        ForgetPasswordViewModel.forgetApi(viewController: self, parameters: param as NSDictionary) {response in
            self.forgetModelobJ = response
            CommonMethods.showAlertMessageWithHandler(title: "", message: response?.message ?? "", view: self) {
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
                nav.loginId = response?.data?.id
                self.navigationController?.pushViewController(nav, animated: true)
            }
        }
    }
}
