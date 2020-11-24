//
//  SearchBarTableViewHeaderFooterView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/15/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class SearchBarTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    // MARK: - Static Properties
    
    public static var reuseIdentifier: String = "searchbar-table-view-header-footer-view"
    
    // MARK: - Subviews
    
    private(set) lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Search"
        view.barStyle = .default
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        
        addSubview(searchBar)
        
        searchBar.topAnchor.constraint(equalTo: topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        searchBar.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        
        bottomAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
    }
    
    // MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initializeSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
