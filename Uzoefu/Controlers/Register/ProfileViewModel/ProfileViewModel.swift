//
//  ProfileViewModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 18/09/25.
//

import Foundation
import UIKit
class ProfileViewModel{
    let shareInstance = ProfileViewModel()
    
    class func getProfileApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (ProfileModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: getProfileUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                
                let userData = try! JSONDecoder().decode(ProfileModel.self, from: userResponse)
                if userData.success == true {
                    completion(userData)
                    
                }
                
                else{
                    CommonMethods.showAlertMessage(title:"", message: userData.message ?? "", view: viewController)
                }
            }
        }
    }
    class func updateProfileApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (UpdateProfileModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: updateProfileUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                
                let userData = try! JSONDecoder().decode(UpdateProfileModel.self, from: userResponse)
                if userData.success == true {
                    completion(userData)
                    
                }
                
                else{
                    CommonMethods.showAlertMessage(title:"", message: userData.message ?? "", view: viewController)
                }
            }
        }
    }
//    class func updateProfileImageApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (UpdateProfileImageModel?) -> Void) {
//        DataManager.alamofireNewPostwithHadderRequest(url: updateProfileImageUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
//            print(response!)
//            if let userResponse = response{
//                
//                let userData = try! JSONDecoder().decode(UpdateProfileImageModel.self, from: userResponse)
//                if userData.success == true {
//                    completion(userData)
//                    
//                }
//                
//                else{
//                    CommonMethods.showAlertMessage(title:"", message: userData.message ?? "", view: viewController)
//                }
//            }
//        }
//    }
//}
    class func updateProfileImageApi(viewController:UIViewController, parameters:NSDictionary, image: Data, imageName: String,completion: @escaping (UpdateProfileImageModel?) -> Void) {
        
        DataManager.alamofireNewUpdatePutRßequest(urlmethod: updateProfileImageUrl, parameter: parameters as! [String: Any], userImage: image, imageName: imageName, fileType: "image/jpeg", viewcontroller: viewController) { (responseObject, responseDict) in
            if let responseData = responseObject {
                
                let userData = try! JSONDecoder().decode(UpdateProfileImageModel.self, from: responseData)
                
                if userData.success == true
                {
                    completion(userData)
                }
            }
        }
    }
}
