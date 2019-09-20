//
//  ErrorModel.swift
//  Cloud_Interactive
//
//  Created by Marines Chin on 2019/9/20.
//  Copyright © 2019 chin. All rights reserved.
//

import Foundation

struct ErrorModel: Codable {
    
    var timestamp: String
    var status: Double
    var error: String
    var message: String
    var path: String
    
}
