//
//  Button.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/11/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    enum State {
        case enabled
        case disabled
        case pending
    }
    
    enum DefaultStyle: CGFloat {
        case cornerRadius = 8
        case paddingLeftRight = 23
        case paddingTopBottom = 13
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
    
    var _cornerRadius: CGFloat = DefaultStyle.cornerRadius.rawValue {
        didSet {
            layer.cornerRadius = _cornerRadius
        }
    }
    
    private func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        titleLabel?.font = _font
        layer.cornerRadius = _cornerRadius
        contentEdgeInsets = UIEdgeInsets(
            top: DefaultStyle.paddingTopBottom.rawValue,
            left: DefaultStyle.paddingLeftRight.rawValue,
            bottom: DefaultStyle.paddingTopBottom.rawValue,
            right: DefaultStyle.paddingLeftRight.rawValue
        )
    }
    
    init(_ title: String) {
        super.init(frame: CGRect.zero)
        self._title = title
        setTitle(title, for: .normal)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
