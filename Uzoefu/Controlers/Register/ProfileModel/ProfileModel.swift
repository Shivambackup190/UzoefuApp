//
//  ProfileModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 18/09/25.
//

import Foundation

// MARK: - ProfileResponse
struct ProfileModel: Codable {
    let success: Bool?
    let message: String?
    let data: ProfileData?
    enum CodingKeys: CodingKey {
        case success
        case message
        case data
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.data = try container.decodeIfPresent(ProfileData.self, forKey: .data)
    }
}

// MARK: - ProfileData
struct ProfileData: Codable {
    let id: Int?
    let name: String?
    let username:String?
    let lastname: String?
    let email: String?
    let mobile: String?
    let city: String?
    let distance: String?
    let dateofbirth: String?
    let profile_photo_path: String?
    var category :[categoryids]?
    enum CodingKeys: CodingKey {
        case id
        case name
        case username
        case lastname
        case email
        case mobile
        case city
        case distance
        case dateofbirth
        case profile_photo_path
        case category
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.username = try container.decodeIfPresent(String.self, forKey: .username)
        self.lastname = try container.decodeIfPresent(String.self, forKey: .lastname)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.mobile = try container.decodeIfPresent(String.self, forKey: .mobile)
        self.city = try container.decodeIfPresent(String.self, forKey: .city)
        self.distance = try container.decodeIfPresent(String.self, forKey: .distance)
        self.dateofbirth = try container.decodeIfPresent(String.self, forKey: .dateofbirth)
        self.profile_photo_path = try container.decodeIfPresent(String.self, forKey: .profile_photo_path)
        self.category = try container.decodeIfPresent([categoryids].self, forKey: .category)
    }
}
struct categoryids :Codable {
    let category_id:Int?
}
//================================================
struct UpdateProfileModel: Codable {
    let success: Bool?
    let message: String?
    let data: updateProfileData?
    enum CodingKeys: CodingKey {
        case success
        case message
        case data
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.data = try container.decodeIfPresent(updateProfileData.self, forKey: .data)
    }
}

// MARK: - ProfileData
struct updateProfileData: Codable {
    let id: Int?
    let name: String?
    let lastname: String?
    let email: String?
    let mobile: String?
    let city: String?
    let distance: String?
    let dateofbirth: String?
    let profile_photo_path: String?
    enum CodingKeys: CodingKey {
        case id
        case name
        case lastname
        case email
        case mobile
        case city
        case distance
        case dateofbirth
        case profile_photo_path
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.lastname = try container.decodeIfPresent(String.self, forKey: .lastname)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.mobile = try container.decodeIfPresent(String.self, forKey: .mobile)
        self.city = try container.decodeIfPresent(String.self, forKey: .city)
        self.distance = try container.decodeIfPresent(String.self, forKey: .distance)
        self.dateofbirth = try container.decodeIfPresent(String.self, forKey: .dateofbirth)
        self.profile_photo_path = try container.decodeIfPresent(String.self, forKey: .profile_photo_path)
    }
}

struct UpdateProfileImageModel: Codable {
    let success: Bool?
    let message: String?
    enum CodingKeys: CodingKey {
        case success
        case message
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
    }
}
