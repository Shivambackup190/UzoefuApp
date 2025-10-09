//
//  Constant.swift
//  Shamsaha


//uzoefo
import Foundation
import UIKit

//=================ALL APi url ===========================
let BaseUrl = "https://mobappssolutions.in/uzoefu/api/"
let image_Url = "https://mobappssolutions.in/uzoefu/public/icons/"
let imagePathUrl = "https://mobappssolutions.in/uzoefu/public/images/activity_images/"

let registerUrl = BaseUrl + "register"
let loginUrl = BaseUrl + "login"
let catagoriesUrl = BaseUrl + "category"
let activityUrl = BaseUrl + "activity/list"
let logoutUrl = BaseUrl + "logout"
let activitydetailUrl = BaseUrl + "activity/detail"
let ratingUrl = BaseUrl + "activity/rating"
let wishlistUrl = BaseUrl + "wishlist"
let wishlistDataUrl = BaseUrl + "wishlist/data"
let getProfileUrl = BaseUrl + "profile/list"
let updateProfileUrl = BaseUrl + "profile/update"
let updateProfileImageUrl = BaseUrl + "profile/image/update"
let wishlistDeleteDataUrl = BaseUrl + "wishlist/delete"

let sendotpUrl = BaseUrl + "send/otp"
let verificationUrl = BaseUrl + "verify/otp"
let confirmModelUrl = BaseUrl + "reset/password"
let tripListUrl = BaseUrl + "trip/list"
let addtripListUrl = BaseUrl + "add/trip"
let priceCalUrl = BaseUrl + "price/calculation"
let paymentUrl = BaseUrl + "payment"
let bookingListurl = BaseUrl + "booking/list"
let bookingdetailsUrl = BaseUrl + "booking/detail"
let discoverdestinationurl = BaseUrl + "discover/destination"
let overviewCountValauesUrl = BaseUrl + "overview"
let proviceUrl = BaseUrl + "province"
let searchactivityUrl = BaseUrl + "searchactivity"
let filterActivitiesUrl = BaseUrl + "filterActivities"
let activityTimeUrl = BaseUrl + "activity/time"
let NotificationListUrl = BaseUrl + "notificationlist"
let NotificationcountListUrl = BaseUrl + "notificationcount"
let notificationSeenUrl = BaseUrl + "notification/seen"
let NotificationDeleteurl = BaseUrl + "notification/delete"


////,lgh,l,ufgduyhdiufg
//========================================================

let appDel = UIApplication.shared.delegate as! AppDelegate
let scene = UIApplication.shared.connectedScenes.first
let sceneDel = (scene?.delegate as? SceneDelegate)
let SCREEN_SIZE: CGRect = UIScreen.main.bounds
let NAVIGATION_BAR_HEIGHT = CGFloat(50)


//========================================================




//======================================================

struct Constant {
    
    static let Selctlng_TITLE = NSLocalizedString("Select langugae", comment: "")
    static let CANCEL = NSLocalizedString("Cancel", comment: "")
    static let OK  =   NSLocalizedString("OK", comment: "")
    static let YES  =   NSLocalizedString("Yes", comment: "")
    static let NO  =   NSLocalizedString("No", comment: "")
    

    static let videoexit = NSLocalizedString("are you sure, you want to exit that conversation?", comment: "")
    
    static let TITLE = NSLocalizedString("No Data Found!", comment: "")
    static let Avtar_IMG = NSLocalizedString("Please upload profile pic", comment: "")
    static let NATIONLATY = NSLocalizedString("Please select Nationality", comment: "")
    static let DOB = NSLocalizedString("Please enter date of birth", comment: "")
    static let ID_NUMBER = NSLocalizedString("Please enter id number", comment: "")
    
    static let PERSONAL_IMG = NSLocalizedString("Please upload Personal Photo", comment: "")
    static let DRIVING_LIC = NSLocalizedString("Please enter Driving License Number", comment: "")
    
    
    static let LIC_FRONT_IMG = NSLocalizedString("Please upload License Front Photo", comment: "")
    static let LIC_BACK_IMG = NSLocalizedString("Please upload License Back Photo", comment: "")
    
    static let CAR_LIC = NSLocalizedString("Please enter Car License Number", comment: "")
    
    static let Health_IMG = NSLocalizedString("Please upload Health Passport Photo", comment: "")
    static let FREELANCE_IMG = NSLocalizedString("Please upload Freelance License Photo", comment: "")
    
    
    static let BANK_NAME = NSLocalizedString("Please enter Bank Name", comment: "")
    static let ACCOUNT_NUMBER = NSLocalizedString("Please enter Account Number", comment: "")
    static let CAR_PLATE_NUMBER = NSLocalizedString("Please enter Car Plate Number", comment: "")
    static let CAR_PLATE_LATERS = NSLocalizedString("Please enter Car Plate Laters", comment: "")
    static let VIHICLESeqNUMBER = NSLocalizedString("Please enter Vehicle Sequence Number", comment: "")
    
