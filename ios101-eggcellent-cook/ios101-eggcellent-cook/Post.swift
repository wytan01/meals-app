//
//  Post.swift
//  ios101-eggcellent-cook
//
//  Created by Weiyi Tan on 4/16/24.
//

import Foundation

struct Blog: Decodable {
    let response: Response
}

struct Response: Decodable {
    let posts: [Post]
}

struct Post: Decodable {
    let summary: String
    let caption: String
    let photos: [Photo]
}

struct Photo: Decodable {
     let originalSize: PhotoInfo

    enum CodingKeys: String, CodingKey {

        // Maps API key name to a more "swifty" version (i.e. lowerCamelCasing and no `_`)
        case originalSize = "original_size"
    }
}

struct PhotoInfo: Decodable {
    let url: URL
}

