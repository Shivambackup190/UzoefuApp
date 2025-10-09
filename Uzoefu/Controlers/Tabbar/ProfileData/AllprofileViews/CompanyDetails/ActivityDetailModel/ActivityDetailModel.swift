
//=================newchangedModel============================
import Foundation

// MARK: - Top-level
struct ActivityDetailModel: Codable {
    let success: Bool?
    let message: String?
    var data: ActivityDataShow?
    let image_path: String?
    let rating_image: String?
    let next_page_url: String?
    let prev_page_url: String?
    let current_page: Int?
    let last_page: Int?
    enum CodingKeys: CodingKey {
        case success
        case message
        case data
        case image_path
        case rating_image
        case next_page_url
        case prev_page_url
        case current_page
        case last_page
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.data = try container.decodeIfPresent(ActivityDataShow.self, forKey: .data)
        self.image_path = try container.decodeIfPresent(String.self, forKey: .image_path)
        self.rating_image = try container.decodeIfPresent(String.self, forKey: .rating_image)
        self.next_page_url = try container.decodeIfPresent(String.self, forKey: .next_page_url)
        self.prev_page_url = try container.decodeIfPresent(String.self, forKey: .prev_page_url)
        self.current_page = try container.decodeIfPresent(Int.self, forKey: .current_page)
        self.last_page = try container.decodeIfPresent(Int.self, forKey: .last_page)
    }
}

// MARK: - Data
struct ActivityDataShow: Codable {
    let activity: ActivityData?
    let description: ActivityDescription?
    let price: ActivityPrice?
    let hours: Hours?
    let amenities: [AmenityData]?
    let images: [ActivityImage]?
    let payment: Payment?
    var iswish:Bool?
    var today_hours:String?
    let faqs: [FAQ]?
    let terms: ActivityTerms?
    let indemnity: ActivityIndemnity?
    let activity_rating: [ActivityRating]?
    enum CodingKeys: CodingKey {
        case activity
        case description
        case price
        case hours
        case amenities
        case images
        case payment
        case iswish
        case today_hours
        case faqs
        case terms
        case indemnity
        case activity_rating
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.activity = try container.decodeIfPresent(ActivityData.self, forKey: .activity)
        self.description = try container.decodeIfPresent(ActivityDescription.self, forKey: .description)
        self.price = try container.decodeIfPresent(ActivityPrice.self, forKey: .price)
        self.hours = try container.decodeIfPresent(Hours.self, forKey: .hours)
        self.amenities = try container.decodeIfPresent([AmenityData].self, forKey: .amenities)
        self.images = try container.decodeIfPresent([ActivityImage].self, forKey: .images)
        self.payment = try container.decodeIfPresent(Payment.self, forKey: .payment)
        self.iswish = try container.decodeIfPresent(Bool.self, forKey: .iswish)
        self.today_hours = try container.decodeIfPresent(String.self, forKey: .today_hours)
        self.faqs = try container.decodeIfPresent([FAQ].self, forKey: .faqs)
        self.terms = try container.decodeIfPresent(ActivityTerms.self, forKey: .terms)
        self.indemnity = try container.decodeIfPresent(ActivityIndemnity.self, forKey: .indemnity)
        self.activity_rating = try container.decodeIfPresent([ActivityRating].self, forKey: .activity_rating)
    }
}

// MARK: - Activity
struct ActivityData: Codable {
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
    let deleted_at: String?
    let created_at: String?
    let updated_at: String?
    let branch: Branch?
    let category: Category?
    enum CodingKeys: CodingKey {
        case id
        case activity_name
        case branch_id
        case user_id
        case contact_name
        case last_name
        case user_email_address
        case google_email
        case contact_number
        case telephone_number
        case category_id
        case status
        case deleted_at
        case created_at
        case updated_at
        case branch
        case category
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.activity_name = try container.decodeIfPresent(String.self, forKey: .activity_name)
        self.branch_id = try container.decodeIfPresent(Int.self, forKey: .branch_id)
        self.user_id = try container.decodeIfPresent(Int.self, forKey: .user_id)
        self.contact_name = try container.decodeIfPresent(String.self, forKey: .contact_name)
        self.last_name = try container.decodeIfPresent(String.self, forKey: .last_name)
        self.user_email_address = try container.decodeIfPresent(String.self, forKey: .user_email_address)
        self.google_email = try container.decodeIfPresent(String.self, forKey: .google_email)
        self.contact_number = try container.decodeIfPresent(String.self, forKey: .contact_number)
        self.telephone_number = try container.decodeIfPresent(String.self, forKey: .telephone_number)
        self.category_id = try container.decodeIfPresent(Int.self, forKey: .category_id)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
        self.deleted_at = try container.decodeIfPresent(String.self, forKey: .deleted_at)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.branch = try container.decodeIfPresent(Branch.self, forKey: .branch)
        self.category = try container.decodeIfPresent(Category.self, forKey: .category)
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
    let deleted_at: String?
    let created_at: String?
    let updated_at: String?
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
    let created_at: String?
    let updated_at: String?
    let icon: String?
    enum CodingKeys: CodingKey {
        case id
        case name
        case is_active
        case created_at
        case updated_at
        case icon
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.is_active = try container.decodeIfPresent(Int.self, forKey: .is_active)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.icon = try container.decodeIfPresent(String.self, forKey: .icon)
    }
}

// MARK: - Description
struct ActivityDescription: Codable {
    let id: Int?
    let user_id: Int?
    let activity_id: Int?
    let description: String?
    let highlights: [String]?
    let deleted_at: String?
    let created_at: String?
    let updated_at: String?
    
