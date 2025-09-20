//
//  LogOutModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 15/09/25.
//

import Foundation
struct LogOutModel: Codable {
    let status: Bool?
    let message: String?
  
    enum CodingKeys: CodingKey {
        case status
        case message
       
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(Bool.self, forKey: .status)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
    }
}
