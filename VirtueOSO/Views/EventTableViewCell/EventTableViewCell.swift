//
//  EventTableViewCell.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/8/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    // MARK: - Static Members
    
    public static var reuseIdentifier: String = "event-table-view-cell"
    
    // MARK: - Constants
    
    private let likeButtonHeight: CGFloat = 25
    private var likeButtonWidth: CGFloat {
        return likeButtonHeight
    }
    
    private var commentButtonHeight: CGFloat {
        return likeButtonHeight
    }
    private var commentButtonWidth: CGFloat {
        return likeButtonHeight
    }
    
    // MARK: - Subviews
    
    private(set) lazy var view: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        view.addShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var statusLabel: UILabel = {
        let view = UILabel()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        view.backgroundColor = .black
        view.textColor = .white
        view.textAlignment = .center
        view.numberOfLines = 1
        view.font = UIFont(type: .demiBold, size: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var likeButton: UIButton = {
        let button = UIButton(sfSymbolForBackground: .heart, withWeight: .semibold)
        button.tintColor = .white
        button.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) lazy var commentButton: UIButton = {
        let button = UIButton(sfSymbolForBackground: .message, withWeight: .semibold)
        button.tintColor = .white
        button.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) lazy var eventImageView: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 12
        view.backgroundColor = ._gray
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTestImage()
        return view
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .bold, size: 28)
        view.textColor = .white
        view.numberOfLines = 2
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .medium, size: 14)
        view.textColor = ._darkGray
        view.numberOfLines = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var usernameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .bold, size: 14)
        view.textColor = .white
        view.numberOfLines = 2
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private(set) lazy var amountLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .regular, size: 14)
        view.textColor = ._black
        view.numberOfLines = 1
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialize
    
    private func initialize() {
        selectionStyle = .none
        
        addSubview(view)
        
        view.addSubview(eventImageView)
        
        view.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        view.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        
        eventImageView.addSubview(statusLabel)
        eventImageView.addSubview(likeButton)
        eventImageView.addSubview(commentButton)
        eventImageView.addSubview(titleLabel)
        eventImageView.addSubview(usernameLabel)
        
        view.addSubview(descriptionLabel)
        view.addSubview(amountLabel)
        
        eventImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        eventImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        eventImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        eventImageView.heightAnchor.constraint(equalTo: eventImageView.widthAnchor, multiplier: (6/9)).isActive = true
        
        statusLabel.leftAnchor.constraint(equalTo: eventImageView.leftAnchor, constant: 15).isActive = true
        statusLabel.topAnchor.constraint(equalTo: eventImageView.topAnchor, constant: 15).isActive = true
        statusLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        statusLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        likeButton.rightAnchor.constraint(equalTo: eventImageView.rightAnchor, constant: -15).isActive = true
        likeButton.topAnchor.constraint(equalTo: eventImageView.topAnchor, constant: 15).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: likeButtonHeight).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: likeButtonWidth).isActive = true
        
        commentButton.rightAnchor.constraint(equalTo: likeButton.leftAnchor, constant: -10).isActive = true
        commentButton.topAnchor.constraint(equalTo: likeButton.topAnchor).isActive = true
        commentButton.heightAnchor.constraint(equalToConstant: commentButtonHeight).isActive = true
        commentButton.widthAnchor.constraint(equalToConstant: commentButtonWidth).isActive = true
        
        usernameLabel.leftAnchor.constraint(equalTo: eventImageView.leftAnchor, constant: 10).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: eventImageView.rightAnchor, constant: -10).isActive = true
        usernameLabel.bottomAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: -10).isActive = true
        
        titleLabel.bottomAnchor.constraint(equalTo: usernameLabel.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: usernameLabel.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: usernameLabel.rightAnchor).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        amountLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        amountLabel.leftAnchor.constraint(equalTo: descriptionLabel.leftAnchor).isActive = true
        amountLabel.rightAnchor.constraint(equalTo: descriptionLabel.rightAnchor).isActive = true
        
        view.bottomAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 15).isActive = true
        
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 15).isActive = true
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
