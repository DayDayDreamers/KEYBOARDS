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
   