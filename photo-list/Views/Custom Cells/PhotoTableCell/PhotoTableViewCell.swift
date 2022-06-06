//
//  PhotoTableViewCell.swift
//  photo-list
//
//  Created by Master Paulo on 6/6/22.
//


import UIKit

class PhotoTableViewCell: BaseTableViewCell {
    
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var thumbnailImageView: UIImageView!
    
    override func configure(representable: CellRepresentable) {
        guard let viewModel = representable as? PhotoTableCellViewModel else { return }
        
        idLabel.text = viewModel.id
        titleLabel.text = viewModel.title
        
        thumbnailImageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        thumbnailImageView.loadImage(fromURL: viewModel.imageURL)
    }
}
