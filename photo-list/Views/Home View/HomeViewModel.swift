//
//  HomeViewModel.swift
//  photo-list
//
//  Created by Master Paulo on 6/6/22.
//

import Foundation

protocol HomeViewModelViewDelegate {
    func updateView()
    func showNoTableData(_ show: Bool)
    func showLoadingIndicator(_ show: Bool)
}

class HomeViewModel {
    
    var viewDelegate: HomeViewModelViewDelegate?
    
    var photosList: [Photo] = []
    
    var isLoading: Bool = false {
        didSet {
            self.viewDelegate?.showLoadingIndicator(isLoading)
        }
    }

    // MARK: - init
    init() { }
    
    // MARK: - Setup
    
    func loadData() {
       getPhotos()
    }
    
    // MARK: - Methods
    
    // MARK: - Display Properties
    
}


// MARK: - Network Calls

extension HomeViewModel {
    func getPhotos() {
        DispatchQueue.main.async {
            self.viewDelegate?.showNoTableData(false)
            self.viewDelegate?.showLoadingIndicator(true)
        }
        
        APIManager().getPhotos { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photos):
                self.photosList = photos
                // Signal the view delegate to update view in main thread
                DispatchQueue.main.async {
                    self.viewDelegate?.updateView()
                    if self.photosList.isEmpty {
                        self.viewDelegate?.showNoTableData(true)
                    }
                }
            case .failure(let error):
                print(error)
                if self.photosList.isEmpty {
                    DispatchQueue.main.async {
                        self.viewDelegate?.showNoTableData(true)
                    }
                }
            }
        }
    }
}
