import Foundation
import Alamofire

class GetNameHistoryApiRequest: NSObject {
    var delegate : ApiCallback? = nil
    
    func DispatchWithName(name : String) {
        let url = "https://core.blockstack.org/v1/names/\(name)/history"
        
        Alamofire.request(url)
            .val