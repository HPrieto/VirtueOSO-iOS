//
//  FollowProfileTableViewCell.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/22/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class FollowProfileTableViewCell: UITableViewCell {
    
    // MARK: - Static Properties
    
    public static let reuseIdentifier: String = "follow-profile-table-view-cell"
    
    // MARK: - Private Properties
    
    private let profileImageViewHeight: CGFloat = 55
    private var profileImageViewWidth: CGFloat {
        return profileImageViewHeight
    }
    private var profileImageViewCornerRadius: CGFloat {
        return profileImageViewHeight / 2
    }
    
    // MARK: - Enums
    
    enum State {
        case follow
        case following
    }
    
    var state: State = .follow {
        didSet {
            switch state {
            case .follow:
                followButton.setTitle("Follow", for: .normal)
            case .following:
                followButton.setTitle("Following", for: .normal)
            }
        }
    }
    
    // MARK: - Subviews
    
    private(set) lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = profileImageViewCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var usernameLabel: UILabel = {
        let view = UILabel()
        view.textColor = ._black
        view.font = UIFont(type: .demiBold, size: 14)
        view.backgroundColor = .clear
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.textColor = ._gray
        view.font = UIFont(type: .regular, size: 14)
        view.backgroundColor = .clear
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var ellispesButton: UIButton = {
        let view = UIButton(sfSymbol: .ellipses, withWeight: .regular)
        view.tintColor = .black
        view.contentHorizontalAlignment = .right
        return view
    }()
    
    private(set) lazy var followButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.placeholderText.cgColor
        view.layer.cornerRadius = 4
        view.titleLabel?.font = UIFont(type: .demiBold, size: 14)
        view.setTitleColor(.black, for: .normal)
        view.contentEdgeInsets = UIEdgeInsets(top: 3, left: 20, bottom: 3, right: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.setTitle("Follow", for: .normal)
        return view
    }()
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        selectionStyle = .none
        
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(nameLabel)
        addSubview(ellispesButton)
        addSubview(followButton)
        
        profileImageView.heightAnchor.constraint(equalToConstant: profileImageViewHeight).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: profileImageViewWidth).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        
        followButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        followButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        ellispesButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        ellispesButton.rightAnchor.constraint(equalTo: followButton.leftAnchor, constant: -20).isActive = true
        
        usernameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: ellispesButton.leftAnchor).isActive = true
        usernameLabel.bottomAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: usernameLabel.leftAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: usernameLabel.rightAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
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
