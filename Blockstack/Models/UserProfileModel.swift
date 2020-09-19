
import Foundation

class UserProfileModel : Decodable {
    let owner : String
    let profile : ProfileModel
    
    private enum CodingKeys: String, CodingKey {
        case owner = "owner_address"
        case profile
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        owner = try container.decodeWrapper(key: .owner, defaultValue:"")
        profile = try container.decodeWrapper(key: .profile, defaultValue: ProfileModel(from: decoder))
    }
}

