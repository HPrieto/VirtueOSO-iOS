//
//  SelectProfileTableViewCell.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/23/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class SelectProfileTableViewCell: UITableViewCell {
    
    // MARK: - Static Properties
    
    public static let reuseIdentifier: String = "select-profile-table-view-cell"
    
    // MARK: - Private Properties
    
    private let profileImageViewHeight: CGFloat = 55
    private var profileImageViewWidth: CGFloat {
        return profileImageViewHeight
    }
    private var profileImageViewCornerRadius: CGFloat {
        return profileImageViewHeight / 2
    }
    
    private let selectButtonHeight: CGFloat = 25
    private var selectButtonWidth: CGFloat {
        return selectButtonHeight
    }
    private var selectButtonCornerRadius: CGFloat {
        return selectButtonHeight / 2
    }
    
    // MARK: - Enums
    
    enum State {
        case selected
        case unselected
    }
    
    // MARK: - Public Properties
    
    public var selectButtonOnClick: (() -> Void)?
    
    var state: State = .selected {
        didSet {
            switch state {
            case .selected:
                selectButton.backgroundColor = ._blue
            case .unselected:
                selectButton.backgroundColor = .white
            }
        }
    }
    
    // MARK: - Subviews
    
    private(set) lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .lightGray
        view.layer.masksToBounds = true
        view.layer.cornerRadius = profileImageViewCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var usernameLabel: UILabel = {
        let view = UILabel()
        view.textColor = ._black
        view.font = UIFont(type: .demiBold, size: 15)
        view.backgroundColor = .clear
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.textColor = ._gray
        view.font = UIFont(type: .medium, size: 16)
        view.backgroundColor = .clear
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var selectButton: UIButton = {
        let view = UIButton(sfSymbol: .checkmark)
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.tintColor = .white
        
        view.layer.cornerRadius = selectButtonCornerRadius
        view.heightAnchor.constraint(equalToConstant: selectButtonHeight).isActive = true
        view.widthAnchor.constraint(equalToConstant: selectButtonWidth).isActive = true
        return view
    }()
    
    // MARK: - Handlers
    
    @objc private func handleSelectButtonTap() {
        state = self.state == .selected ? .unselected : .selected
        selectButtonOnClick?()
    }
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        selectionStyle = .none
        
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(nameLabel)
        addSubview(selectButton)
        
        profileImageView.heightAnchor.constraint(equalToConstant: profileImageViewHeight).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: profileImageViewWidth).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        
        usernameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10).isActive = true
        usernameLabel.bottomAnchor.constraint(equalTo: centerYAnchor).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: selectButton.leftAnchor, constant: -10).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: usernameLabel.leftAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: usernameLabel.rightAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        selectButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        selectButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10).isActive = true
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
