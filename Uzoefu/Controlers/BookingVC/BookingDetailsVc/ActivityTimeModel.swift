import Foundation

struct ActivityTimeModel: Codable {
    let success: Bool?
    let message: String?
    let data: TimeData?
    enum CodingKeys: CodingKey {
        case success
        case message
        case data
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.data = try container.decodeIfPresent(TimeData.self, forKey: .data)
    }
}

struct TimeData: Codable {
    let mon_from: String?
    let mon_to: String?
    let tue_from: String?
    let tue_to: String?
    let wed_from: String?
    let wed_to: String?
    let thu_from: String?
    let thu_to: String?
    let fri_from: String?
    let fri_to: String?
    let sat_from: String?
    let sat_to: String?
    let sun_from: String?
    let sun_to: String?
    enum CodingKeys: CodingKey {
        case mon_from
        case mon_to
        case tue_from
        case tue_to
        case wed_from
        case wed_to
        case thu_from
        case thu_to
        case fri_from
        case fri_to
        case sat_from
        case sat_to
        case sun_from
        case sun_to
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mon_from = try container.decodeIfPresent(String.self, forKey: .mon_from)
        self.mon_to = try container.decodeIfPresent(String.self, forKey: .mon_to)
        self.tue_from = try container.decodeIfPresent(String.self, forKey: .tue_from)
        self.tue_to = try container.decodeIfPresent(String.self, forKey: .tue_to)
        self.wed_from = try container.decodeIfPresent(String.self, forKey: .wed_from)
        self.wed_to = try container.decodeIfPresent(String.self, forKey: .wed_to)
        self.thu_from = try container.decodeIfPresent(String.self, forKey: .thu_from)
        self.thu_to = try container.decodeIfPresent(String.self, forKey: .thu_to)
        self.fri_from = try container.decodeIfPresent(String.self, forKey: .fri_from)
        self.fri_to = try container.decodeIfPresent(String.self, forKey: .fri_to)
        self.sat_from = try container.decodeIfPresent(String.self, forKey: .sat_from)
        self.sat_to = try container.decodeIfPresent(String.self, forKey: .sat_to)
        self.sun_from = try container.decodeIfPresent(String.self, forKey: .sun_from)
        self.sun_to = try container.decodeIfPresent(String.self, forKey: .sun_to)
    }
}
