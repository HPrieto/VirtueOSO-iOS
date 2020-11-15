//
//  DiscoverViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 9/27/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let tableViewCellHeight: CGFloat = 70
    private var tableViewCellProfileImageViewCornerRadius: CGFloat {
        let profileImageViewHeight: CGFloat = tableViewCellHeight - 20
        return profileImageViewHeight / 2
    }
    
    // MARK: - Public Properties
    
    private(set) var coordinator: DiscoverCoordinator
    
    // MARK: - Subviews
    
    private(set) lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Search"
        view.delegate = self
        return view
    }()
    
    private(set) lazy var tableView: ProfileTableView = {
        let view = ProfileTableView()
        view.profileDelegate = self
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var rightBarButtonItem: UIBarButtonItem = {
        let view = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(handleDismissSearchBar))
        return view
    }()
    
    // MARK: - Handlers
    
    @objc private func handleDismissSearchBar() {
        searchBar.resignFirstResponder()
    }
    
    // MARK: - Initialize Subviews
    
    fileprivate func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        view.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.generateTestData()
        tableView.reloadData()
    }
    
    // MARK: - Init
    
    init(coordinator: DiscoverCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UISearchBarDelegate

extension DiscoverViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Begin:", searchBar.text ?? "")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("End:", searchBar.text ?? "")
    }
}

// MARK: - ProfileTableViewDelegate

extension DiscoverViewController: ProfileTableViewDelegate {
    func profileTableView(_ profileTableView: ProfileTableView, didSelectRowAt indexPath: IndexPath) {
        coordinator.navigate(to: .artist)
    }
    
    func profileTableView(_ profileTableView: ProfileTableView, cell: ProfileTableViewCell, cellForRowAt indexPath: IndexPath) {
        
    }
}
