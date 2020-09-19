
import Foundation

class OperationModel : Decodable {
    let block : Int
    let operation : String
    
    private enum CodingKeys: String, CodingKey {
        case block = "block_number"
        case operation = "opcode"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        block = try container.decodeWrapper(key: .block, defaultValue: 0)
        operation = try container.decodeWrapper(key: .operation, defaultValue: "")
    }
}