//
//  SettingsNavigationBar.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/25/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class SettingsNavigationBar: UINavigationBar {
    
    var _title: String? {
        didSet {
            titleLabel.text = _title
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .medium, size: .small)
        view.textColor = .black
        view.backgroundColor = .orange
        return view
    }()
    
    private func initialize() {
        backgroundColor = .white
        tintColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        
        topItem?.titleView = titleLabel
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
