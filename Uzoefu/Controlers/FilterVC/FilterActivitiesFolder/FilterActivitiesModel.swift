//
//  FilterActivitiesModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 07/10/25.
//

import Foundation

struct FilterActivitiesModel: Codable {
    let success: Bool?
    let message: String?
    let data: FilterActivityData?
}

struct FilterActivityData: Codable {
    let currentPage: Int?
    let activities: [FilterActivity]?
    let firstPageURL: String?
    let from: Int?
    let lastPage: Int?
    let lastPageURL: String?
    let links: [ActivityLink]?
    let nextPageURL: String?
    let path: String?
    let perPage: Int?
    let prevPageURL: String?
    let to: Int?
    let total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case activities = "data"
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case links
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to
        case total
    }
}

struct FilterActivity: Codable {
    let id: Int?
    let name: String?
    let image: String?
    let activityPrice: String?
    let todayHours: String?
    let rating: String?
    let ratingCount: Int?
    let isWish: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case activityPrice = "activity_price"
        case todayHours = "today_hours"
        case rating
        case ratingCount = "rating_count"
        case isWish = "is_wish"
    }
}

struct ActivityLink: Codable {
    let url: String?
    let label: String?
    let active: Bool?
}
