//
//  SignUpModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 10/09/25.
//

import Foundation

struct SignUpModel: Codable {
    let message: String?
    let success:Bool?
    let data: AccountData?
    enum CodingKeys: CodingKey {
        case message
        case success
        case data
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.data = try container.decodeIfPresent(AccountData.self, forKey: .data)
    }
}
struct AccountData: Codable {
    let name: String?
    let lastname: String?
    let email: String?
    let type: String?
    let updatedAt: String?
    let createdAt: String?
    let id: Int?

    enum CodingKeys: CodingKey {
        case name
        case lastname
        case email
        case type
        case updatedAt
        case createdAt
        case id
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.lastname = try container.decodeIfPresent(String.self, forKey: .lastname)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
    }
}
