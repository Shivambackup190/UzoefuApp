//
//  TripModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 20/09/25.
//

import Foundation
struct TripListModel: Codable {
    let success: Bool?
    let message: String?
    let data: [TripData]?
    enum CodingKeys: CodingKey {
        case success
        case message
        case data
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.data = try container.decodeIfPresent([TripData].self, forKey: .data)
    }
}

struct TripData: Codable {
    let id: Int?
    let user_id: Int?
    let title: String?
    let destination: String?
    let created_at: String?
    let updated_at: String?
    enum CodingKeys: CodingKey {
        case id
        case user_id
        case title
        case destination
        case created_at
        case updated_at
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.user_id = try container.decodeIfPresent(Int.self, forKey: .user_id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.destination = try container.decodeIfPresent(String.self, forKey: .destination)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }
}
struct AddTripModel: Codable {
    let success: Bool?
    let message: String?
    let data: TripDataContainer?
    enum CodingKeys: CodingKey {
        case success
        case message
        case data
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.data = try container.decodeIfPresent(TripDataContainer.self, forKey: .data)
    }
}

struct TripDataContainer: Codable {
    let trip: TripDetails?
    enum CodingKeys: CodingKey {
        case trip
    }
    init(trip: TripDetails?) {
        self.trip = trip
    }
}

struct TripDetails: Codable {
    let id: Int?
    let title: String?
    let destination: String?
    enum CodingKeys: CodingKey {
        case id
        case title
        case destination
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.destination = try container.decodeIfPresent(String.self, forKey: .destination)
    }
}
