//
//  AButton.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/12/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class AButton: UIButton {
    
    var _title: String = "" {
        didSet {
            let underlineAttribute = [
                NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue
            ]
            let attributedString: NSAttributedString = NSAttributedString(string: _title, attributes: underlineAttribute)
            setAttributedTitle(attributedString, for: .normal)
        }
    }
    
    var _font: UIFont? = UIFont(type: .demiBold, size: .regular) {
        didSet {
            titleLabel?.font = _font
        }
    }
    
    var _textColor: UIColor = ._black {
        didSet {
            setTitleColor(_textColor, for: .normal)
        }
    }
    
    private func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = _font
        setTitleColor(_textColor, for: .normal)
    }
    
    init(_ title: String) {
        super.init(frame: CGRect.zero)
        let underlineAttribute = [
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue
        ]
        let attributedString: NSAttributedString = NSAttributedString(string: title, attributes: underlineAttribute)
        setAttributedTitle(attributedString, for: .normal)
        self._title = title
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
