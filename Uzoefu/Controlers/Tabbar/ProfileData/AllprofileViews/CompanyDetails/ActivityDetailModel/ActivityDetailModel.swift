import Foundation
//kk
// MARK: - Top-level
struct ActivityDetailModel: Codable {
    let success: Bool?
    let message: String?
    let data: ActivityDatashow?
    let image_path: String?
    let rating_image: String?
    let next_page_url: String?
    let prev_page_url: String?
    let current_page: Int?
    let last_page: Int?

    enum CodingKeys: String, CodingKey {
        case success, message, data
        case image_path, rating_image, next_page_url, prev_page_url, current_page, last_page
    }
}

// MARK: - Data
struct ActivityDatashow: Codable {
    let activity: Activitydata?
    let description: ActivityDescription?
    let price: ActivityPrice?
    let hours: Hour?
    let amenities: [Amenity]?
    let images:[Imagesdata]
    let payment: Payment?
    let faqs: [FAQ]?
    let terms: ActivityTerms?
    let indemnity: ActivityIndemnity?
    let activity_rating: [ActivityRating]?
}
struct Imagesdata: Codable{
    let image :String?
    let activity_id :Int?
    let user_id:Int?
}
struct FAQ: Codable {
    let id: Int?
    let question: String?
    let answer: String?
}
struct Hour: Codable {
    let id: Int?
    let name: String?
}
struct Amenity: Codable {
    let id: Int?
    let name: String?
}

struct ActivityRating: Codable {
    let id: Int?
    let rating: String?
    let comment: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        // case 1: simple string
        if let stringValue = try? container.decode(String.self) {
            self.id = nil
            self.rating = stringValue
            self.comment = nil
        }
        // case 2: dictionary
        else if let dictValue = try? container.decode([String: String].self) {
            self.id = Int(dictValue["id"] ?? "")
            self.rating = dictValue["rating"]
            self.comment = dictValue["comment"]
        }
        else {
            self.id = nil
            self.rating = nil
            self.comment = nil
        }
    }
}


// MARK: - Activity
struct Activitydata: Codable {
    let id: Int?
    let activity_name: String?
    let branch_id: Int?
    let user_id: Int?
    let contact_name: String?
    let last_name: String?
    let user_email_address: String?
    let google_email: String?
    let contact_number: String?
    let telephone_number: String?
    let category_id: Int?
    let status: Int?
    let deletedAt: String?
    let createdAt: String?
    let updatedAt: String?
    let branch: Branch?
    let category: Category?

    enum CodingKeys: String, CodingKey {
        case id, activity_name, branch_id, user_id, contact_name, last_name,
             user_email_address, google_email, contact_number, telephone_number,
             category_id, status
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case branch, category
    }
}

// MARK: - Branch
struct Branch: Codable {
    let id: Int?
    let user_id: Int?
    let state_id: Int?
    let branch_name: String?
    let contact_name: String?
    let last_name: String?
    let town: String?
    let user_email_address: String?
    let google_email: String?
    let address: String?
    let contact_number: String?
    let teliphone_number: String?
    let status: Int?
    let deletedAt: String?
    let createdAt: String?
    let updatedAt: String?
    // many optional schedule fields
    let mon_from, mon_to, tue_from, tue_to, wed_from, wed_to,
        thu_from, thu_to, fri_from, fri_to, sat_from, sat_to,
        sun_from, sun_to: String?
    let public_mon_from, public_mon_to, public_tue_from, public_tue_to,
        public_wed_from, public_wed_to, public_thu_from, public_thu_to,
        public_fri_from, public_fri_to, public_sat_from, public_sat_to,
        public_sun_from, public_sun_to: String?
}

// MARK: - Category
struct Category: Codable {
    let id: Int?
    let name: String?
    let is_active: Int?
    let createdAt: String?
    let updatedAt: String?
    let icon: String?

    enum CodingKeys: String, CodingKey {
        case id, name, icon
        case is_active = "is_active"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Description
struct ActivityDescription: Codable {
    let id: Int?
    let user_id: Int?
    let activity_id: Int?
    let description: String?
    let highlights: [String]?   
    let deletedAt: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, user_id, activity_id, description, highlights
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(Int.self, forKey: .id)
        user_id = try container.decodeIfPresent(Int.self, forKey: .user_id)
        activity_id = try container.decodeIfPresent(Int.self, forKey: .activity_id)
        description = try container.decodeIfPresent(String.self, forKey: .description)

        // 👇 safe decode highlights (string OR array)
        if let stringValue = try? container.decode(String.self, forKey: .highlights) {
            highlights = [stringValue]
        } else if let arrayValue = try? container.decode([String].self, forKey: .highlights) {
            highlights = arrayValue
        } else {
            highlights = nil
        }

        deletedAt = try container.decodeIfPresent(String.self, forKey: .deletedAt)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
    }
}


// MARK: - Price
struct ActivityPrice: Codable {
    let id: Int?
    let user_id: Int?
    let activity_id: Int?
    let currency: String?
    let unit_measure: String?
    let effective_date: String?
    let adult_base: String?
    let children_base: String?
    let senior_citizens: String?
    let student: String?
    let group_price: String?
    let discount_type: String?
    let input_value: String?
    let effective_date_discount: String?
    let refund_policy: String?
    let cancellation_policy: String?
    let createdAt: String?
    let updatedAt: String?
}

// MARK: - Image
struct ActivityImage: Codable {
    let id: Int?
    let image: String?
    let user_id: Int?
    let activity_id: Int?
    let createdAt: String?
    let updatedAt: String?
}

// MARK: - Terms
struct ActivityTerms: Codable {
    let id: Int?
    let user_id: Int?
    let activity_id: Int?
    let disclaimer: String?
    let terms_and_conditions: String?
    let createdAt: String?
    let updatedAt: String?
}

// MARK: - Indemnity
struct ActivityIndemnity: Codable {
    let id: Int?
    let user_id: Int?
    let activity_id: Int?
    let require_indemnity: Int?
    let signing_detail: String?
    let agreement: String?
    let waiver_and_indemnity: String?
    let declaration: String?
    let acknowledgement: String?
    let createdAt: String?
    let updatedAt: String?
}

// MARK: - Payment
struct Payment: Codable {
    let id: Int?
    let user_id: Int?
    let activity_id: Int?
    let visa_card: Int?
    let eft: Int?
    let bank_id: Int?
    let bank_branch_id: Int?
    let account_holder_name: String?
    let account_type: String?
    let account_number: String?
    let branch_code: String?
    let swift_code: String?
    let createdAt: String?
    let updatedAt: String?
    let bank: Bank?
    let bankbranch: BankBranch?

    enum CodingKeys: String, CodingKey {
        case id, user_id, activity_id, visa_card, eft, bank_id, bank_branch_id,
             account_holder_name, account_type, account_number, branch_code, swift_code,
             createdAt = "created_at", updatedAt = "updated_at", bank, bankbranch
    }
}

// MARK: - Bank
struct Bank: Codable {
    let id: Int?
    let name: String?
    let createdAt: String?
    let updatedAt: String?
    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Bank Branch
struct BankBranch: Codable {
    let id: Int?
    let name: String?
    let bank_id: Int?
    let createdAt: String?
    let updatedAt: String?
    enum CodingKeys: String, CodingKey {
        case id, name, bank_id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
