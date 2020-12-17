//
//  NotificationTableViewCell.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/2/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    public static let reuseIdentifier: String = "notification-table-view-cell"
    
    // MARK: - Private Properties
    
    private let mainImageViewHeight: CGFloat = 55
    private var mainImageViewWidth: CGFloat {
        mainImageViewHeight
    }
    private var mainImageViewCornerRadius: CGFloat {
        mainImageViewHeight / 2
    }
    
    // MARK: - Subviews
    
    private(set) lazy var mainImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var messageLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.backgroundColor = .clear
        view.numberOfLines = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Utils
    
    public func set(username: String, message: String, timestamp: Date) {
        messageLabel.attributedText = NSMutableAttributedString(attributedStrings: [
            NSAttributedString(string: username, color: .black, fontType: .medium, fontSize: 14),
            NSAttributedString(string: message, color: .black, fontType: .regular, fontSize: 14),
            NSAttributedString(string: "2d ago", color: .lightGray, fontType: .regular, fontSize: 14)
        ])
    }
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        addSubview(mainImageView)
        addSubview(messageLabel)
        
        mainImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        mainImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        mainImageView.heightAnchor.constraint(equalToConstant: mainImageViewHeight).isActive = true
        mainImageView.widthAnchor.constraint(equalToConstant: mainImageViewWidth).isActive = true
        
        messageLabel.leftAnchor.constraint(equalTo: mainImageView.rightAnchor, constant: 10).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        messageLabel.heightAnchor.constraint(lessThanOrEqualTo: mainImageView.heightAnchor).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
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
