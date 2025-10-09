
import Foundation

struct ActivityListModel: Codable {
    let success: Bool?
    let message: String?
    var data: [Activity]?
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

struct Activity: Codable {
    let id: Int?
    let name: String?
    let image: String?
    let activity_price: String?
    let today_hours: String?
    let rating: String?
    let rating_count :Int?
    var is_wish: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, name, image, rating,rating_count
        case activity_price = "activity_price"
        case today_hours = "today_hours"
        case is_wish = "is_wish"
        
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.rating = try container.decodeIfPresent(String.self, forKey: .rating)
        self.activity_price = try container.decodeIfPresent(String.self, forKey: .activity_price)
        self.today_hours = try container.decodeIfPresent(String.self, forKey: .today_hours)
        self.is_wish = try container.decodeIfPresent(Bool.self, forKey: .is_wish)
        self.rating_count = try container.decodeIfPresent(Int.self, forKey: .rating_count)
    }
    
    
}
