//
//  TripModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 20/09/25.
//

import Foundation
struct TripLsiModel: Codable {
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
