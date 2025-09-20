//
//  LogOutViewModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 15/09/25.
//

import Foundation
import UIKit
class ForgetPasswordViewModel{
    let shareInstance = ForgetPasswordViewModel()
    
    class func forgetApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (ForgetPasswordModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: sendotpUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                
                let userData = try! JSONDecoder().decode(ForgetPasswordModel.self, from: userResponse)
                if userData.success == true {
                    completion(userData)
                    
                }
                
                else{
                    CommonMethods.showAlertMessage(title:"", message: userData.message ?? "", view: viewController)
                }
            }
        }
    }
    class func verificationApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (VerificationModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: verificationUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                
                let userData = try! JSONDecoder().decode(VerificationModel.self, from: userResponse)
                if userData.success == true {
                    completion(userData)
                    
                }
                
                else{
                    CommonMethods.showAlertMessage(title:"", message: userData.message ?? "", view: viewController)
                }
            }
        }
    }
    class func confirmApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (confirmModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: confirmModelUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                
                let userData = try! JSONDecoder().decode(confirmModel.self, from: userResponse)
                if userData.success == true {
                    completion(userData)
                    
                }
                
                else{
                    CommonMethods.showAlertMessage(title:"", message: userData.message ?? "", view: viewController)
                }
            }
        }
    }
}


