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
}

// MARK: - ProfileData
struct ProfileData: Codable {
    let id: Int?
    let name: String?
    let lastname: String?
    let email: String?
    let mobile: String?
    let city: String?
    let distance: String?
    let dateofbirth: String?
    let profile_photo_path: String?
}
//================================================
struct UpdateProfileModel: Codable {
    let success: Bool?
    let message: String?
    let data: updateProfileData?
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
}

struct UpdateProfileImageModel: Codable {
    let success: Bool?
    let message: String?
   
}
