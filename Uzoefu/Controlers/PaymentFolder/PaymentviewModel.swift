//
//  PaymentviewModel.swift
//  Uzoefu

import Foundation
import UIKit
class PaymentViewModel {
    
    class func paymentApi(
        viewController: UIViewController,
        parameters: [String: Any],
        images: [UIImage],
        completion: @escaping (PaymentModel?) -> Void
    ) {
        
        DataManager.uploadPayment(url: paymentUrl, parameters: parameters, images: images) { data, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    CommonMethods.showAlertMessage(title: "", message: error.localizedDescription, view: viewController)
                    completion(nil)
                    return
                }
                
                guard let data = data else {
                    CommonMethods.showAlertMessage(title: "", message: "Something went wrong.", view: viewController)
                    completion(nil)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(PaymentModel.self, from: data)
                    completion(result)
                } catch {
                    print(" Decoding Error: \(error)")
                    CommonMethods.showAlertMessage(title: "", message: "Parsing error occurred.", view: viewController)
                    completion(nil)
                }
            }
        }
    }
}
