import Foundation

class NameModel : Decodable {
    let status : String
    let error : String
    
    private enum CodingKeys: String, CodingKey {
        case status
        case error
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        status = try container.decodeWrapper(key: .status, defaultValue: "")
        error = try container.decodeWrapper(key: .error, defaultValue: "")
    }
}
