import Foundation
import Alamofire

class GetUserProfileApiRequest: NSObject {
    let path = "/v1/users/"
    var delegate : ApiCallback? = nil
   
    func DispatchWithName(name : String) {
        let url = "https://core.blockstack.org\(path)\(name)"
        
        Alamofire.request(url)
            .validate()
            .responseDecodableObject(keyPath:name, decoder: JSONDecoder())
         