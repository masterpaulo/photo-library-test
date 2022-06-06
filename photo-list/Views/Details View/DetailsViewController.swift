//
//  DetailsViewController.swift
//  photo-list
//
//  Created by Master Paulo on 6/6/22.
//

import UIKit

class DetailsViewController: UIViewController {

    var vm: DetailsViewModel?
    
    // MARK: -  Outlets
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    

    // MARK: - View Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    // MARK: - Setup
    
    private func setup() {
        title = vm?.idLabelText ?? "no data found"
        imageView.loadImage(fromURL: vm?.photoUrl ?? "")
        titleLabel.text = vm?.titleText ?? ""
    }
    
}
