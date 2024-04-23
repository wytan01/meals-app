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

struct Post: Codable, Equatable {
    let summary: String
    let caption: String
    let photos: [Photo]
}

struct Photo: Codable, Equatable {
     let originalSize: PhotoInfo

    enum CodingKeys: String, CodingKey {

        // Maps API key name to a more "swifty" version (i.e. lowerCamelCasing and no `_`)
        case originalSize = "original_size"
    }
}


struct PhotoInfo: Codable, Equatable {
    let url: URL
}

extension Post {
    static func save(_ posts:[Post], forKey key: String) {
        let defaults = UserDefaults.standard
        let encodedData = try! JSONEncoder().encode(posts)
        defaults.set(encodedData, forKey: key)
    }
    
    static func get(forKey key: String) -> [Post] {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: key) {
            let decodedData = try! JSONDecoder().decode([Post].self, from: data)
            return decodedData
        }
        
        return []
    }
}

extension Post {
    func addToFavorites() {
        var currentData = Post.get(forKey: "Favorites")
        currentData.append(self)
        Post.save(currentData, forKey: "Favorites")
    }
    
    func removeFromFavorites() {
        var currentData = Post.get(forKey: "Favorites")
        currentData.removeAll() {post in
            return post == self
        }
        Post.save(currentData, forKey: "Favorites")
    }
}
