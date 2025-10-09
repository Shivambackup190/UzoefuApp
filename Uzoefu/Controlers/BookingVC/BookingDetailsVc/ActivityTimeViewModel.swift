
import Foundation
import UIKit
class ActivityTimeViewModel{
    let shareInstance = ActivityTimeViewModel()
    
    class func activityTimeApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (ActivityTimeModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: activityTimeUrl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                
                let userData = try! JSONDecoder().decode(ActivityTimeModel.self, from: userResponse)
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


