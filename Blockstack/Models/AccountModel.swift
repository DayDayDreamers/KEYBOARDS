import Foundation

class AccountModel : Decodable {
    let service : String
    let proofUrl : String
    let identifier : String
    let contentUrl : String
    
    private enum CodingKeys: String, CodingKey {
        case service
        case proofUrl
        case identifier
        case contentUrl
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        service = 