import Foundation

// MARK: - Main Response
struct OverViewModel: Codable {
    let success: Bool?
    let message: String?
    let data: OverviewData?
    enum CodingKeys: CodingKey {
        case success
        case message
        case data
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.data = try container.decodeIfPresent(OverviewData.self, forKey: .data)
    }
}

// MARK: - Data Container
struct OverviewData: Codable {
    let overview: Overview?
}

// MARK: - Overview Details
struct Overview: Codable {
    let wishlistcount: Int?
    let bookingcount: Int?
    let reviewcount: Int?
    let tripcount: Int?
    let visitedcount: Int?
    let rewardcount: Int?
    let photoscount: Int?
    enum CodingKeys: CodingKey {
        case wishlistcount
        case bookingcount
        case reviewcount
        case tripcount
        case visitedcount
        case rewardcount
        case photoscount
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.wishlistcount = try container.decodeIfPresent(Int.self, forKey: .wishlistcount)
        self.bookingcount = try container.decodeIfPresent(Int.self, forKey: .bookingcount)
        self.reviewcount = try container.decodeIfPresent(Int.self, forKey: .reviewcount)
        self.tripcount = try container.decodeIfPresent(Int.self, forKey: .tripcount)
        self.visitedcount = try container.decodeIfPresent(Int.self, forKey: .visitedcount)
        self.rewardcount = try container.decodeIfPresent(Int.self, forKey: .rewardcount)
        self.photoscount = try container.decodeIfPresent(Int.self, forKey: .photoscount)
    }
}
