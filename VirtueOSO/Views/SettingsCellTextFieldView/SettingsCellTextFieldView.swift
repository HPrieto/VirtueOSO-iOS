//
//  SettingsCellTextFieldView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/26/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit



// MARK: - SettingsCellTextFieldView
class SettingsCellTextFieldView: UIView {
    
    // MARK: - Constants
    private lazy var lockedImage: UIImage? = UIImage(systemName: "eye")
    private lazy var unlockedImage: UIImage? = UIImage(systemName: "eye.slash")
    
    /// Tells `SettingsCellTextFieldView` what input type to display
    enum InputMode {
        /// Shows text entry characters
        case normal
        /// Shows dots inplace of characters
        case secure
    }
    
    // MARK: - Private Properties
    
    private var heightLayoutConstraint: NSLayoutConstraint?
    
    // MARK: - Public Properties
    
    var _text: String? {
        get {
            return textField.text
        }
        set {
            textField.text = newValue
        }
    }
    
    var _inputMode: InputMode = .normal {
        didSet {
            switch _inputMode {
            case .normal:
                secureTextToggleButton.alpha = 0
                secureTextToggleButton.isUserInteractionEnabled = false
                textField.isSecureTextEntry = true
            case .secure:
                secureTextToggleButton.alpha = 1
                secureTextToggleButton.isUserInteractionEnabled = true
                textField.isSecureTextEntry = true
            }
        }
    }
    
    override var tag: Int {
        set {
            textField.tag = newValue
        }
        get {
            return textField.tag
        }
    }
    var delegate: UITextFieldDelegate? {
        didSet {
            textField.delegate = delegate
        }
    }
    var _keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = _keyboardType
        }
    }
    
    var _height: CGFloat = 60 {
        didSet {
            heightLayoutConstraint?.constant = _height
        }
    }
    
    var _value: String? {
        get {
            return textField.text
        }
        set {
            textField.text = newValue
        }
    }
    
    var _title: String? {
        didSet {
            titleLabel.text = _title
        }
    }
    
    var _placeholder: String? {
        didSet {
            textField.placeholder = _placeholder
        }
    }
    
    // MARK: - Views
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.font = UIFont(type: .regular, size: .small)
        view.textColor = ._gray
        view.numberOfLines = 1
        view.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var textField: UITextField = {
        let view = UITextField()
        view.font = UIFont(type: .regular, size: .small)
        view.textColor = ._black
        view.tintColor = ._secondary
        view.autocorrectionType = .no
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var secureTextToggleButton: UIButton = {
        let view = UIButton()
        view.setImage(lockedImage, for: .normal)
        view.tintColor = ._black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = false
        let padding: CGFloat = 10
        view.contentEdgeInsets = UIEdgeInsets(
            top: padding,
            left: padding,
            bottom: padding,
            right: padding
        )
        view.addTarget(
            self,
            action: #selector(handleToggleSecureText),
            for: .touchUpInside
        )
        return view
    }()
    
    // MARK: - Utils
    
    public func set(title: String, placeholder: String, keyboardType: UIKeyboardType = .default) {
        self._title = title
        self._placeholder = placeholder
        self._keyboardType = keyboardType
    }
    
    // MARK: - Handlers
    
    @objc private func handleTap() {
        textField.becomeFirstResponder()
    }
    
    @objc private func handleToggleSecureText() {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        secureTextToggleButton.setImage(
            textField.isSecureTextEntry ? lockedImage : unlockedImage,
            for: .normal
        )
    }
    
    // MARK: - Initialize Subviews
    
    private func initializeSubviews() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: _height)
        heightLayoutConstraint?.isActive = true
        
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(secureTextToggleButton)
        
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45).isActive = true
        
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        textField.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        
        secureTextToggleButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1).isActive = true
        secureTextToggleButton.widthAnchor.constraint(equalTo: secureTextToggleButton.heightAnchor).isActive = true
        secureTextToggleButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        secureTextToggleButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initializeSubviews()
    }
    
    init(title: String, placeholder: String = "", keyboardType: UIKeyboardType = .default) {
        super.init(frame: .zero)
        initializeSubviews()
        self.set(title: title, placeholder: placeholder, keyboardType: keyboardType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