    static let FROM_EXP_DATE = NSLocalizedString("Please enter From Expire Date", comment: "")
    static let INSURANCE_EXP_DATE = NSLocalizedString("Please enter Insurance Expire Date", comment: "")
    static let PERIODIC_EXP_DATE = NSLocalizedString("Please enter Periodic Expire Date", comment: "")
    
    static let CAR_CLASS = NSLocalizedString("Please enter Car Class", comment: "")
    static let CAR_YEARS = NSLocalizedString("Please enter Car Years", comment: "")
    static let CAR_BRAND = NSLocalizedString("Please enter Car Brand", comment: "")
    static let CAR_MODEL = NSLocalizedString("Please enter Car Model", comment: "")
    static let CAR_COLORS = NSLocalizedString("Please enter Car Color", comment: "")
    
    static let PLATE_Type = NSLocalizedString("Please select Plate Type", comment: "")
    static let TERM_CONDITION = NSLocalizedString("Please select Term and Condition", comment: "")
    
    static let ENTER_PHONE_NUMBEROR_ID = NSLocalizedString("Please enter phone number", comment: "")
    static let PHONE_NUMBER_VALIDATION = NSLocalizedString("Please enter 9 digit number", comment: "")
    static let PASSWORD = NSLocalizedString("Please enter password.", comment: "")
    static let CONFIRM_PASSWORD = NSLocalizedString("Please enter confirm password.", comment: "")
    static let PASSWORD_NOT_MATCH = NSLocalizedString("New password doesn't match with confirm password.", comment: "")
    
    static let ENTER_PHONE_NUMBER = NSLocalizedString("Please enter phone number", comment: "")
    
    static let forgetpassword = NSLocalizedString("Password change sucessfully", comment: "")
    static let LOGOUT = NSLocalizedString("Logout sucessfully", comment: "")
    static let MSG_LOGOUT = NSLocalizedString("Are you sure you want to logout.", comment: "")
    static let MSG_CANCEL_ORDER = NSLocalizedString("Are you sure you want to cancel order.", comment: "")
    static let DELETE_ACCOUNT = NSLocalizedString("Are you sure you want to delete account.", comment: "")
    
    static let LANGUAGE_CHANGE = NSLocalizedString("Language changed successfully", comment: "")
    
    static let  GALLERY  =    NSLocalizedString("Gallery", comment: "")
    static let  CAMERA  =     NSLocalizedString("Camera", comment: "")
    static let  CHOOSE_IMAGE  =   NSLocalizedString( "Choose Image", comment: "")

    static let Select_PRICE = NSLocalizedString("Please select price", comment: "")
    
    static let FINISH_TRIP = NSLocalizedString("Are you sure you want to finish your trip.", comment: "")
    
    static let MESSAGE_TEXT = NSLocalizedString("Please enter message", comment: "")
    
    static let CONTACT_MESSAGE = "Your message has been sent"
    
    static let PROVIDER_TYPE = NSLocalizedString("Please select provider type", comment: "")
    static let CAR_TYPE = NSLocalizedString("Please select car type", comment: "")
    
    
    //====================================
    static let PROGRESS_TITLE = NSLocalizedString("Loading...", comment: "")
    static let Restart_TITLE = NSLocalizedString("Restart...", comment: "")
    static let ISSUE = "Something went wrong"
    static let SERVER_ISSUE = "Server not responding"
    static let MESSAGE_NETWORK = "Please check network connection"
    static let BLANK = ""
    static let SPACE = " "
    static let ZERO = 0
    static let SUCCESS = true
   
    static let CURRENCY = "FCFA"
    static let PLACEHOLDER = "placeholder"
    static let ALERT = NSLocalizedString("Alert!!", comment: "")
    static let FULL_NAME = NSLocalizedString("Please enter name", comment: "")
    static let FULL_NAME_CRACTER = NSLocalizedString("Please enter minimum 3 Chracter.", comment: "")
   
    
    static let EMAIL_e = NSLocalizedString("Please enter email.", comment: "")
    static let EMAIL_valid = NSLocalizedString("Please enter valid email.", comment: "")
    
    
    static let PASSWORD_VALIDATION = "Please enter valid Password must have in between 8 to 15 characters"
    static let ACTIVATION_CODE = NSLocalizedString("Please enter valid code", comment: "")
    
    static let WRONG_CODE = NSLocalizedString("Wrong code Please enter right code", comment: "")
    

    
    
    
   //=====================================

}






struct keyChainKeys {
  //  static let volunterID = "volunter_id"
  
}

