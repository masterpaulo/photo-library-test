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
    func showPhotoDetails(with viewModel: DetailsViewModel)
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
    
    func cellViewModels() -> [CellRepresentable] {
        let cellVMs: [CellRepresentable] = photosList.map { photo in
            return PhotoTableCellViewModel(photo: photo)
        }
        
        return cellVMs
    }
    
    // MARK: - Methods
    
    func selectItem(at indexPath: IndexPath) {
        guard let photo = photosList[safe: indexPath.item] else { return }
        let detailsViewModel = DetailsViewModel(photo: photo)
        viewDelegate?.showPhotoDetails(with: detailsViewModel)
    }
    
    // MARK: - Display Properties
    
    var windowTitle: String { "Test" }
    
}

// MARK: - BaseTableViewModelProtocol

extension HomeViewModel: BaseTableViewModelProtocol {
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return cellViewModels().count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CellRepresentable {
        return cellViewModels()[indexPath.item]
    }
}


// MARK: - Network Calls

extension HomeViewModel {
    func getPhotos(isRefresh: Bool = false) {
        DispatchQueue.main.async {
            self.viewDelegate?.showNoTableData(false)
            if !isRefresh {
                self.viewDelegate?.showLoadingIndicator(true)
            }
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
            DispatchQueue.main.async {
                self.viewDelegate?.showLoadingIndicator(false)
            }
        }
    }
}
