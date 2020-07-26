import Foundation
import Alamofire
import CodableAlamofire

class GetNamesApiRequest : NSObject {
    let path = "/v1/namespaces/id/names"
    var delegate : ApiCallback? = nil
    var page = 0
    var hasMoreItems:Bool = true
    
    func Dispatch() {
        if !hasMoreItems {
            return
        }
        
        let parameters:Parameters = ["page":page];
        let url = "https://core.blockstack.org\(path)"; //config
        
        Alamofire.request(url, parameters: parameters)
            .validate()
            .responseDecodableObject(decoder: JSONDecoder())
                { (response: DataResponse<[String]>)
                in
                    
                    if self.delegate == nil {
                        return
                    }
                    switch response.result {
                    case .success(let value):
                        if value.count == 0 {
                            self.hasMoreItems = false
                            return
    