//
//  ForgetPasswordModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 20/09/25.
//

import Foundation

struct ForgetPasswordModel: Codable {
    let success: Bool?
    let message: String?
    let data: value?
    
}
struct value :Codable {
    let id:Int?
}
struct VerificationModel: Codable {
    let success: Bool?
    let message: String?
}
struct confirmModel: Codable {
    let success: Bool?
    let message: String?
}
