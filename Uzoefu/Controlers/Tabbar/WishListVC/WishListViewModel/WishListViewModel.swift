//
//  WishListViewModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 17/09/25.
//
import Foundation
import UIKit

class WishListViewModel{
    let shareInstance = WishListViewModel()
    
    class func wishListApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (WishListModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: wishlistUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                let userData = try! JSONDecoder().decode(WishListModel.self, from: userResponse)
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
class func wishListDataApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (WishlistDataModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: wishlistDataUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                let userData = try! JSONDecoder().decode(WishlistDataModel.self, from: userResponse)
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
    class func wishListDataDeleteApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (WishlistDataDeleteModel?) -> Void) {
            DataManager.alamofireNewPostwithHadderRequest(url: wishlistDeleteDataUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
                print(response!)
                if let userResponse = response{
                    let userData = try! JSONDecoder().decode(WishlistDataDeleteModel.self, from: userResponse)
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



