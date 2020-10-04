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
    private(set) var coordinator: DiscoverCoordinator
    
    // MARK: - Subviews
    
    private(set) lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Search"
        view.delegate = self
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
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
