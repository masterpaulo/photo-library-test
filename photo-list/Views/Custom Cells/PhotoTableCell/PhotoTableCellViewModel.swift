//
//  PhotoTableCellViewModel.swift
//  photo-list
//
//  Created by Master Paulo on 6/6/22.
//

import Foundation

class PhotoTableCellViewModel: CellRepresentable {
    
    var cellIdentifier: String { return "PhotoTableViewCell" }
    
    let data: Photo
    
    // MARK: - init
    
    init(photo: Photo) {
        self.data = photo
    }
    
    // MARK: - Display Properties
    
    var id: String {
        return "ID: \(data.id)"
    }
    
    var title: String {
        return "\(data.title)"
    }
    
    var imageURL: String {
        return data.thumbnailUrl
    }
}
