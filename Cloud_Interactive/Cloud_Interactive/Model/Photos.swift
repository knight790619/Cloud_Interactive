//
//  Photos.swift
//  Cloud_Interactive
//
//  Created by Marines Chin on 2019/9/20.
//  Copyright © 2019 chin. All rights reserved.
//

import Foundation

// MARK: - Photo
struct Photo: Codable {
    let albumID, id: Int?
    let title: String
    let url, thumbnailUrl: String
    
    enum CodingKeys: String, CodingKey {
        case albumID
        case id, title, url
        case thumbnailUrl
    }
}

typealias Photos = [Photo]
