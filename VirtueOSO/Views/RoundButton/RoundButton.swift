//
//  RoundButton.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 8/1/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
    
    // MARK: - RoundButtonState
    /// Will be used to set the UI for each button state
    enum RoundButtonState {
        // Button shows color and interactable
        case enabled
        // Button is grayed out and not interactable
        case disabled
    }
    
    // MARK: - Private Properties
    private var heightLayoutConstraint: NSLayoutConstraint?
    
    // MARK: - Public Properties
    var _state: RoundButtonState = .enabled {
        didSet {
            switch _state {
            case .enabled:
                backgroundColor = _buttonColor
                titleLabel?.textColor = _textColor
                setTitle(_title, for: .normal)
                isUserInteractionEnabled = true
            case .disabled:
                backgroundColor = _disabledColor
                titleLabel?.textColor = _disabledTextColor
                setTitle(_disabledTitle ?? _title, for: .normal)
                isUserInteractionEnabled = false
            }
        }
    }
    
    var _title: String? {
        didSet {
            setTitle(_title, for: .normal)
        }
    }
    
    var _height: CGFloat = 44 {
        didSet {
            heightLayoutConstraint?.constant = _height
            layer.cornerRadius = _height / 2
        }
    }
    
    var _font: UIFont? = UIFont(type: .demiBold, size: .small) {
        didSet {
            guard let font = _font else { return }
            titleLabel?.font = font
        }
    }
    
    var _buttonColor: UIColor = ._secondary {
        didSet {
            backgroundColor = _buttonColor
        }
    }
    
    var _textColor: UIColor = .white {
        didSet {
            titleLabel?.textColor = _textColor
        }
    }
    
    /// Disabled UI Properties
    var _disabledColor: UIColor = ._lightGray
    var _disabledTextColor: UIColor = .white
    var _disabledTitle: String?
    
    // MARK: - Utils
    private func setTitle(_ title: String) {
        self._title = title
    }
    
    private func setState(_ state: RoundButtonState) {
        self._state = state
    }
    
    public func enable() {
        self._state = .enabled
    }
    
    public func disable() {
        self._state = .disabled
    }
    
    // MARK: - Initialize Subviews
    private func initialize() {
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        if let font = _font {
            titleLabel?.font = font
        }
        
        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: _height)
        heightLayoutConstraint?.isActive = true
        
        layer.cornerRadius = _height / 2
    }
    
    // MARK: - Init
    init(_ title: String, state: RoundButtonState = .enabled) {
        super.init(frame: .zero)
        self.setTitle(title)
        self.setState(state)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
