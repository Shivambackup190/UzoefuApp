//
//  bookingListModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 29/09/25.
//
import Foundation

// MARK: - ActiveBookingModel
struct bookingListModel: Codable {
    let success: Bool?
    let message: String?
    let data: [ActiveBookingData]?
    let image_path: String?

    enum CodingKeys: String, CodingKey {
        case success
        case message
        case data
        case image_path = "image_path"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.data = try container.decodeIfPresent([ActiveBookingData].self, forKey: .data)
        self.image_path = try container.decodeIfPresent(String.self, forKey: .image_path)
    }
}

// MARK: - ActiveBookingData
struct ActiveBookingData: Codable {
    let id: Int?
    let activity_id:Int?
    let activity_name: String?
    let images: String?
    let total: String?
    let date: String?
    let activity_status: String?

    enum CodingKeys: String, CodingKey {
        case id
        case activity_name = "activity_name"
        case images
        case total
        case date
        case activity_status = "activity_status"
        case activity_id
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.activity_name = try container.decodeIfPresent(String.self, forKey: .activity_name)
        self.images = try container.decodeIfPresent(String.self, forKey: .images)
        self.total = try container.decodeIfPresent(String.self, forKey: .total)
        self.date = try container.decodeIfPresent(String.self, forKey: .date)
        self.activity_status = try container.decodeIfPresent(String.self, forKey: .activity_status)
        self.activity_id = try container.decodeIfPresent(Int.self, forKey: .activity_id)
    }
}

