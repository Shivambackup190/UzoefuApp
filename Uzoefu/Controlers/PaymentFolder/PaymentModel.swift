//
//  PaymentModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 29/09/25.
//
import Foundation
struct PaymentModel: Codable {
    let success: Bool?
    let message: String?
  
    enum CodingKeys: CodingKey {
        case success
        case message
       
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
    }
}

