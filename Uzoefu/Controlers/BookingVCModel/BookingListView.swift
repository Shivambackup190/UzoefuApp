
import Foundation
import UIKit
class BookingListViewModel{
    let shareInstance = BookingListViewModel()
    
    class func bookingListApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (bookingListModel?) -> Void) {
        DataManager.alamofireNewPostwithHadderRequest(url: bookingListurl, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                
                let userData = try! JSONDecoder().decode(bookingListModel.self, from: userResponse)
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



