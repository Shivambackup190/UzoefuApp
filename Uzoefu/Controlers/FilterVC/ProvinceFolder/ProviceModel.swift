//
//  ProviceModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 07/10/25.
//
import Foundation

// MARK: - StateListModel
struct ProviceModel: Codable {
    let success: Bool?
    let message: String?
    let data: [StateData]?
    enum CodingKeys: CodingKey {
        case success
        case message
        case data
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.data = try container.decodeIfPresent([StateData].self, forKey: .data)
    }
}

// MARK: - StateData
struct StateData: Codable {
    let id: Int?
    let name: String?
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }
}

