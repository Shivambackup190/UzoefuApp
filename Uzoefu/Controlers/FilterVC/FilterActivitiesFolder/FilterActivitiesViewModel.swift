//
//  LogOutViewModel.swift
//  Uzoefu

import Foundation
import UIKit
class FilterActivitiesViewModel{
    let shareInstance = FilterActivitiesViewModel()
    
    class func filterActivitiesListApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (FilterActivitiesModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: filterActivitiesUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                
                let userData = try! JSONDecoder().decode(FilterActivitiesModel.self, from: userResponse)
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


