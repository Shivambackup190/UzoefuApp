//
//  Singlton.swift
//  Shamsaha
//
//  Created by Narendra Kumar on 20/10/23.
//

import Foundation

class Singlton {
    
    static let shared = Singlton()
    var languagecode: String?
    var bariertoken: String?
    var activationcode: String?
    var forgetactivationcode: String?
    
    var langcode: String?
    var chatId: String?
    var showorderId: String?
    
    var lastshoworderId: String?
    
    var providertype: String?
    var cartypeId: String?
  
}
