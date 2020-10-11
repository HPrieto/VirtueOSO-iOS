//
//  BasicTableViewHeader.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/10/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class TitleTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    // MARK: - Public Properties
    
    static let reuseIdentifier: String = "title-table-view-header-footger-view"
    
    public var leftAnchorConstant: CGFloat = 20
    public var rightAnchorConstant: CGFloat = -20
    public var topAnchorConstant: CGFloat = 0
    public var bottomAnchorConstant: CGFloat = 0
    
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
        contentView.backgroundColor = .white
        
        addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: topAnchorConstant).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: leftAnchorConstant).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: rightAnchorConstant).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomAnchorConstant).isActive = true
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
