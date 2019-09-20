//
//  Json.swift
//  Cloud_Interactive
//
//  Created by Marines Chin on 2019/9/20.
//  Copyright © 2019 chin. All rights reserved.
//

import Foundation

class Json {
    
    static var decoder: JSONDecoder?
    
    private static var getDecoder: JSONDecoder {
        get {
            if let decoder = decoder {
                return decoder
            } else {
                decoder = JSONDecoder()
                decoder!.dateDecodingStrategy = .iso8601
                return decoder!
            }
        }
    }
    
    static func decodeWith<Model: Decodable>(responseJSON: [[String : Any]], model: Model.Type) -> Model? {
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: responseJSON, options: .prettyPrinted) else {
            print("Fail to generate json data.")
            return nil
        }
        guard let resultObject = try? getDecoder.decode(Model.self, from: jsonData) else {
            print("Fail to decode json data.")
            return nil
        }
        return resultObject
    }
    
    static var encoder: JSONEncoder?
    
    private static var getEncoder: JSONEncoder {
        get {
            if let encoder = encoder {
                return encoder
            } else {
                encoder = JSONEncoder()
                return encoder!
            }
        }
    }
    
}
