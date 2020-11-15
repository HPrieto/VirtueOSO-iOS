//
//  DirectMessageTableViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/15/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: - DirectMessageTableViewController

class DirectMessageTableViewController: UIViewController {
    
    // MARK: - Subviews
    
    private(set) var rightBarButtonItem: UIBarButtonItem? = {
        let view = UIBarButtonItem(sfSymbol: .squareAndPencil, style: .plain, target: self, action: nil)
        return view
    }()
    
    private(set) var tableView: ProfileTableView = {
        let view = ProfileTableView()
        view.register(SearchBarTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: SearchBarTableViewHeaderFooterView.reuseIdentifier)
        return view
    }()
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.title = "hprieto"
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
        tableView.generateTestData()
        tableView.reloadData()
    }
}

// MARK: - ProfileTableViewDelegate

extension DirectMessageTableViewController: ProfileTableViewDelegate {
    func profileTableView(_ profileTableView: ProfileTableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func profileTableView(_ profileTableView: ProfileTableView, cell: ProfileTableViewCell, cellForRowAt indexPath: IndexPath) {
        // cell.titleLabel.text = "Kanye West"
        // cell.descriptionLabel.text = "Some last sent message..."
    }
}
