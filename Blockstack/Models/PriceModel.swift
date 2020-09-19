
import Foundation

class PriceModel : Decodable {
    let price : NamePriceModel
    
    private enum CodingKeys: String, CodingKey {
        case price = "name_price"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        price = try container.decodeWrapper(key: .price, defaultValue: NamePriceModel(from: decoder))
    }
}

class NamePriceModel : Decodable {
    let btc : Double
    
    private enum CodingKeys: String, CodingKey {
        case btc
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        btc = try container.decodeWrapper(key: .btc, defaultValue: 0)
    }
}
