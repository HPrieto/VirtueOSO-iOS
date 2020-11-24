//
//  Switch.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/22/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class SwitchView: UIView {
    
    // MARK: - Subviews
    
    private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .left
        view.textColor = .black
        view.font = UIFont(type: .medium, size: 16)
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var switchView: UISwitch = {
        let view = UISwitch()
        view.onTintColor = ._blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(switchView)
        
        switchView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        switchView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: switchView.centerYAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: switchView.leftAnchor, constant: -10).isActive = true
        
        bottomAnchor.constraint(equalTo: switchView.bottomAnchor).isActive = true
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initializeSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
