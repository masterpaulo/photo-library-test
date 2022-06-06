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
        setupShareNavButton()
    }
    // MARK: - Setup
    
    private func setup() {
        title = vm?.idLabelText ?? "no data found"
        imageView.loadImage(fromURL: vm?.photoUrl ?? "")
        titleLabel.text = vm?.titleText ?? ""
        
    }
    
    private func setupShareNavButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTextButton(_:)))
    }
    
    // MARK: - Actions
    @objc func shareTextButton(_ sender: Any) {
        var items: [Any] = [vm?.titleText ?? ""]
        
        if let link = vm?.photo.thumbnailUrl, let url = URL(string: link) {
            items.append(url)
        }
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
        
    }
    
}
