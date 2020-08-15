//
//  SettingsNavigationBarView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/26/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class SettingsNavigationBarView: UIView {
    
    // MARK: - Private Properties
    private var heightLayoutConstraint: NSLayoutConstraint?
    
    // MARK: - Public Properties
    public var _height: CGFloat = 90 {
        didSet {
            heightLayoutConstraint?.constant = _height
        }
    }
    
    public var _tintColor: UIColor = ._black {
        didSet {
            leftButton.titleLabel?.textColor = _tintColor
            leftButton.tintColor = _tintColor
            
            rightButton.titleLabel?.textColor = _tintColor
            rightButton.tintColor = _tintColor
            
            titleLabel.textColor = _tintColor
        }
    }
    
    public var _titleFont: UIFont? = UIFont(type: .medium, size: .small) {
        didSet {
            guard let titleFont = _titleFont else { return }
            titleLabel.font = titleFont
        }
    }
    
    public var _itemsFont: UIFont? = UIFont(type: .medium, size: .small) {
        didSet {
            guard let itemsFont = _itemsFont else { return }
            leftButton.titleLabel?.font = itemsFont
            rightButton.titleLabel?.font = itemsFont
        }
    }
    
    public var _leftButtonImage: UIImage? {
        didSet {
            leftButton.setTitle(nil, for: .normal)
            leftButton.setImage(_leftButtonImage, for: .normal)
        }
    }
    
    public var _leftButtonTitle: String? {
        didSet {
            leftButton.setTitle(_leftButtonTitle, for: .normal)
            leftButton.setImage(nil, for: .normal)
        }
    }
    
    public var _rightButtonImage: UIImage? {
        didSet {
            rightButton.setTitle(nil, for: .normal)
            rightButton.setImage(_rightButtonImage, for: .normal)
        }
    }
    
    public var _rightButtonTitle: String? {
        didSet {
            rightButton.setTitle(_rightButtonTitle, for: .normal)
            rightButton.setImage(nil, for: .normal)
        }
    }
    
    public var _borderColor: UIColor = ._background {
        didSet {
            bottomBorder.backgroundColor = _borderColor
        }
    }
    
    public var _title: String? {
        didSet {
            titleLabel.text = _title
        }
    }
    
    // MARK: - Subviews
    private(set) lazy var leftButton: UIButton = {
        let imageConfig: UIImage.SymbolConfiguration = UIImage.SymbolConfiguration(weight: .medium)
        let image: UIImage? = UIImage(systemName: "arrow.left", withConfiguration: imageConfig)
        let view = UIButton()
        view.setImage(image, for: .normal)
        view.tintColor = ._black
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var rightButton: UIButton = {
        let view = UIButton()
        view.setTitle("Done", for: .normal)
        view.tintColor = .black
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .medium, size: .small)
        view.textColor = ._black
        view.textAlignment = .center
        view.text = "Personal Info"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomBorder: Border = {
        let view = Border()
        view.backgroundColor = ._background
        return view
    }()
    
    // MARK: - Initialize Subviews
    private func initializeSubviews() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: _height)
        heightLayoutConstraint?.isActive = true
        
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(titleLabel)
        addSubview(bottomBorder)
        
        bottomBorder.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        leftButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        leftButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        leftButton.widthAnchor.constraint(equalTo: leftButton.heightAnchor).isActive = true
        leftButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
        
        rightButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        rightButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        rightButton.widthAnchor.constraint(equalTo: rightButton.heightAnchor).isActive = true
        rightButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
        
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftButton.rightAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightButton.leftAnchor).isActive = true
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
