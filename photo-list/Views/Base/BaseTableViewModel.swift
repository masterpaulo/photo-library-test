//
//  BaseTableViewModel.swift
//  photo-list
//
//  Created by Master Paulo on 6/6/22.
//

import Foundation

protocol BaseTableViewModelProtocol {
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    
    func cellViewModel(at indexPath: IndexPath) -> CellRepresentable
}
