//
//  DetailsViewModel.swift
//  photo-list
//
//  Created by Master Paulo on 6/6/22.
//

import Foundation

class DetailsViewModel {
    
    let photo: Photo
    
    // MARK: - init
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    // MARK: - Display Properties
    
    var idLabelText: String { "ID: \(photo.id)" }
    var photoUrl: String { photo.url }
    var titleText: String { photo.title }
}
