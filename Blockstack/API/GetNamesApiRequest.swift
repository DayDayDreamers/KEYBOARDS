import Foundation
import Alamofire
import CodableAlamofire

class GetNamesApiRequest : NSObject {
    let path = "/v1/namespaces/id/names"
    var delegate : ApiCallback? = nil
    var page = 0
    var hasMoreItems:B