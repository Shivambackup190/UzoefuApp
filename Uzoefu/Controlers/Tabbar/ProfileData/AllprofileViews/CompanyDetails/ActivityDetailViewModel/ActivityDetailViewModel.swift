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
    //  <<<<<<< ==========================RatingFunction=============================>>>
    

    class func ratingApi(
        viewController: UIViewController,
        parameters: NSDictionary,
        images: [UIImage],
        completion: @escaping (RatingModel?) -> Void
    ) {
        DataManager.multiImagespostwithHadderRequest(
            url: ratingUrl,
            viewcontroller: viewController,
            parameters: parameters as? [String: AnyObject],
            images: images
        ) { (response, error) in
            
            if let error = error {
                CommonMethods.showAlertMessage(title: "", message: "" , view: viewController)
                completion(nil)
                return
            }
            
            guard let data = response else {
                CommonMethods.showAlertMessage(title: "", message: "Something went wrong.", view: viewController)
                completion(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(RatingModel.self, from: data)
                if result.success == true {
                    completion(result)
                } else {
                    CommonMethods.showAlertMessage(title: "", message: result.message ?? "Error", view: viewController)
                    completion(nil)
                }
            } catch {
                print("Decoding Error: \(error)")
                CommonMethods.showAlertMessage(title: "", message: "Parsing error occurred.", view: viewController)
                completion(nil)
            }
        }
    }

}
    
    



