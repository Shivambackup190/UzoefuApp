//
//  PricecalculationModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 25/09/25.
//

import Foundation
struct PriceCalculationModel: Codable {
    let success: Bool?
    let message: String?
    let data: PriceData?
    enum CodingKeys: CodingKey {
        case success
        case message
        case data
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.data = try container.decodeIfPresent(PriceData.self, forKey: .data)
    }
}

struct PriceData: Codable {
    let prcing_detail: PricingDetail?
    enum CodingKeys: CodingKey {
        case prcing_detail
    }
}

struct PricingDetail: Codable {
    let date: String?
    let adult: Int?
    let kids: Int?
    let adult_count:String?
    let kids_count:String?
    let subtotal: String?
    let total: String?
    enum CodingKeys: CodingKey {
        case date
        case adult
        case kids
        case adult_count
        case kids_count
        case subtotal
        case total
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decodeIfPresent(String.self, forKey: .date)
        self.adult = try container.decodeIfPresent(Int.self, forKey: .adult)
        self.kids = try container.decodeIfPresent(Int.self, forKey: .kids)
        self.adult_count = try container.decodeIfPresent(String.self, forKey: .adult_count)
        self.kids_count = try container.decodeIfPresent(String.self, forKey: .kids_count)
        self.subtotal = try container.decodeIfPresent(String.self, forKey: .subtotal)
        self.total = try container.decodeIfPresent(String.self, forKey: .total)
    }
    
}
