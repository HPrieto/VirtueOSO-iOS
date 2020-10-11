//
//  ProfileTableViewCell.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/6/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    
    // MARK: - State
    
    enum State {
        case normal
        case previouslySearched
    }
    
    var state: State = .normal {
        didSet {
            switch state {
            case .normal:
                accessoryImageView.image = UIImage(sfSymbol: .chevronRight)
            case .previouslySearched:
                accessoryImageView.image = UIImage(sfSymbol: .xMark)
            }
        }
    }
    
    // MARK: - Private Properties
    
    private let accessoryImageViewHeight: CGFloat = 15
    private var accessoryImageViewWidth: CGFloat {
        return accessoryImageViewHeight
    }
    
    // MARK: - Public Properties
    
    private(set) static var reuseIdentifier: String = "profile-table-view-cell"
    
    // MARK: - Subviews
    
    private(set) lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = ._lightGray
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .medium, size: .regular)
        view.backgroundColor = .clear
        view.numberOfLines = 1
        view.text = "Kanye West"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .medium, size: .small)
        view.backgroundColor = .clear
        view.numberOfLines = 1
        view.text = "Artist"
        view.textColor = ._gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var accessoryImageView: UIImageView = {
        let view = UIImageView()
        let rightArrow: UIImage? = UIImage(sfSymbol: .chevronCompactRight, withWeight: .thin)
        view.image = rightArrow
        view.backgroundColor = .clear
        view.tintColor = ._gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialize Subviews
    
    fileprivate func initializeSubviews() {
        selectionStyle = .none
        addSubview(profileImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(accessoryImageView)
        
        profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        accessoryImageView.heightAnchor.constraint(equalToConstant: accessoryImageViewHeight).isActive = true
        accessoryImageView.widthAnchor.constraint(equalToConstant: accessoryImageViewWidth).isActive = true
        accessoryImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        accessoryImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        
        titleLabel.bottomAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -2).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: accessoryImageView.leftAnchor, constant: -5).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 2).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}