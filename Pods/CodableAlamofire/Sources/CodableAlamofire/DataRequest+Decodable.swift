//
//  DataRequest+Decodable.swift
//  CodableAlamofire
//
//  Created by Nikita Ermolenko on 10/06/2017.
//  Copyright © 2017 Nikita Ermolenko. All rights reserved.
//

import Foundation
import Alamofire

extension DataRequest {
    
    private static func DecodableObjectSerializer<T: Decodable>(_ keyPath: String?, _ decoder: JSONDecoder) -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            if let error = error {
                return .failure(error)
            }
            if let keyPath = keyPath {
                if keyPath.isEmpty {
                    return .failure(AlamofireDecodableError.emptyKeyPath)
                }
                return DataRequest.decodeToObject(byKeyPath: keyPath, decoder: decoder, response: response, data: data)
            }
            return DataRequest.decodeToObject(decoder: decoder, response: response, data: data)
        }
    }
    
    private static func decodeToObject<T: Decodable>(decoder: JSONDecoder, response: HTTPURLResponse?, data: Data?) -> Result<T> {
        let result = Request.serializeResponseData(response: response, data: data, error: nil)
        
        switch result {
        case .success(let data):
            do {
                let object = try decoder.decode(T.self, from: data)
                return .success(object)
            }
            catch {
                return .failure(error)
            }
        case .failure(let er