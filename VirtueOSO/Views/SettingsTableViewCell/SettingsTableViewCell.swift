//
//  SettingsTableViewCell.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/25/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

//MARK:- SettingsTableViewCellState
public enum SettingsTableViewCellState {
    case normal
    case toggle
    case blank
    case alert
    case dropdown
    case input
    case simple
}

//MARK:- SettingsTableViewCell
class SettingsTableViewCell: UITableViewCell {
    
    //MARK:- Public Properties
    var state: SettingsTableViewCellState {
        didSet {
            print(state)
        }
    }
    
    //MARK:- Views
    lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK:- Init
    private func initializeNormal() {
        
    }
    
    init(state: SettingsTableViewCellState = .normal, style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.state = state
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeNormal()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
