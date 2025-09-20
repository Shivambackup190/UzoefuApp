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
}

struct TripData: Codable {
    let id: Int?
    let user_id: Int?
    let title: String?
    let destination: String?
    let created_at: String?
    let updated_at: String?
}
struct AddTripModel: Codable {
    let success: Bool?
    let message: String?
    let data: TripDataContainer?
}

struct TripDataContainer: Codable {
    let trip: TripDetails?
}

struct TripDetails: Codable {
    let id: Int?
    let title: String?
    let destination: String?
}
