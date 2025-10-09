//
//  LogOutViewModel.swift
//  Uzoefu

import Foundation
import UIKit
class SearchActivityViewModel{
    let shareInstance = SearchActivityViewModel()
    
    class func SearchActivityListApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (SearchActivityModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: searchactivityUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                
                let userData = try! JSONDecoder().decode(SearchActivityModel.self, from: userResponse)
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


