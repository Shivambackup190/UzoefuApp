//
//  DataManager.swift
//  Shamsaha
//
//  Created by Narendra Kumar on 04/05/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD
import Foundation

class DataManager: NSObject {
    
    typealias completion = ((Data?, NSDictionary?)->())
    
    class func alamofireWithJSONPostRequest(url:String,viewcontroller : UIViewController!, parameters:[String]?, completionHandler: @escaping completion) {
        print(parameters as Any)
        
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        /*
        let headers: HTTPHeaders = [
               "Content-Type": "application/json",
               "Accept-Language": "en",
               "Authorization": "Bearer yourAccessToken"
           ]*/
        
            AF.request(url, method: .post, parameters: parameters, headers: nil).responseData(completionHandler:{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.data {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        print("JSON: \(jsonObject)")
                        KRProgressHUD.dismiss()
                        completionHandler(response.data, nil)
                    }
                    break
                case .failure( _):
                      KRProgressHUD.dismiss()
                }
            })
         
    }
    
    
    class func alamofireNewPostRequest(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
        print(parameters as Any)
        
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        
        let headers: HTTPHeaders = [
               "Accept": "application/json",
               "Accept-Language": "en",
           ]
        
            AF.request(url, method: .post, parameters: parameters, headers: nil).responseData(completionHandler:{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.data {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        print("JSON: \(jsonObject)")
                        KRProgressHUD.dismiss()
                        completionHandler(response.data, nil)
                    }
                    break
                case .failure( _):
                      KRProgressHUD.dismiss()
                }
            })
         
    }
    
    class func alamofireNewPostwithHadderRequest(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
        print(parameters as Any)
        
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        

        AF.request(url, method: .post, parameters: parameters, headers: DataManager.headerParam()).responseData(completionHandler:{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.data {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        print("JSON: \(jsonObject)")
                        KRProgressHUD.dismiss()
                        completionHandler(response.data, nil)
                    }
                    break
                case .failure( _):
                      KRProgressHUD.dismiss()
                }
            })
         
    }
    
    
    class func alamofireNewDeletewithHadderRequest(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
        print(parameters as Any)
        
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        

        AF.request(url, method: .delete, parameters: parameters, headers: DataManager.headerParam()).responseData(completionHandler:{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.data {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        print("JSON: \(jsonObject)")
                        KRProgressHUD.dismiss()
                        completionHandler(response.data, nil)
                    }
                    break
                case .failure( _):
                      KRProgressHUD.dismiss()
                }
            })
         
    }
    
    class func alamofireNewGetRequest(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
        print(parameters as Any)
        
//        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)

        let headers: HTTPHeaders = [
               "Accept": "application/json",
               "Accept-Language": "en",
           ]

        AF.request(url, method: .get, parameters: parameters, headers: nil).responseData(completionHandler:{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.data {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        print("JSON: \(jsonObject)")
//                        KRProgressHUD.dismiss()
                        completionHandler(response.data, nil)
                    }
                    break
                case .failure( _):
                      KRProgressHUD.dismiss()
                }
            })
    }
    
    //==========APi with token hadder get method ===========
    
    class func alamofirewithhadderNewGetRequest(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
        print(parameters as Any)
        
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        

        AF.request(url, method: .get, parameters: parameters, headers: DataManager.headerParam()).responseData(completionHandler:{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.data {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        print("JSON: \(jsonObject)")
                        KRProgressHUD.dismiss()
                        completionHandler(response.data, nil)
                    }
                    break
                case .failure( _):
                      KRProgressHUD.dismiss()
                }
            })
    }
    
    //==========APi without activity indecator ===========
    
    class func alamofireNewPostRequestwithoutactivityindicator(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
        print(parameters as Any)
        
        //KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        
            AF.request(url, method: .post, parameters: parameters, headers: nil).responseData(completionHandler:{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.data {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        print("JSON: \(jsonObject)")
                       // KRProgressHUD.dismiss()
                        completionHandler(response.data, nil)
                    }
                    break
                case .failure( _): break
                      //KRProgressHUD.dismiss()
                }
            })
    }
    
    //==========APi without activity indecator ===========
    
    class func alamofirewithhadderwithoutactivityNewGetRequest(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
        print(parameters as Any)

        AF.request(url, method: .get, parameters: parameters, headers: DataManager.headerParam()).responseData(completionHandler:{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.data {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        print("JSON: \(jsonObject)")
                       
                        completionHandler(response.data, nil)
                    }
                    break
                case .failure( _): break
                    
                }
            })
    }

    
    //===============Upload file  ====================
    
    //userImg: Image, userFile: file, ImgName: ImgName, fileName: fileName, fileType: "pdf"
    
    class func alamofireUploadFile(urlmethod: String, parameter: [String: Any], userImg: Data!, userFile: Data!, ImgName: String, fileName: String,fileType: String, imgType: String, viewcontroller : UIViewController!, completion:@escaping completion) {
        
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        if CommonMethods.isInternetAvailable() == true {
            AF.upload(multipartFormData: { multipartFormData in
                for (key, value) in parameter {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                let imageData = userFile
                //"image/jpeg"
                if fileType == "image/jpeg" {
                    if let data = userImg {
              
                        multipartFormData.append(data, withName: fileName, fileName: "filename" + ".jpeg", mimeType: fileType)
                    }
                } else {
                    if let data = imageData {
                        multipartFormData.append(data, withName: fileName, fileName: "filename" + ".pdf", mimeType: fileType)
                    }
                }
                
                //===============
                
                let imageDataaa = userImg
                //"image/jpeg"
                if imgType == "image/png" {
                    if let data = imageDataaa {
              
                        multipartFormData.append(data, withName: ImgName, fileName: "filename" + ".png", mimeType: imgType)
                    }
                } else {
                    if let data = imageData {
                        multipartFormData.append(data, withName: fileName, fileName: "filename" + ".pdf", mimeType: fileType)
                    }
                }
                
                //=================
                
            }, to: urlmethod, method: .post, headers: DataManager.headerParam()).responseJSON { responseObject in
                switch(responseObject.result) {
                case .success(_):
                    KRProgressHUD.dismiss()
                    print(responseObject.value!)
                    let statusCode = responseObject.response?.statusCode
                    if statusCode == 200 {
                        let result = responseObject.value! as! [String : Any]
                        completion(responseObject.data, result as NSDictionary)
                    } else {
                        let result = responseObject.value! as! [String : Any]
                        CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                    }
                    break
                case .failure(_):
                    KRProgressHUD.dismiss()
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: responseObject.error?.localizedDescription ?? "Something went wrong", view: viewcontroller)
                    break
                }
            }
        } else {
            KRProgressHUD.dismiss()
            CommonMethods.showAlertMessage(title: Constant.BLANK, message: Constant.MESSAGE_NETWORK, view: viewcontroller)
        }
    }
    
    // -==============================================================================================
    
    class func alamofireUploadImage(urlmethod: String, parameter: [String: Any], userImage: Data!,imageName: String,fileType: String, viewcontroller : UIViewController!, completion:@escaping completion) {
        
                KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        if CommonMethods.isInternetAvailable() == true {
            AF.upload(multipartFormData: { multipartFormData in
                for (key, value) in parameter {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                let imageData = userImage
                //"image/jpeg"
                if fileType == "image/jpeg" {
                    if let data = imageData {
                        multipartFormData.append(data, withName: imageName, fileName: "imageName" + ".jpeg", mimeType: fileType)
                    }
                } else {
                    if let data = imageData {
                        multipartFormData.append(data, withName: imageName, fileName: "imageName" + ".pdf", mimeType: fileType)
                    }
                }
            }, to: urlmethod, method: .post, headers: DataManager.headerParam()).responseJSON { responseObject in
                switch(responseObject.result) {
                case .success(let value):
                    let statusCode = responseObject.response?.statusCode
                    print(statusCode)
                    if statusCode == 200 {
                        KRProgressHUD.dismiss()
                        if let data = value as? [String:Any] {
                            completion(responseObject.data, data as NSDictionary)
                        }
                    }
                    else if statusCode == 401 {
                        KRProgressHUD.dismiss()
                        let result = responseObject.value! as! [String : Any]
                        CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                    }
                    else if statusCode == 422 {
                        KRProgressHUD.dismiss()
                        let result = responseObject.value! as! [String : Any]
                        CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                    }
                    else {
                        KRProgressHUD.dismiss()
                        let result = responseObject.value! as! [String : Any]
                        CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                    }
                    
                case .failure(let error):
                    print(error)
                    KRProgressHUD.dismiss()
                    CommonMethods.showAlertMessage(title: Constant.BLANK, message: (error.localizedDescription), view: viewcontroller)
                }
            }
        } else {
            KRProgressHUD.dismiss()
            CommonMethods.showAlertMessage(title: Constant.BLANK, message: Constant.MESSAGE_NETWORK, view: viewcontroller)
        }
    }
    
    
    // =================================================================================================
    
    //update with upoading single image
    class func alamofireNewUpdatePutRßequest(urlmethod: String, parameter: [String: Any], userImage: Data!,imageName: String,fileType: String, viewcontroller : UIViewController!, completion:@escaping completion) {
            
                    KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
               if CommonMethods.isInternetAvailable() == true {
                AF.upload(multipartFormData: { multipartFormData in
                    for (key, value) in parameter {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                    
                    let imageData = userImage
                    //"image/jpeg"
                    if fileType == "image/jpeg" {
                        if let data = imageData {
                            multipartFormData.append(data, withName: imageName, fileName: "imageName" + ".jpeg", mimeType: fileType)
                        }
                    } else {
                        if let data = imageData {
                            multipartFormData.append(data, withName: imageName, fileName: "imageName" + ".pdf", mimeType: fileType)
                        }
                    }
                }, to: urlmethod, method: .post, headers: headerParam()).responseJSON { responseObject in
                    switch(responseObject.result) {
                    case .success(let value):
                        let statusCode = responseObject.response?.statusCode
                        if statusCode == 200 {
                            KRProgressHUD.dismiss()
                            if let data = value as? [String:Any] {
                                completion(responseObject.data, data as NSDictionary)
                            }
                        }
                        else if statusCode == 401 {
                            KRProgressHUD.dismiss()
                            let result = responseObject.value! as! [String : Any]
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as? String ?? "", view: viewcontroller)
                        }
                        else if statusCode == 422 {
                            KRProgressHUD.dismiss()
                            let result = responseObject.value! as! [String : Any]
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                        }
                        else {
                            KRProgressHUD.dismiss()
                            let result = responseObject.value! as! [String : Any]
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                        }
                        
                    case .failure(let error):
                        print(error)
                        KRProgressHUD.dismiss()
                        CommonMethods.showAlertMessage(title: Constant.BLANK, message: (error.localizedDescription), view: viewcontroller)
                    }
                }
            } else {
                KRProgressHUD.dismiss()
                CommonMethods.showAlertMessage(title: Constant.BLANK, message: Constant.MESSAGE_NETWORK, view: viewcontroller)
            }
        }

    //==============New Method made By pkram==================================
    
    
    class func alamofireUploadMultipleFile(urlmethod: String, parameter: [String: Any], imageData1: Data!, imageData2: Data!, imageData3: Data!, imageData4: Data!, imageData5: Data!, imageData6: Data!, viewcontroller : UIViewController!, completionHandler: @escaping completion) {
        
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        if CommonMethods.isInternetAvailable() == true {
            AF.upload(multipartFormData: { multipartFormData in
                for (key, value) in parameter {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                multipartFormData.append(imageData1, withName: "avatar", fileName: "image1.png", mimeType: "image/jpeg")
                multipartFormData.append(imageData2, withName: "identification_image", fileName: "image2.png", mimeType: "image/jpeg")
                multipartFormData.append(imageData3, withName: "license_image_front", fileName: "image3.png", mimeType: "image/jpeg")
                multipartFormData.append(imageData4, withName: "license_image_back", fileName: "image4.png", mimeType: "image/jpeg")
                multipartFormData.append(imageData5, withName: "health_passport_image", fileName: "image5.png", mimeType: "image/jpeg")
                multipartFormData.append(imageData6, withName: "freelance_license_image", fileName: "image6.png", mimeType: "image/jpeg")

            }, to: urlmethod, method: .post, headers: DataManager.headerParam()).response { response in
                KRProgressHUD.dismiss()
                switch(response.result){
                case .success(_):
                    let statusCode = response.response?.statusCode
                    if statusCode == 200 {
                        if let data = response.data {
                            print("JSON: \(data)")
                            let jsonObject = JSON(data)
                            print("JSON: \(jsonObject)")
                            KRProgressHUD.dismiss()
                            completionHandler(response.data, nil)
                        }
                        
                    }
                    else if statusCode == 400 {
                        let result = response.value as? [String : Any]
                        CommonMethods.showAlertMessage(title: Constant.TITLE, message: result?["message"] as! String, view: viewcontroller)
                    }
                    else if statusCode == 422 {
                        let result = response.value as? [String : Any]
                        CommonMethods.showAlertMessage(title: Constant.TITLE, message: result?["message"] as! String, view: viewcontroller)
                    }
                    else {
                        let result = response.value as? [String : Any]
                        CommonMethods.showAlertMessage(title: Constant.TITLE, message: result?["message"] as! String, view: viewcontroller)
                    }
                    
                case .failure(let error):
                    print(error)
                    CommonMethods.showAlertMessage(title: Constant.BLANK, message: (error.localizedDescription), view: viewcontroller)
                }
            }
        } else {
            KRProgressHUD.dismiss()
            CommonMethods.showAlertMessage(title: Constant.BLANK, message: Constant.MESSAGE_NETWORK, view: viewcontroller)
        }
    }
    //=========ApiforarrayimagesMutipleShivam
    
    class func multiImagespostwithHadderRequest(
        url: String,
        viewcontroller: UIViewController!,
        parameters: [String: AnyObject]?,
        images: [UIImage],
        completionHandler: @escaping completion
    ) {
        print(parameters as Any)
        
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        
        AF.upload(multipartFormData: { multipartFormData in
            // Append parameters
            if let params = parameters {
                for (key, value) in params {
                    if let temp = value as? String {
                        multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                    } else if let temp = value as? Int {
                        multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                    } else if let temp = value as? Double {
                        multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                    }
                }
            }
            
            // Append images
            for (index, image) in images.enumerated() {
                if let imageData = image.jpegData(compressionQuality: 0.7) {
                    multipartFormData.append(
                        imageData,
                        withName: "images[]",  // 👈 matches your API key
                        fileName: "image\(index).jpg",
                        mimeType: "image/jpeg"
                    )
                }
            }
            
        }, to: url, method: .post, headers: DataManager.headerParam())
        .responseData { response in
            KRProgressHUD.dismiss()
            switch response.result {
            case .success:
                print(response)
                if let data = response.data {
                    print("JSON: \(data)")
                    let jsonObject = JSON(data)
                    print("JSON: \(jsonObject)")
                    completionHandler(data, nil)
                }
            case .failure(let error):
                print("❌ Upload failed: \(error.localizedDescription)")
                completionHandler(nil, error as? NSDictionary)
            }
        }
    }

    //================here==========
    
    
    /*
     
     */
    
    class func alamofireNewPutwithHadderRequest(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
        print(parameters as Any)
        
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)

        AF.request(url, method: .put, parameters: parameters, headers: DataManager.headerParam()).responseData(completionHandler:{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.data {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        print("JSON: \(jsonObject)")
                        KRProgressHUD.dismiss()
                        completionHandler(response.data, nil)
                    }
                    break
                case .failure( _):
                      KRProgressHUD.dismiss()
                }
            })
    }
    
    //==============================================================
    
    class func headerParam() -> HTTPHeaders {
        var headerParam = HTTPHeaders()
        headerParam["Authorization"] = "Bearer \(UserDefaults.standard.value(forKey: "token") ?? "")" //"\(UserDefaults.standard.value(forKey: "token") ?? "")"
        headerParam["Accept-Language"] = "en"
        headerParam["Accept"] = "application/json"
       return headerParam
    }
    //ShivamUzeofoPaymentApi//
    class func uploadPayment(
        url: String,
        parameters: [String: Any],
        images: [UIImage],
        completion: @escaping (Data?, Error?) -> Void
    ) {

        let boundary = "Boundary-\(UUID().uuidString)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // ✅ Add headers here
        request.setValue("Bearer \(UserDefaults.standard.string(forKey: "token") ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("en", forHTTPHeaderField: "Accept-Language")

        let httpBody = NSMutableData()

        // Add parameters
        for (key, value) in parameters {
            if let array = value as? [String] {
                for item in array {
                    httpBody.appendString("--\(boundary)\r\n")
                    httpBody.appendString("Content-Disposition: form-data; name=\"\(key)[]\"\r\n\r\n")
                    httpBody.appendString("\(item)\r\n")
                }
            } else {
                httpBody.appendString("--\(boundary)\r\n")
                httpBody.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                httpBody.appendString("\(value)\r\n")
            }
        }

        // Add images
        for (index, image) in images.enumerated() {
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                httpBody.appendString("--\(boundary)\r\n")
                httpBody.appendString("Content-Disposition: form-data; name=\"signature[]\"; filename=\"signature\(index).jpg\"\r\n")
                httpBody.appendString("Content-Type: image/jpeg\r\n\r\n")
                httpBody.append(imageData)
                httpBody.appendString("\r\n")
            }
        }

        httpBody.appendString("--\(boundary)--\r\n")
        request.httpBody = httpBody as Data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(data, error)
        }
        task.resume()
    }

    }

    extension NSMutableData {
        func appendString(_ string: String) {
            if let data = string.data(using: .utf8) {
                self.append(data)
            }
        }
    }


