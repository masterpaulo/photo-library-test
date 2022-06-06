//
//  BaseTableViewController.swift
//  photo-list
//
//  Created by Master Paulo on 6/6/22.
//


import UIKit
class BaseTableViewController: UITableViewController {
    
    weak var loadingAlert: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
    }
    // MARK: - Setup
    
    /// Register cells to be used by the table view
    func registerCells() {
        preconditionFailure("This method must be overridden")
    }
    
    // MARK: - Methods
    
    func showLoadingAlert(_ show: Bool) {
        if show {
            let alert = UIAlertController(title: "Fetching data", message: "Please wait...", preferredStyle: .alert)
            alert.view.tintColor = UIColor.black
            let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10,y: 5,width: 50, height: 50)) as UIActivityIndicatorView
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = .medium
            loadingIndicator.startAnimating()
            
            alert.view.addSubview(loadingIndicator)
            self.present(alert, animated: true)
            loadingAlert = alert
        } else {
            loadingAlert?.dismiss(animated: true)
        }
    }

}
