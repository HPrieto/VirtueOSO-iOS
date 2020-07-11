//
//  TextView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/11/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class TextView: UITextView {
    
    var _padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5) {
        didSet {
            textContainerInset = _padding
        }
    }
    
    func initialize() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        sizeToFit()
        isScrollEnabled = false
        isEditable = false
        isUserInteractionEnabled = false
        contentInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
        font = UIFont(type: .regular, size: .regular)
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: CGRect.zero, textContainer: textContainer)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
