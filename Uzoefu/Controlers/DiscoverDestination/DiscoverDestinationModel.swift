import Foundation
struct DiscoverDestinationModel: Codable {
    let success: Bool?
    let message: String?
    var data: [DestinationData]?
    let image_path: String?
    let next_page_url: String?
    let prev_page_url: String?
    let current_page: Int?
    let last_page: Int?

    enum CodingKeys: String, CodingKey {
        case success
        case message
        case data
        case image_path
        case next_page_url
        case prev_page_url
        case current_page
        case last_page
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.data = try container.decodeIfPresent([DestinationData].self, forKey: .data)
        self.image_path = try container.decodeIfPresent(String.self, forKey: .image_path)
        self.next_page_url = try container.decodeIfPresent(String.self, forKey: .next_page_url)
        self.prev_page_url = try container.decodeIfPresent(String.self, forKey: .prev_page_url)
        self.current_page = try container.decodeIfPresent(Int.self, forKey: .current_page)
        self.last_page = try container.decodeIfPresent(Int.self, forKey: .last_page)
    }
}
struct DestinationData: Codable {
    let branch_id: Int?
    let branch_name: String?
    let activity_count: Int?
    let activity_image: String?

    enum CodingKeys: String, CodingKey {
        case branch_id = "branch_id"
        case branch_name = "branch_name"
        case activity_count = "activity_count"
        case activity_image = "activity_image"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.branch_id = try container.decodeIfPresent(Int.self, forKey: .branch_id)
        self.branch_name = try container.decodeIfPresent(String.self, forKey: .branch_name)
        self.activity_count = try container.decodeIfPresent(Int.self, forKey: .activity_count)
        self.activity_image = try container.decodeIfPresent(String.self, forKey: .activity_image)
    }
}
