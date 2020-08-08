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
                {(response: DataResponse<UserProfileModel>) in
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
