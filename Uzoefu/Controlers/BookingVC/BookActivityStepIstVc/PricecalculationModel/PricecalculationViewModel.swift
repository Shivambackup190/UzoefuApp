//
//  PricecalculationViewModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 25/09/25.
//


import Foundation
import UIKit
class PricecalculationViewModel{
    let shareInstance = PricecalculationViewModel()
    
    class func pricecalApiMethod(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (PriceCalculationModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: priceCalUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                
                let userData = try! JSONDecoder().decode(PriceCalculationModel.self, from: userResponse)
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
