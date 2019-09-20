//
//  Communicator.swift
//  Cloud_Interactive
//
//  Created by Marines Chin on 2019/9/20.
//  Copyright © 2019 chin. All rights reserved.
//

import Foundation

typealias DoneHandler = (_ ersult: Any?, _ error: Error?, _ errorMessage: String?) -> Void

class Communicator {
    
    static let BASEURL = "https://jsonplaceholder.typicode.com"
    
    static let shared = Communicator()
    
    enum APIMethod : String {
        case photos = "/photos"
    }
    
    func getPhotosData(completion: @escaping DoneHandler) {
        
        if let url = URL(string: Communicator.BASEURL + APIMethod.photos.rawValue) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    print("response is nil")
                    return
                }

                self.handleData(resonpse: response, data: data, completion: completion)
                }.resume()

        } else {
            print("Invalid URL.")
        }
    }
    
    private func handleData(resonpse: HTTPURLResponse,data: Data, completion: DoneHandler) {
        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
        if let responseJSON = responseJSON as? [[String: Any]] {
            if resonpse.statusCode == 200{
                print("Get resonpse data")
                completion(responseJSON, nil, nil)
            } else {
                print("resonpse statusCode = \(resonpse.statusCode)")
                guard let resultObject = Json.decodeWith(responseJSON: responseJSON, model: ErrorModel.self) else {
                    print("Decode ErrorModel fail")
                    return
                }
                print(resultObject.message)
                completion(nil, nil, resultObject.message)
            }
        }
    }
    
}