    enum CodingKeys: String, CodingKey {
        case id, user_id, activity_id, description, highlights
        case deleted_at, created_at, updated_at
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        user_id = try container.decodeIfPresent(Int.self, forKey: .user_id)
        activity_id = try container.decodeIfPresent(Int.self, forKey: .activity_id)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        
        // Decode highlights as array or single string
        if let stringValue = try? container.decode(String.self, forKey: .highlights) {
            highlights = [stringValue]
        } else {
            highlights = try? container.decode([String].self, forKey: .highlights)
        }
        
        deleted_at = try container.decodeIfPresent(String.self, forKey: .deleted_at)
        created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }
}

// MARK: - Price
struct ActivityPrice: Codable {
    let id: Int?
    let user_id: Int?
    let activity_id: Int?
    let currency: String?
    let adult_base: String?
    let children_base: String?
    let senior_citizens: String?
    let student: String?
    let group_price: String?
    let discount_type: String?
    let input_value: String?
    let refund_policy: String?
    let cancellation_policy: String?
    let created_at: String?
    let updated_at: String?
    enum CodingKeys: CodingKey {
        case id
        case user_id
        case activity_id
        case currency
        case adult_base
        case children_base
        case senior_citizens
        case student
        case group_price
        case discount_type
        case input_value
        case refund_policy
        case cancellation_policy
        case created_at
        case updated_at
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.user_id = try container.decodeIfPresent(Int.self, forKey: .user_id)
        self.activity_id = try container.decodeIfPresent(Int.self, forKey: .activity_id)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.adult_base = try container.decodeIfPresent(String.self, forKey: .adult_base)
        self.children_base = try container.decodeIfPresent(String.self, forKey: .children_base)
        self.senior_citizens = try container.decodeIfPresent(String.self, forKey: .senior_citizens)
        self.student = try container.decodeIfPresent(String.self, forKey: .student)
        self.group_price = try container.decodeIfPresent(String.self, forKey: .group_price)
        self.discount_type = try container.decodeIfPresent(String.self, forKey: .discount_type)
        self.input_value = try container.decodeIfPresent(String.self, forKey: .input_value)
        self.refund_policy = try container.decodeIfPresent(String.self, forKey: .refund_policy)
        self.cancellation_policy = try container.decodeIfPresent(String.self, forKey: .cancellation_policy)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }
}

// MARK: - Hours
struct Hours: Codable {
    let mon_from, mon_to, tue_from, tue_to, wed_from, wed_to,
        thu_from, thu_to, fri_from, fri_to, sat_from, sat_to,
        sun_from, sun_to: String?
    let public_mon_from, public_mon_to, public_tue_from, public_tue_to,
        public_wed_from, public_wed_to, public_thu_from, public_thu_to,
        public_fri_from, public_fri_to, public_sat_from, public_sat_to,
        public_sun_from, public_sun_to: String?
}

// MARK: - Amenities
struct AmenityData: Codable {
    let id: Int?
    let activity_id: Int?
    let user_id: Int?
    let amenity_id: Int?
    let created_at: String?
    let updated_at: String?
    let amenity: Amenity?
    enum CodingKeys: CodingKey {
        case id
        case activity_id
        case user_id
        case amenity_id
        case created_at
        case updated_at
        case amenity
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.activity_id = try container.decodeIfPresent(Int.self, forKey: .activity_id)
        self.user_id = try container.decodeIfPresent(Int.self, forKey: .user_id)
        self.amenity_id = try container.decodeIfPresent(Int.self, forKey: .amenity_id)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.amenity = try container.decodeIfPresent(Amenity.self, forKey: .amenity)
    }
}

struct Amenity: Codable {
    let id: Int?
    let name: String?
    let status: Int?
}

// MARK: - Images
struct ActivityImage: Codable {
    let id: Int?
    let image: String?
    let user_id: Int?
    let activity_id: Int?
    let created_at: String?
    let updated_at: String?
}

// MARK: - FAQ
struct FAQ: Codable {
    let id: Int?
    let user_id: Int?
    let activity_id: Int?
    let question: String?
    let answer: String?
    let created_at: String?
    let updated_at: String?
}

// MARK: - Terms
struct ActivityTerms: Codable {
    let id: Int?
    let user_id: Int?
    let activity_id: Int?
    let disclaimer: String?
    let terms_and_conditions: String?
    let created_at: String?
    let updated_at: String?
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
    let indemnity_for: String?
    let created_at: String?
    let updated_at: String?
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
    let created_at: String?
    let updated_at: String?
    let bank: Bank?
    let bankbranch: BankBranch?
}

// MARK: - Bank
struct Bank: Codable {
    let id: Int?
    let name: String?
    let created_at: String?
    let updated_at: String?
}

// MARK: - Bank Branch
struct BankBranch: Codable {
    let id: Int?
    let name: String?
    let bank_id: Int?
    let created_at: String?
    let updated_at: String?
}

// MARK: - Activity Rating
struct ActivityRating: Codable {
    let id: Int?
    let rating: Int?
    let description: String?
    let images: [String]?
    let user: RatingUser?
}

struct RatingUser: Codable {
    let name: String?
    let image: String?
    let user_id:Int?
}
struct RatingModel: Codable {
    let success: Bool?
    let message: String?
    let data: RatingData?
}
struct RatingData: Codable {
    let user_id: Int?
    let activity_id: String?
    let rating: String?
    let description: String?
    let images: [String]?
    let updated_at: String?
    let created_at: String?
    let id: Int?
}
