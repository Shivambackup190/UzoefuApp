//
//  SearchActivityModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 07/10/25.
//
import Foundation
struct SearchActivityModel: Codable {
    let status: Bool?
    let message: String?
    let data: [SearchActivityData]?
    enum CodingKeys: CodingKey {
        case status
        case message
        case data
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(Bool.self, forKey: .status)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.data = try container.decodeIfPresent([SearchActivityData].self, forKey: .data)
    }
}
struct SearchActivityData: Codable {
    let activity_id: Int?
    let name: String?
    let category_name: String?
    enum CodingKeys: CodingKey {
        case activity_id
        case name
        case category_name
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.activity_id = try container.decodeIfPresent(Int.self, forKey: .activity_id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.category_name = try container.decodeIfPresent(String.self, forKey: .category_name)
    }
}
