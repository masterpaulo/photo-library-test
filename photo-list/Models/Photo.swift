//
//  Photo.swift
//  photo-list
//
//  Created by Master Paulo on 6/6/22.
//

import Foundation

class Photo: Codable {
    let id: Int
    
    let albumId: Int
    let title: String
    let url: String
    let thumbnailUrl: String
  
    
    private enum CodingKeys : String, CodingKey {
        case id, albumId, title, url, thumbnailUrl
    }
    
    init(id: Int,
         albumId: Int,
         title: String,
         url: String,
         thumbnailUrl: String
    ) {
        self.id = id
        self.albumId = albumId
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
}
