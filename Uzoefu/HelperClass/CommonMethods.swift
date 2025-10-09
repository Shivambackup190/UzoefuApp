

import Foundation
import UIKit
import SystemConfiguration
import CoreData
import SwiftyJSON
//import AAPickerView
import SDWebImage

class CommonMethods: NSObject {

    /**
     @developer: pkram
     @description: Method used for email validation
     @parameters:  (_ email: String)
     @returns:Bool
     */
    class func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    /**
     @developer: pkram
     @description: Method used for go to next controller
     @parameters:  (storyboard:UIStoryboard, identifier:String, navigation:UINavigationController)
     @returns:Nil
     */
    class func goToViewController(storyboard:UIStoryboard, identifier:String, navigation:UINavigationController) {
        let objVC = storyboard.instantiateViewController(withIdentifier: identifier)
        navigation.pushViewController(objVC, animated: true)
    }
    
    /**
     @developer: pkram
     @description: Method used for show alert message
     @parameters:  (title: String, message: String, view: UIViewController)
     @returns:Nil
     */
    class func showAlertMessage(title: String, message: String, view: UIViewController) {
        let objAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: Constant.OK, style: .cancel) { action -> Void in
            //Do some other stuff
        }
        objAlert.addAction(nextAction)
        view.present(objAlert, animated: true, completion: nil)
    }
    
    /**
     @developer: pkram
     @description: Method used for show alert message
     @parameters:  (title: String, message: String, view: UIViewController)
     @returns:Nil
     */
    class func showAlertMessageWithHandler(title: String, message: String, view: UIViewController, completion: @escaping () -> Void) {
        let objAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: Constant.OK, style: .cancel) { action -> Void in
            //Do some other stuff
            completion()
        }
        objAlert.addAction(nextAction)
        view.present(objAlert, animated: true, completion: nil)
    }
    
    /**
     @developer: pkram
     @description: Method used for show alert message
     @parameters:  (title: String, message: String, view: UIViewController)
     @returns:Nil
     */
    class func showAlertMessageWithOkAndCancel(title: String, message: String, view: UIViewController, completion: @escaping () -> Void) {
        let objAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: Constant.OK, style: .default) { action -> Void in
            //Do some other stuff
            completion()
        }
        let cancelActon: UIAlertAction = UIAlertAction(title: Constant.CANCEL, style: .cancel) { action -> Void in
            //Do some other stuff
        }
        
        objAlert.addAction(cancelActon)
        objAlert.addAction(nextAction)
        view.present(objAlert, animated: true, completion: nil)
    }
    
    
    /**
     @developer: pkram
     @description: Method used for show alert message
     @parameters:  (title: String, message: String, view: UIViewController)
     @returns:Nil
     */
    class func showAlertMessageWithLoginAndCancel(title: String, message: String, view: UIViewController, completion: @escaping () -> Void) {
        let objAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelActon: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Do some other stuff
        }
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Login", style: .default) { action -> Void in
            //Do some other stuff
            completion()
        }
        objAlert.addAction(nextAction)
        objAlert.addAction(cancelActon)
        view.present(objAlert, animated: true, completion: nil)
    }
    
    /**
     @developer: pkram
     @description: Method used for show alert message
     @parameters:  (title: String, message: String, view: UIViewController)
     @returns:Bool
     */
    class func isValidPassword(_ password: String) -> Bool {
        // least one uppercase,
        // least one digit
        // least one lowercase
        // least one symbol
        //  min 8 characters total
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-15])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password)
        
    }
    
    /**
     @developer: pkram
     @description: This method will be used for Check Internet Connection.
     @parameter: Nil
     @returns:Bool value
     */
    //  MARK:-
    //  MARK:-  Check Internet Connection
    class func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    /**
    @developer: pkram
    @description: This method will be used for Date Picker
    @parameter: (textField:AAPickerView)
    @returns: Nil
    */
    /*
    class func configDatePicker(dateFormate:String ,textField:AAPickerView) {
        textField.pickerType = .date
        textField.datePicker?.datePickerMode = .date
        textField.datePicker?.maximumDate = Date()
        textField.dateFormatter.dateFormat =  dateFormate//"dd-MM-YYYY"
        textField.valueDidSelected = { date in
            print("selectedDate ", date as! Date )
        }
    }
   */
    /*
     @description: Method used for to create UI for date picker
     @parameters:  datePicker
     @returns:strDate
     */
    class func createUiForDatePicker(datePicker: UIDatePicker) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yyyy"
        let strDate = dateFormatter.string(from: datePicker.date)
        return strDate
    }
    
    /**
    @developer: pkram
    @description: This method will be used for Date Picker
    @parameter: (textField:AAPickerView)
    @returns: Nil
    */
    /*
    class func configStringPicker(prefix:String, stringData:NSMutableArray ,textField:AAPickerView) {
        textField.pickerType = .string(data: stringData as! [String])
        textField.heightForRow = 40
//        textField.pickerRow.font = UIFont(name: "American Typewriter", size: 30)
        textField.toolbar.barTintColor = .darkGray
        textField.toolbar.tintColor = .black
        textField.valueDidSelected = { (index) in
            print("selectedString ", stringData[index as! Int])
            textField.text = String(format: "%@%@",prefix, stringData[index as! Int] as! String)
        }
        textField.valueDidChange = { value in
            print(value)
        }
    }*/
    
    class func convertTextIntoLink(linkText:String, text:String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: linkText, range: NSRange(location: 19, length: 55))
        return attributedString
    }

 
    /*****-------***** Save Status *****-------*****/
    class func saveStatusForKey(status:Bool, forKey:String) {
        UserDefaults.standard.set(status, forKey: forKey)
        UserDefaults.standard.synchronize()
    }

    /*****-------***** Get Status *****-------*****/
    class func getStatusForKey(forKey:String) -> Bool{
        return UserDefaults.standard.bool(forKey:forKey)
    }
    
    /*****-------***** Save Value *****-------*****/
    class func saveValueForKey(value:String, forKey:String) {
        UserDefaults.standard.set(value, forKey: forKey)
        UserDefaults.standard.synchronize()
    }
    
    /*****-------***** Get Value *****-------*****/
    class func getValueForKey(key:String) -> String {
        return UserDefaults.standard.value(forKey: key) as? String ?? "0"
    }
    
    /*
    class func checkUnauthentication() {
        CommonMethods.deleteAllData(entity: "BL_Login")
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        sceneDel?.validateUserLoginOrNot()
    }
    */
    
    /**
     @description: Method used for download image from server
     @parameters:  imageUrl,imageView
     @returns:Nil
     */
    class func downloadProfileImage(url:String,imageView:UIImageView) {
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "Constant.PLACEHOLDER"))
        imageView.clipsToBounds = false
    }
    
    
}

extension UIImageView {

    func loadGif(name: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(name: name)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}

extension UIImage {

    class func gif(name: String) -> UIImage? {
        guard let bundleURL = Bundle.main.url(forResource: name, withExtension: "gif") else {
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            return nil
        }
        return gif(data: imageData)
    }

    class func gif(data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }
        var images = [UIImage]()
        let count = CGImageSourceGetCount(source)
        for i in 0..<count {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: cgImage))
            }
        }
        return UIImage.animatedImage(with: images, duration: Double(count) / 40.0)
    }
}
