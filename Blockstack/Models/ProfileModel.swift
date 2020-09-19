

import Foundation

class ProfileModel : Decodable {
    let accounts : [AccountModel]
    let description : String
    let name : String
    let images : [ImageModel]
    
    private enum CodingKeys: String, CodingKey {
        case accounts = "account"
        case description
        case name
        case images = "image"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        accounts = try container.decodeWrapper(key: .accounts, defaultValue: [])
        description = try container.decodeWrapper(key: .description, defaultValue: "None")
        name = try container.decodeWrapper(key: .name, defaultValue: "")
        images = try container.decodeWrapper(key: .images, defaultValue: [])
    }
}

