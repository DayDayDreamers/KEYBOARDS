
import Foundation
import Alamofire

class GetNameStatusApiRequest: NSObject {
    let path = "/v1/names/"
    var delegate : ApiCallback? = nil
    
    func DispatchWithName(name : String) {
        let url = "https://core.blockstack.org\(path)\(name).id"
        
        Alamofire.request(url)
            .responseDecodableObject(decoder: JSONDecoder())
            {(response: DataResponse<NameModel>) in
                if self.delegate == nil {
                    return
                }
            
                switch response.result {
                case .success(let value):
                    self.delegate!.resultReceived(data:value)
                case .failure(let error):
                    self.delegate!.failWithError(error: error)
                }
        }
    }
}