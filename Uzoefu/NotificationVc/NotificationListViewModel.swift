//
//  LogOutViewModel.swift
//  Uzoefu

import Foundation
import UIKit
class NotificationListViewModel{
    let shareInstance = NotificationListViewModel()
    
    class func notificationListApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (NotificationListModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: NotificationListUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                
                let userData = try! JSONDecoder().decode(NotificationListModel.self, from: userResponse)
                if userData.success == true {
                    CommonMethods.showAlertMessage(title:"", message: userData.message ?? "", view: viewController)
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title:"", message: userData.message ?? "", view: viewController)
                }
            }
        }
    }
    class func notificationCountListApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (NotificationCountModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: NotificationcountListUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                
                let userData = try! JSONDecoder().decode(NotificationCountModel.self, from: userResponse)
                if userData.success == true {
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title:"", message: userData.message ?? "", view: viewController)
                }
            }
        }
    }
    class func notificationSeenApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (NotificationSeenModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: notificationSeenUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                
                let userData = try! JSONDecoder().decode(NotificationSeenModel.self, from: userResponse)
                if userData.success == true {
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title:"", message: userData.message ?? "", view: viewController)
                }
            }
        }
    }
    class func notificationDeleteApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (NotificationDeleteModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: NotificationDeleteurl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                
                let userData = try! JSONDecoder().decode(NotificationDeleteModel.self, from: userResponse)
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


