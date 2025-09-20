//
//  SignUpViewModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 10/09/25.
//

import Foundation
import UIKit

class LoginViewModel{
    let shareInstance = LoginViewModel()
    
    class func loginApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (LoginModel?) -> Void) {
        DataManager.alamofireNewPostRequest(url: loginUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                let userData = try! JSONDecoder().decode(LoginModel.self, from: userResponse)
                if userData.success == true {
                    completion(userData)
                    CommonMethods.showAlertMessage(title:"", message: userData.message ?? "", view: viewController)
                }
                
                else{
                    CommonMethods.showAlertMessage(title:"", message: userData.message ?? "", view: viewController)
                }
            }
        }
    }
}


