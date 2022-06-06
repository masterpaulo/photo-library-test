//
//  HomeViewController.swift
//  photo-list
//
//  Created by Master Paulo on 6/6/22.
//

import UIKit

class HomeViewController: BaseTableViewController {

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
    
    override func registerCells() {
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
    }
    
    func setupViews() {
        title = "Test"
        
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    }
    
    
    // MARK: - Actions
    
    @IBAction func reloadButtonAction(_ sender: Any) {
        vm.loadData()
    }

    @objc func refresh(_ sender: AnyObject) {
        vm.getPhotos(isRefresh: true)
    }
}


// MARK: - Table Builder

extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfRowsInSection(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellVM = vm.cellViewModel(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellVM.cellIdentifier) as? BaseTableViewCell
        
        cell?.configure(representable: cellVM)
        
        cell?.layoutIfNeeded()
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.00
    }
}

// MARK: - HomeViewModelViewDelegate

extension HomeViewController: HomeViewModelViewDelegate {
    func updateView() {
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    func showLoadingIndicator(_ show: Bool) {
        self.showLoadingAlert(show)
    }
    
    func showNoTableData(_ show: Bool) {
        tableView.backgroundView = show ? noTableDataView : nil
    }
}
