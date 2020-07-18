import Foundation
import Alamofire

class GetNamePriceApiRequest: NSObject {
    let path = "/v1/prices/names/"
    var delegate : ApiCallback? = nil
    
    func DispatchWithName(name : String) {
        let url = "https://core.blockstack.org\(path)\(name).id"
        
        Alam