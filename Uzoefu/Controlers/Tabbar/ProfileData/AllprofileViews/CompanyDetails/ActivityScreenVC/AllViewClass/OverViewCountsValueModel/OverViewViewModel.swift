//
//  LogOutViewModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 15/09/25.
//

import Foundation
import UIKit
class OverViewViewModel{
    let shareInstance = OverViewViewModel()
    
    class func overViewCountApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (OverViewModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: overviewCountValauesUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                
                let userData = try! JSONDecoder().decode(OverViewModel.self, from: userResponse)
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


