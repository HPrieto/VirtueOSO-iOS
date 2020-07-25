//
//  SettingsHeaderView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/25/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

//MARK:- SettingsHeaderView
class SettingsHeaderCellView: UIView {
    
    //MARK:- Private Properties
    private var heightLayoutConstraint: NSLayoutConstraint?
    
    //MARK:- Public Properties
    var _height: CGFloat = 50 {
        didSet {
            heightLayoutConstraint?.constant = _height
        }
    }
    
    var _header: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    //MARK:- Views
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.numberOfLines = 1
        view.font = UIFont(type: .demiBold, size: .small)
        view.textColor = ._black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK:- Initialize Subviews
    private func initializeSubviews() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        
        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: _height)
        heightLayoutConstraint?.isActive = true
    }
    
    //MARK:- Init
    init(header: String) {
        super.init(frame: .zero)
        titleLabel.text = header
        initializeSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
