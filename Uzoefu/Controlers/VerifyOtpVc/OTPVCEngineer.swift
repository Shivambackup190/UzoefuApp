//
//  OTPVC.swift
//  Smartcloud
//
//  Created by Narendra Kumar on 24/09/24.
//

import UIKit

class OTPVCEngineer: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var otpTxt1: UITextField!
    
    @IBOutlet weak var otpTxt6: UITextField!
    @IBOutlet weak var otpTxt5: UITextField!
    @IBOutlet weak var otpTxt4: UITextField!
    @IBOutlet weak var otpTxt3: UITextField!
    @IBOutlet weak var otpTxt2: UITextField!
    @IBOutlet weak var verifyBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view1.layer.borderColor = UIColor.gray.cgColor
        view1.layer.borderWidth = 1
        view2.layer.borderColor = UIColor.gray.cgColor
        view2.layer.borderWidth = 1
        view3.layer.borderColor = UIColor.gray.cgColor
        view3.layer.borderWidth = 1
        view4.layer.borderColor = UIColor.gray.cgColor
        view4.layer.borderWidth = 1
        view5.layer.borderColor = UIColor.gray.cgColor
        view5.layer.borderWidth = 1
        view6.layer.borderColor = UIColor.gray.cgColor
        view6.layer.borderWidth = 1
    }
    


    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            if((textField.text?.count)!<1) && (string.count>0)
            {
                if textField == otpTxt1
                {
                    otpTxt2.becomeFirstResponder()
                }
                if textField == otpTxt2
                {
                    otpTxt3.becomeFirstResponder()
                }
                if textField == otpTxt3
                {
                    otpTxt4.becomeFirstResponder()
                }
                if textField == otpTxt4
                {
                    otpTxt5.becomeFirstResponder()
                }
                if textField == otpTxt5
                {
                    otpTxt6.becomeFirstResponder()
                }
                if textField == otpTxt6
                {
                    otpTxt6.resignFirstResponder()
                }
                textField.text = string
                return false
            }
            else if ((textField.text?.count)!>=1) && (string.count == 0){
                if textField == otpTxt2
                {
                    otpTxt1.becomeFirstResponder()
                }
                if textField == otpTxt3
                {
                    otpTxt2.becomeFirstResponder()
                }
                if textField == otpTxt4
                {
                    otpTxt3.becomeFirstResponder()
                }
                if textField == otpTxt5{
                    otpTxt4.becomeFirstResponder()
                }
                if textField == otpTxt6{
                    otpTxt5.becomeFirstResponder()
                }
                if textField == otpTxt1{
                    otpTxt1.resignFirstResponder()
                }
                textField.text = ""
                return false
            }
            else if (textField.text?.count)!>=1{
                textField.text = string
                return false
            }
            return true
            
        }
    
    @IBAction func verifyBtn(_ sender: Any) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmpwdVC") as! ConfirmpwdVC
        self.navigationController?.pushViewController(nav, animated: true)
        
    }
    
    @IBAction func backBtnc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
