//
//  TimestampTableViewHeaderFooterView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/21/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class TimestampTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    // MARK: - Static Properties
    
    public static let reuseIdentifier: String = "timestamp-table-view-header-footer-view"
    
    // MARK: - Public Properties
    
    var date: Date? {
        didSet {
            guard let date = date else { return }
            label.text = date.toString(withDateFormat: "EEEE HH:mm a")
        }
    }
    
    // MARK: - Subviews
    
    private(set) lazy var label: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .medium, size: 12)
        view.textColor = ._gray
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        addSubview(label)
        
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        
        bottomAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
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
