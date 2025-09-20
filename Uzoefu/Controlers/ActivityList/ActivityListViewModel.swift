//
//  SignUpViewModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 10/09/25.
//

import Foundation
import UIKit

class ActivityListViewModel{
    let shareInstance = ActivityListViewModel()
    
    class func activityListApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (ActivityListModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: activityUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                let userData = try! JSONDecoder().decode(ActivityListModel.self, from: userResponse)
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


//    class func activityListApi(viewController:UIViewController,
//                                   parameters:NSDictionary,
//                                   completion: @escaping (ActivityListModel?) -> Void) {
//            
//            DataManager.alamofireNewPostwithHadderRequest(
//                url: activityUrl,
//                viewcontroller: viewController,
//                parameters: parameters as? [String:AnyObject]
//            ) { (response, error) in
//                
//                if let jsonData = response as? Data {
//                    do {
//                        let userData = try JSONDecoder().decode(ActivityListModel.self, from: jsonData)
//                        
//                        if userData.success == true {
//                            completion(userData)
//                        } else {
//                            CommonMethods.showAlertMessage(
//                                title: "",
//                                message: userData.message ?? "",
//                                view: viewController
//                            )
//                        }
//                    } catch {
//                        print("Decoding error:", error)
//                    }
//                }
//            }
//        }
//    }
