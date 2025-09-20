struct ExploreCategoriesModel: Codable {
    let message: String?
    let success: Bool?
    let data: [CategoryData]?
    
    enum CodingKeys: CodingKey {
        case message
        case success
        case data
    }
    
    struct CategoryData: Codable {
        let id: Int?
        let name: String?
        let icon: String?
        let activitiesCount: Int?
        
        enum CodingKeys: String, CodingKey {
            case id, name, icon
            case activitiesCount = "activities_count"
        }
    }
}
