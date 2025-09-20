//
//  ActivityDetailViewModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 16/09/25.
//

import Foundation
import UIKit

class ActivityDetailViewModel{
    let shareInstance = ActivityDetailViewModel()
    
    class func activitydetailListApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (ActivityDetailModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: activitydetailUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                let userData = try! JSONDecoder().decode(ActivityDetailModel.self, from: userResponse)
                if userData.success == true {
                    completion(userData)
                   // CommonMethods.showAlertMessage(title:"", message: userData.message ?? "", view: viewController)
                }

                else{
                    CommonMethods.showAlertMessage(title:"", message: userData.message ?? "", view: viewController)
                }
            }
        }
    }
}


