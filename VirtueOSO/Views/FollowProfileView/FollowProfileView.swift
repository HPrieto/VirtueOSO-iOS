//
//  FollowProfileView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/22/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class FollowProfileView: UIView {
    
    // MARK: - Private Properties
    
    private let profileImageViewHeight: CGFloat = 50
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
    
    private(set) lazy var followButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 4
        view.titleLabel?.font = UIFont(type: .demiBold, size: 14)
        view.setTitleColor(.black, for: .normal)
        view.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(profileImageView)
        addSubview(followButton)
        addSubview(usernameLabel)
        addSubview(nameLabel)
        
        profileImageView.heightAnchor.constraint(equalToConstant: profileImageViewHeight).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: profileImageViewWidth).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        profileImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        followButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        followButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        
        usernameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: followButton.leftAnchor, constant: -10).isActive = true
        usernameLabel.bottomAnchor.constraint(equalTo: centerYAnchor).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: usernameLabel.leftAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: usernameLabel.rightAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
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
