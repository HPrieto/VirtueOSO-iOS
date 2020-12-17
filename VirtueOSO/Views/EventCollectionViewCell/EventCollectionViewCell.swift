//
//  EventCollectionViewCell.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/3/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Static Members
    
    public static var reuseIdentifier: String = "event-collection-view-cell"
    
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
    
    private(set) lazy var statusTextView: UITextView = {
        let view = UITextView()
        view.textContainerInset = UIEdgeInsets(
            top: 3.5,
            left: 7.5,
            bottom: 3.5,
            right: 7.5
        )
        view.adjustsFontForContentSizeCategory = true
        view.textContainer.maximumNumberOfLines = 1
        view.font = UIFont(type: .demiBold, size: 14)
        view.backgroundColor = .black
        view.textColor = .white
        view.isScrollEnabled = false
        view.isUserInteractionEnabled = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var likeButton: UIButton = {
        let button = UIButton(sfSymbolForBackground: .heart, withWeight: .regular)
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
        //view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 8
        view.backgroundColor = ._gray
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTestImage()
        return view
    }()
    
    private(set) lazy var eventNameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .demiBold, size: 16)
        view.textColor = ._black
        view.numberOfLines = 2
        view.textAlignment = .left
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
        view.font = UIFont(type: .bold, size: 32)
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
    
    // MARK: - Utils
    
    public func set(amount: String, uom: String) {
        amountLabel.attributedText = NSMutableAttributedString(attributedStrings: [
            NSAttributedString(
                string: amount,
                color: .black,
                fontType: .demiBold,
                fontSize: .small
            ),
            NSAttributedString(
                string: " / \(uom)",
                color: ._darkGray,
                fontType: .medium,
                fontSize: .small
            )
        ])
    }
    
    // MARK: - Initialize
    
    private func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(eventImageView)
        
        eventImageView.addSubview(statusTextView)
        eventImageView.addSubview(likeButton)
        //eventImageView.addSubview(commentButton)
        eventImageView.addSubview(usernameLabel)
        
        contentView.addSubview(eventNameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(amountLabel)
        
        eventImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        eventImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        eventImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        eventImageView.heightAnchor.constraint(equalTo: eventImageView.widthAnchor, multiplier: (6/9)).isActive = true
        
        statusTextView.leftAnchor.constraint(equalTo: eventImageView.leftAnchor, constant: 20).isActive = true
        statusTextView.topAnchor.constraint(equalTo: eventImageView.topAnchor, constant: 20).isActive = true
        statusTextView.widthAnchor.constraint(lessThanOrEqualTo: eventImageView.widthAnchor, multiplier: 0.5).isActive = true
        
        likeButton.rightAnchor.constraint(equalTo: eventImageView.rightAnchor, constant: -20).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: statusTextView.centerYAnchor).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: likeButtonHeight).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: likeButtonWidth).isActive = true
        
        usernameLabel.bottomAnchor.constraint(equalTo: eventImageView.bottomAnchor).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: eventImageView.leftAnchor).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: eventImageView.rightAnchor).isActive = true
        
        eventNameLabel.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 10).isActive = true
        eventNameLabel.leftAnchor.constraint(equalTo: eventImageView.leftAnchor).isActive = true
        eventNameLabel.rightAnchor.constraint(equalTo: eventImageView.rightAnchor).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: eventImageView.leftAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: eventImageView.rightAnchor).isActive = true
        
        amountLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        amountLabel.leftAnchor.constraint(equalTo: descriptionLabel.leftAnchor).isActive = true
        amountLabel.rightAnchor.constraint(equalTo: descriptionLabel.rightAnchor).isActive = true
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
