import Foundation
import Alamofire

class GetNamePriceApiRequest: NSObject {
    let path = "/v1/prices/names/"
    var delegate : ApiCallback? = nil
    
    func DispatchWithName(name : String) {
        let url = "https://core.blockstack.org\(path)\(name).id"
        
        Alamofire.request(url)
            .responseDecodableObject(decoder: JSONDecoder())
            {(response: DataResponse<PriceModel>) in
                if self.delegate == nil {
                    return
                }
                
                switch response.result {
                case .success(let value):
                    self.delegate!.resultReceived(data:value)
 