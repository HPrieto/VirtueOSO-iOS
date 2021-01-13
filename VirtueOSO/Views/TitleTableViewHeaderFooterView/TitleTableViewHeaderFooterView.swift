//
//  BasicTableViewHeader.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/10/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class TitleTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    // MARK: - Private Properties
    
    // MARK: - Public Properties
    
    public static let reuseIdentifier: String = "title-table-view-header-footer-view"
    
    // MARK: - Subviews
    
    private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .demiBold, size: .large)
        view.textColor = ._black
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialize Subviews
    
    fileprivate func initializeSubviews() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        contentView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
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
