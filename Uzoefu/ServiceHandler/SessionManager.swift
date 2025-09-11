//
//  SessionManager.swift
//  Reminder
//
//  Created by Koshal Saini on 22/01/19.
//  Copyright © 2019 Koshal Saini. All rights reserved.
//

import UIKit

class SessionManager {
    
    static let sharedInstance = SessionManager()
    private init() {}
    //var objLoginData: LoginModel?
    var str_Title: String?
    var str_FCM_Token: String?
    var int_OrderType : Int?
    var str_CategoryType : String?
    var str_ProviderId : Int?
    
}
