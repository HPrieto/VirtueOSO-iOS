//
//  AButton.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/12/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class AButton: UIButton {
    
    var _title: String? {
        set {
            let underlineAttribute = [
                NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue
            ]
            let attributedString: NSAttributedString = NSAttributedString(string: newValue ?? "", attributes: underlineAttribute)
            setAttributedTitle(attributedString, for: .normal)
        }
        get {
            return titleLabel?.text
        }
    }
    
    var _font: UIFont? = UIFont(type: .demiBold, size: .small) {
        didSet {
            titleLabel?.font = _font
        }
    }
    
    var _textColor: UIColor = ._black {
        didSet {
            titleLabel?.textColor = _textColor
        }
    }
    
    private func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = _font
    }
    
    init(_ title: String) {
        super.init(frame: CGRect.zero)
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
