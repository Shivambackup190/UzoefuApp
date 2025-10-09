//
//  NotificationListModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 08/10/25.
//

import Foundation

struct NotificationListModel: Codable {
    let success: Bool?
    let message: String?
    var data: [NotificationData]?
    enum CodingKeys: CodingKey {
        case success
        case message
        case data
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.data = try container.decodeIfPresent([NotificationData].self, forKey: .data)
    }
}

struct NotificationData: Codable {
    let id: Int?
    let title: String?
    let message: String?
    let is_seen: Int?
    let time_ago:String?
    let createdAt: String?
    
   
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case message
        case is_seen = "is_seen"
        case createdAt = "created_at"
        case time_ago
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.is_seen = try container.decodeIfPresent(Int.self, forKey: .is_seen)
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        self.time_ago = try container.decodeIfPresent(String.self, forKey: .time_ago)
    }
}
//NotificatonCount

struct NotificationCountModel: Codable {
    let success: Bool?
    let message: String?
    let data: Int?   // notification count
    enum CodingKeys: CodingKey {
        case success
        case message
        case data
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.data = try container.decodeIfPresent(Int.self, forKey: .data)
    }
}
struct NotificationSeenModel: Codable {
    let success: Bool?
    let message: String?
}
struct NotificationDeleteModel: Codable {
    let success: Bool?
    let message: String?
}
