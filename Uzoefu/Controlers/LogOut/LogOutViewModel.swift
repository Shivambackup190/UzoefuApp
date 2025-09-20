//
//  LogOutViewModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 15/09/25.
//

import Foundation
import UIKit
class LogoutViewModel{
    let shareInstance = LogoutViewModel()
    
    class func logoutApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (LogOutModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: logoutUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                
                let userData = try! JSONDecoder().decode(LogOutModel.self, from: userResponse)
                if userData.status == true {
                    completion(userData)
                    
                }
                
                else{
                    CommonMethods.showAlertMessage(title:"", message: userData.message ?? "", view: viewController)
                }
            }
        }
    }
}


