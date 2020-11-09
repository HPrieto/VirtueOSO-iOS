//
//  EventsTableViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/7/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class EventsTableViewController: UIViewController {
    
    // MARK: - Subviews
    
    private(set) lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Search"
        return view
    }()
    
    private(set) var tableView: EventDetailTableView = {
        let view = EventDetailTableView()
        view.generateTestData()
        view.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        return view
    }()
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        view.backgroundColor = .white
        
        // navigationItem.titleView = searchBar
        
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeSubviews()
    }
    
    
}
