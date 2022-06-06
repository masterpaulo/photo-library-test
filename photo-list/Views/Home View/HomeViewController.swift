//
//  HomeViewController.swift
//  photo-list
//
//  Created by Master Paulo on 6/6/22.
//

import UIKit

class HomeViewController: UITableViewController {

    var vm: HomeViewModel = HomeViewModel()
    
    // MARK: -  Outlets
    
    @IBOutlet var noTableDataView: UIView!

    // MARK: - View Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        setupViews()

        vm.viewDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateView()
        
        vm.loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        refreshControl?.superview?.sendSubviewToBack(refreshControl!)
    }
    
    // MARK: - Setup
    
    func registerCells() {
        // register custom cells here
    }
    
    func setupViews() {
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    }
    
    
    // MARK: - Actions
    
    @objc func refresh(_ sender: AnyObject) {
        vm.loadData()
    }

}


// MARK: - Table Builder

extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - HomeViewModelViewDelegate

extension HomeViewController: HomeViewModelViewDelegate {
    func updateView() {
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    func showLoadingIndicator(_ show: Bool) {
        
    }
    
    func showNoTableData(_ show: Bool) {
        tableView.backgroundView = show ? noTableDataView : nil
    }
}
