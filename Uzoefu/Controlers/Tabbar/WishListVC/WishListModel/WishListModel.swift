//
//  WishListModel.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 17/09/25.
//

struct WishListModel: Codable {
    let success: Bool?
    let message: String?
  
    enum CodingKeys: CodingKey {
        case success
        case message
      
    }
   
}
//========wishlisdata=========
struct WishlistDataModel: Codable {
    let success: Bool?
    let message: String?
    var data: [WishlistItem]?
    let imagePath: String?

    enum CodingKeys: String, CodingKey {
        case success, message, data
        case imagePath = "image_path"
    }
}

// MARK: - WishlistItem
struct WishlistItem: Codable {
    let id: Int?
    let activity_id:Int?
    let name: String?
    let image: String?
    let price: String?
    let ratingCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, image, price
        case ratingCount = "rating_count"
        case activity_id 
    }

 
}

struct WishlistDataDeleteModel: Codable {
    let success: Bool?
    let message: String?
    enum CodingKeys: String, CodingKey {
        case success, message
        
    }
}
