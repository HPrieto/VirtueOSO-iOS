//
//  ProfileActionView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/29/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class ProfileActionView: UIView {
    
    // MARK: - Subviews
    
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
        view.text = "@hprieto"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var bioLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .medium, size: 14)
        view.textColor = ._gray
        view.numberOfLines = 4
        view.text = "Kanye Omari West is an American rapper, record producer, and fashion designer. He has been influential in the 21st-century development of mainstream hip hop and popular music in general."
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(labelStackView)
        addSubview(usernameLabel)
        addSubview(bioLabel)
        
        labelStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        labelStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        labelStackView.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -20).isActive = true
        labelStackView.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: 20).isActive = true
        
        usernameLabel.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 15).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: labelStackView.leftAnchor).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: labelStackView.rightAnchor).isActive = true
        
        bioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10).isActive = true
        bioLabel.leftAnchor.constraint(equalTo: labelStackView.leftAnchor).isActive = true
        bioLabel.rightAnchor.constraint(equalTo: labelStackView.rightAnchor).isActive = true
        
        bottomAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 10).isActive = true
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
