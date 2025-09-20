//
//  TripviewModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 20/09/25.
//

import Foundation
import UIKit

class TripviewModel{
    let shareInstance = TripviewModel()
    
    class func TripListApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (TripListModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: tripListUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                let userData = try! JSONDecoder().decode(TripListModel.self, from: userResponse)
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
    class func AddTripListApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (AddTripModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: addtripListUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                let userData = try! JSONDecoder().decode(AddTripModel.self, from: userResponse)
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
