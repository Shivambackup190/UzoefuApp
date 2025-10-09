//
//  LoginModel.swift
//  Uzoefu

import Foundation
struct LoginModel: Codable {
    let message: String?
    let success:Bool?
    let data: logindetails?
    enum CodingKeys: CodingKey {
        case message
        case success
        case data
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.data = try container.decodeIfPresent(logindetails.self, forKey: .data)
    }
}
struct logindetails: Codable {
    let token: String?
    let user_id:Int?
    let expires_at: String?
    enum CodingKeys: CodingKey {
        case token
        case expires_at
        case user_id
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.token = try container.decodeIfPresent(String.self, forKey: .token)
        self.user_id = try container.decodeIfPresent(Int.self, forKey: .user_id)
        self.expires_at = try container.decodeIfPresent(String.self, forKey: .expires_at)
    }
}
