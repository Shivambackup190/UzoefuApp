
import Foundation

struct ActivityListModel: Codable {
    let success: Bool?
    let message: String?
    var data: ActivityData?
    let imagePath: String?
    let nextPageURL: String?
    let prevPageURL: String?
    let currentPage: Int?
    let lastPage: Int?

    enum CodingKeys: String, CodingKey {
        case success
        case message
        case data
        case imagePath = "image_path"
        case nextPageURL = "next_page_url"
        case prevPageURL = "prev_page_url"
        case currentPage = "current_page"
        case lastPage = "last_page"
    }
}

struct ActivityData: Codable {
    let currentPage: Int?
    var activities: [Activity]?
    let firstPageURL: String?
    let from: Int?
    let lastPage: Int?
    let lastPageURL: String?
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
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to
        case total
    }
}

struct Activity: Codable {
    let id: Int?
    let name: String?
    let image: String?
    let activity_price: Int?
    let today_hours: String?
    let rating: String?
    var is_wish:Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case activity_price = "activity_price"
        case today_hours = "today_hours"
        case rating = "rating"
        case is_wish = "is_wish"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.activity_price = try container.decodeIfPresent(Int.self, forKey: .activity_price)
        self.today_hours = try container.decodeIfPresent(String.self, forKey: .today_hours)
        self.rating = try container.decodeIfPresent(String.self, forKey: .rating)
        self.is_wish = try container.decodeIfPresent(Bool.self, forKey: .is_wish)
    }
}
