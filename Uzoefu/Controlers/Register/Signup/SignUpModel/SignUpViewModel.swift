//
//  SignUpViewModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 10/09/25.
//

import Foundation
import UIKit

class SignUpViewModel{
    let shareInstance = SignUpViewModel()
    
    class func registerApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (SignUpModel?) -> Void) {
        DataManager.alamofireNewPostRequest(url: registerUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                let userData = try! JSONDecoder().decode(SignUpModel.self, from: userResponse)
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


