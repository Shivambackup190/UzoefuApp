//
//  LoginModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 12/09/25.
//

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
    let expires_at: String?
    enum CodingKeys: CodingKey {
        case token
        case expires_at
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.token = try container.decodeIfPresent(String.self, forKey: .token)
        self.expires_at = try container.decodeIfPresent(String.self, forKey: .expires_at)
    }
}
