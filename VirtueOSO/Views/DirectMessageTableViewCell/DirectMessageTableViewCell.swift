//
//  DirectMessageTableViewCell.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/15/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class DirectMessageTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private var profileImageViewLeftLayoutConstraint: NSLayoutConstraint?
    private var bubbleViewRightLayoutConstraint: NSLayoutConstraint?
    
    private let profileImageViewHeight: CGFloat = 30
    private var profileImageViewWidth: CGFloat {
        return profileImageViewHeight
    }
    private var profileImageViewCornerRadius: CGFloat {
        return profileImageViewHeight / 2
    }
    
    private let messageViewInsetX: CGFloat = 15
    private let messageViewInsetY: CGFloat = 10
    
    private var bubbleViewCornerRadius: CGFloat {
        return ((messageViewInsetY * 2) + 20) / 2
    }
    
    // MARK: - Enums
    
    enum State {
        case sent
        case received
    }
    
    // MARK: - Static Properties
    
    public static var reuseIdentifier: String = "direct-message-table-view-cell"
    
    // MARK: - Public Properties
    
    var state: State = .sent {
        didSet {
            switch state {
            case .received:
                profileImageView.alpha = 1
                messageLabel.textColor = ._black
                bubbleView.backgroundColor = ._lightGray
                bubbleView.layer.borderColor = UIColor._lightGray.cgColor
                bubbleViewRightLayoutConstraint?.isActive = false
                profileImageViewLeftLayoutConstraint?.isActive = true
            case .sent:
                profileImageView.alpha = 0
                messageLabel.textColor = .white
                bubbleView.layer.borderColor = UIColor._blue.cgColor
                bubbleView.backgroundColor = ._blue
                profileImageViewLeftLayoutConstraint?.isActive = false
                bubbleViewRightLayoutConstraint?.isActive = true
            }
        }
    }
    
    // MARK: - Subviews
    
    private(set) lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.alpha = 0
        view.backgroundColor = .lightGray
        view.layer.masksToBounds = true
        view.layer.cornerRadius = profileImageViewCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var bubbleView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = bubbleViewCornerRadius
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        view.layer.borderColor = UIColor._lightGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var messageLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .medium, size: 16)
        view.textColor = ._black
        view.numberOfLines = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        selectionStyle = .none
        
        addSubview(profileImageView)
        addSubview(bubbleView)
        
        bubbleView.addSubview(messageLabel)
        
        bubbleView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        bubbleView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.75).isActive = true
        bubbleView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10).isActive = true
        bubbleViewRightLayoutConstraint = bubbleView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15)
        bubbleViewRightLayoutConstraint?.isActive = true
        
        profileImageViewLeftLayoutConstraint = profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15)
        profileImageView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: messageViewInsetY).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: messageViewInsetX).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: bubbleView.rightAnchor, constant: -messageViewInsetX).isActive = true
        
        bubbleView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: messageViewInsetY).isActive = true
        
        bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: 5).isActive = true
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
