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
                bubbleView.backgroundColor = .placeholderText
                bubbleViewRightLayoutConstraint?.isActive = false
                profileImageViewLeftLayoutConstraint?.isActive = true
            case .sent:
                profileImageView.alpha = 0
                bubbleView.backgroundColor = .white
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
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.placeholderText.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var label: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .medium, size: 14)
        view.numberOfLines = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        selectionStyle = .none
        
        addSubview(profileImageView)
        addSubview(bubbleView)
        
        bubbleView.addSubview(label)
        
        bubbleView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        bubbleView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.6).isActive = true
        bubbleView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10).isActive = true
        bubbleViewRightLayoutConstraint = bubbleView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        bubbleViewRightLayoutConstraint?.isActive = true
        
        profileImageViewLeftLayoutConstraint = profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20)
        profileImageView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor).isActive = true
        
        label.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 5).isActive = true
        label.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 5).isActive = true
        label.rightAnchor.constraint(equalTo: bubbleView.rightAnchor, constant: -5).isActive = true
        
        bubbleView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 5).isActive = true
        
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
