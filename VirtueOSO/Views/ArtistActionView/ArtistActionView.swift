//
//  ArtistActionView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/26/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class ArtistActionView: UIView {
    
    enum State {
        case follow
        case following
    }
    
    var state: State = .follow {
        didSet {
            switch state {
            case .follow:
                followButton.setTitle("Follow", for: .normal)
                followButton.setTitleColor(.white, for: .normal)
                followButton.backgroundColor = ._blue
                followButton.layer.borderColor = UIColor._blue.cgColor
            case .following:
                followButton.setTitle("Following", for: .normal)
                followButton.setTitleColor(.black, for: .normal)
                followButton.backgroundColor = .clear
                followButton.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
    }
    
    // MARK: - Subviews
    
    private(set) lazy var followButton: UIButton = {
        let view = UIButton()
        view.setTitle("Follow", for: .normal)
        view.backgroundColor = ._blue
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor._blue.cgColor
        view.layer.cornerRadius = 4
        view.titleLabel?.font = UIFont(type: .demiBold, size: 14)
        view.setTitleColor(.white, for: .normal)
        view.contentEdgeInsets = UIEdgeInsets(top: 7, left: 15, bottom: 7, right: 15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var messageButton: UIButton = {
        let view = UIButton()
        view.setTitle("Message", for: .normal)
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 4
        view.titleLabel?.font = UIFont(type: .demiBold, size: 14)
        view.setTitleColor(.black, for: .normal)
        view.contentEdgeInsets = UIEdgeInsets(top: 7, left: 15, bottom: 7, right: 15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var emailButton: UIButton = {
        let view = UIButton()
        view.setTitle("Email", for: .normal)
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 4
        view.titleLabel?.font = UIFont(type: .demiBold, size: 14)
        view.setTitleColor(.black, for: .normal)
        view.contentEdgeInsets = UIEdgeInsets(top: 7, left: 15, bottom: 7, right: 15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var actionsButton: UIButton = {
        let view = UIButton(sfSymbol: .ellipses)
        view.tintColor = ._gray
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var buttonStack: UIStackView = {
        let view = UIStackView(
            arrangedSubviews: [
                followButton,
                messageButton,
                emailButton
            ]
        )
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) var eventsLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(
            attributedStrings: [
                NSAttributedString(string: "20", color: ._black, fontType: .demiBold, fontSize: 14),
                NSAttributedString(string: "\nEvents", color: ._black, fontType: .regular, fontSize: 12),
            ]
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) var followersLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(
            attributedStrings: [
                NSAttributedString(string: "1,000", color: ._black, fontType: .demiBold, fontSize: 14),
                NSAttributedString(string: "\nFollowers", color: ._black, fontType: .regular, fontSize: 12),
            ]
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) var followingLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(
            attributedStrings: [
                NSAttributedString(string: "150", color: ._black, fontType: .demiBold, fontSize: 14),
                NSAttributedString(string: "\nFollowing", color: ._black, fontType: .regular, fontSize: 12),
            ]
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var labelStackView: UIStackView = {
        let view = UIStackView(
            arrangedSubviews: [
                eventsLabel,
                followersLabel,
                followingLabel,
            ]
        )
        view.spacing = 20
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .equalSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var usernameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .demiBold, size: 16)
        view.textColor = .black
        view.numberOfLines = 1
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var bioLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .medium, size: 14)
        view.textColor = ._gray
        view.numberOfLines = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(buttonStack)
        addSubview(actionsButton)
        addSubview(labelStackView)
        addSubview(usernameLabel)
        addSubview(bioLabel)
        
        labelStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        labelStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        labelStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        
        usernameLabel.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 15).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        
        bioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10).isActive = true
        bioLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        bioLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        
        buttonStack.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 15).isActive = true
        buttonStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        
        actionsButton.heightAnchor.constraint(equalTo: buttonStack.heightAnchor).isActive = true
        actionsButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        actionsButton.leftAnchor.constraint(equalTo: buttonStack.rightAnchor).isActive = true
        actionsButton.centerYAnchor.constraint(equalTo: buttonStack.centerYAnchor).isActive = true
        actionsButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        
        bottomAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 20).isActive = true
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
