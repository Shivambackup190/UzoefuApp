//
//  BookingsDetailModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 30/09/25.
//

import Foundation

struct BookingsDetailModel: Codable {
    let success: Bool?
    let message: String?
    let data: BookingData?
}

struct BookingData: Codable {
    let booking_detail: BookingDetail?
    
    enum CodingKeys: String, CodingKey {
        case booking_detail = "booking_detail"
    }
}

struct BookingDetail: Codable {
    let booking_id: Int?
    let activity_name: String?
    let booking_date: String?
    let description: String?
    let payment_id: String?
    let contact_name: String?
    let contactNumber: String?
    let email: String?
    let billing_address: String?
    let adult_qty: Int?
    let kids_qty: Int?
    let adult_amount: String?
    let kids_amount: String?
    let subtotal: String?
    let total: String?
    
    enum CodingKeys: String, CodingKey {
        case booking_id = "booking_id"
        case activity_name = "activity_name"
        case booking_date = "booking_date"
        case description
        case payment_id = "payment_id"
        case contact_name = "contact_name"
        case contactNumber = "contact_number"
        case email
        case billing_address = "billing_address"
        case adult_qty = "adult_qty"
        case kids_qty = "kids_qty"
        case adult_amount = "adult_amount"
        case kids_amount = "kids_amount"
        case subtotal
        case total
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.booking_id = try container.decodeIfPresent(Int.self, forKey: .booking_id)
        self.activity_name = try container.decodeIfPresent(String.self, forKey: .activity_name)
        self.booking_date = try container.decodeIfPresent(String.self, forKey: .booking_date)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.payment_id = try container.decodeIfPresent(String.self, forKey: .payment_id)
        self.contact_name = try container.decodeIfPresent(String.self, forKey: .contact_name)
        self.contactNumber = try container.decodeIfPresent(String.self, forKey: .contactNumber)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.billing_address = try container.decodeIfPresent(String.self, forKey: .billing_address)
        self.adult_qty = try container.decodeIfPresent(Int.self, forKey: .adult_qty)
        self.kids_qty = try container.decodeIfPresent(Int.self, forKey: .kids_qty)
        self.adult_amount = try container.decodeIfPresent(String.self, forKey: .adult_amount)
        self.kids_amount = try container.decodeIfPresent(String.self, forKey: .kids_amount)
        self.subtotal = try container.decodeIfPresent(String.self, forKey: .subtotal)
        self.total = try container.decodeIfPresent(String.self, forKey: .total)
    }
}

