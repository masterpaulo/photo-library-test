//
//  APIManager+Methods.swift
//  photo-list
//
//  Created by Master Paulo on 6/6/22.
//

import Foundation

// MARK: - Methods

extension APIManager {
    /// Get list of photos
    /// - Parameters:
    ///   - completion: Callback that provides a Result of Photo array
    func getPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        request(route: APIRouter.getPhotos, completion: completion)
    }
}


