//
//  SettingsCellTextView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/18/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: - SettingsCellTextView
class SettingsCellTextView: UIView {
    
    enum State {
        case normal
        case placeholder
    }
    
    // MARK: - Private Properties
    
    private let titleLabelHeightConstant: CGFloat = 30
    private let leftMarginConstant: CGFloat = 20
    private var rightMarginConstant: CGFloat {
        return -leftMarginConstant
    }
    
    private var _state: State = .placeholder {
        didSet {
            switch _state {
            case .normal:
                textView.textColor = ._black
            case .placeholder:
                textView.textColor = .placeholderText
            }
        }
    }
    
    // MARK: - Public Properties
    var _text: String? {
        get {
            return textView.text
        }
        set {
            textView.text = newValue
        }
    }
    
    override var tag: Int {
        set {
            textView.tag = newValue
        }
        get {
            return textView.tag
        }
    }
    
    var _keyboardType: UIKeyboardType = .default {
        didSet {
            textView.keyboardType = _keyboardType
        }
    }
    
    var _value: String? {
        get {
            return textView.text
        }
        set {
            textView.text = newValue
        }
    }
    
    var _title: String? {
        didSet {
            titleLabel.text = _title
        }
    }
    
    var _placeholder: String? {
        didSet {
            if _state == .placeholder {
                textView.text = _placeholder
            }
        }
    }
    
    // MARK: - Public Methods
    public func set(title: String?, placeholder: String?, keyboardType: UIKeyboardType = .default) {
        self._title = title
        self._placeholder = placeholder
        self._keyboardType = keyboardType
        if let placeholder = placeholder {
            self._placeholder = placeholder
            self._state = .placeholder
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
    
    private(set) lazy var textView: TextView = {
        let view = TextView()
        view.font = UIFont(type: .regular, size: .small)
        view.textColor = ._black
        view.tintColor = ._tertiary
        view.autocorrectionType = .no
        view.isUserInteractionEnabled = true
        view.isEditable = true
        view.delegate = self
        return view
    }()
    
    // MARK: - Handlers
    @objc private func handleTap() {
        textView.becomeFirstResponder()
    }
    
    // MARK: - Utils
    
    // MARK: - Initialize Subviews
    private func initializeSubviews() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(textView)
        
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: leftMarginConstant).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: rightMarginConstant).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: titleLabelHeightConstant).isActive = true
        
        textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        textView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        
        bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: 5).isActive = true
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initializeSubviews()
    }
    
    init(title: String?, placeholder: String? = nil, keyboardType: UIKeyboardType = .default) {
        super.init(frame: .zero)
        initializeSubviews()
        self.set(title: title, placeholder: placeholder, keyboardType: keyboardType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITextFieldDelegate
extension SettingsCellTextView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if _state == .placeholder {
            self._text = nil
            self._state = .normal
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self._state = .placeholder
            self._text = _placeholder
        }
    }
}
