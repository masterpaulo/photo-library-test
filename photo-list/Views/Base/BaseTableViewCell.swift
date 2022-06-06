//
//  BaseTableViewCell.swift
//  photo-list
//
//  Created by Master Paulo on 6/6/22.
//

import UIKit

protocol CellRepresentable {
    var cellIdentifier: String { get }
}

class BaseTableViewCell: UITableViewCell {
    
    var onReuse: () -> Void = {}
    
    override func prepareForReuse() {
        super.prepareForReuse()
        onReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func configure(representable: CellRepresentable) {
        preconditionFailure("This method must be overridden")
    }
}
