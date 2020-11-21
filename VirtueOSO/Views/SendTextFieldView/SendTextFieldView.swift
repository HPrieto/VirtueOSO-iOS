//
//  SendTextFieldView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/15/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class SendTextFieldView: UIView {
    
    // MARK: - Private Properties
    
    private let height: CGFloat = 45
    private var cornerRadius: CGFloat {
        return height / 2
    }
    
    private let sendButtonWidth: CGFloat = 60
    
    // MARK: - Subviews
    
    private(set) lazy var textView: UITextView = {
        let view = UITextView()
        view.sizeToFit()
        view.backgroundColor = .clear
        view.textContainerInset = .zero
        view.contentInset = .zero
        view.font = UIFont(type: .medium, size: 14)
        view.isScrollEnabled = false
        view.scrollIndicatorInsets = .zero
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var sendButton: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = UIFont(type: .demiBold, size: 18)
        view.setTitleColor(._blue, for: .normal)
        view.backgroundColor = .clear
        view.setTitle("Send", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(textView)
        addSubview(sendButton)
        
        textView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        textView.topAnchor.constraint(equalTo: topAnchor, constant: 12.5).isActive = true
        textView.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -10).isActive = true
        
        sendButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        sendButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: 12.5).isActive = true
        heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
        
        layer.masksToBounds = true
        layer.borderWidth = 1.5
        layer.cornerRadius = cornerRadius
        layer.borderColor = UIColor._lightGray.cgColor
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
