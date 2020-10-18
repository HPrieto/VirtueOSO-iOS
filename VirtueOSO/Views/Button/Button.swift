//
//  Button.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/11/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    enum ButtonType {
        case normal
        case roundSides
        case large
    }
    
    enum State {
        case enabled
        case disabled
        case pending
    }
    
    enum NormalButtonStyle: CGFloat {
        case cornerRadius = 4
        case paddingLeftRight = 9
        case paddingTopBottom = 5
    }
    
    enum RoundSidesButtonStyle: CGFloat {
        case cornerRadius = 8
        case paddingLeftRight = 23
        case paddingTopBottom = 13
    }
    
    enum LargeButtonStyle: CGFloat {
        case cornerRadius = 4
        case paddingLeftRight = 23
        case paddingTopBottom = 13
    }
    
    var _buttonType: ButtonType = .normal {
        didSet {
            switch _buttonType {
            case .normal:
                contentEdgeInsets = UIEdgeInsets(
                    top: NormalButtonStyle.paddingTopBottom.rawValue,
                    left: NormalButtonStyle.paddingLeftRight.rawValue,
                    bottom: NormalButtonStyle.paddingTopBottom.rawValue,
                    right: NormalButtonStyle.paddingLeftRight.rawValue
                )
            case .roundSides:
                contentEdgeInsets = UIEdgeInsets(
                    top: RoundSidesButtonStyle.paddingTopBottom.rawValue,
                    left: RoundSidesButtonStyle.paddingLeftRight.rawValue,
                    bottom: RoundSidesButtonStyle.paddingTopBottom.rawValue,
                    right: RoundSidesButtonStyle.paddingLeftRight.rawValue
                )
            case .large:
                contentEdgeInsets = UIEdgeInsets(
                    top: LargeButtonStyle.paddingTopBottom.rawValue,
                    left: LargeButtonStyle.paddingLeftRight.rawValue,
                    bottom: LargeButtonStyle.paddingTopBottom.rawValue,
                    right: LargeButtonStyle.paddingLeftRight.rawValue
                )
            }
        }
    }
    
    var _font: UIFont? = UIFont(type: .demiBold, size: .small) {
        didSet {
            titleLabel?.font = _font
        }
    }
    
    var _title: String = "" {
        didSet {
            setTitle(_title, for: .normal)
        }
    }
    
    var _textColor: UIColor = .black {
        didSet {
            setTitleColor(_textColor, for: .normal)
        }
    }
    
    var _borderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = _borderWidth
        }
    }
    
    var _borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = _borderColor.cgColor
        }
    }
    
    var _cornerRadius: CGFloat = NormalButtonStyle.cornerRadius.rawValue {
        didSet {
            layer.cornerRadius = _cornerRadius
        }
    }
    
    // MARK: - Public Methods
    
    public func setButtonType(_ buttonType: ButtonType) {
        self._buttonType = buttonType
    }
    
    // MARK: - Initialize
    
    private func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        titleLabel?.font = _font
        layer.cornerRadius = _cornerRadius
        contentEdgeInsets = UIEdgeInsets(
            top: NormalButtonStyle.paddingTopBottom.rawValue,
            left: NormalButtonStyle.paddingLeftRight.rawValue,
            bottom: NormalButtonStyle.paddingTopBottom.rawValue,
            right: NormalButtonStyle.paddingLeftRight.rawValue
        )
    }
    
    init(_ title: String, buttonType: ButtonType = .normal) {
        super.init(frame: CGRect.zero)
        self._title = title
        setTitle(title, for: .normal)
        initialize()
        setButtonType(buttonType)
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
