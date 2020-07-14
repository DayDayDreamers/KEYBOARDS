import Foundation
import Alamofire

class GetNameHistoryApiRequest: NSObject {
    var delegate : ApiCallback? = nil
    
    func DispatchWithName(name : String) {
        let url = "https://core.blockstack.org/v1/names/\(name)/history"
        
        Alamofire.request(url)
            .validate()
            .responseDecodableObject(decoder: JSONDecoder())
            {(response: DataResponse<Dictionary<String, [OperationModel]>>)
                in
                if self.delegate == nil {
                    return
                }
                
                switch response.result {
                case .success(let value):
                    self.delegate!.resultReceived(data:value)
             