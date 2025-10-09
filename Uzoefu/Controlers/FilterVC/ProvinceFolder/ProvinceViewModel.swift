//
//  LogOutViewModel.swift
//  Uzoefu

import Foundation
import UIKit
class ProvinceViewModel{
    let shareInstance = ProvinceViewModel()
    
    class func provinceListApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (ProviceModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: proviceUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                
                let userData = try! JSONDecoder().decode(ProviceModel.self, from: userResponse)
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


