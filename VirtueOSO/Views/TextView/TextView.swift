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
    
    private func initialize() {
        backgroundColor = .clear
        sizeToFit()
        isScrollEnabled = false
        isEditable = false
        isUserInteractionEnabled = false
        font = UIFont(type: .regular, size: .small)
        textContainerInset = _padding
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: CGRect.zero, textContainer: textContainer)
        initialize()
    }
    
    init(text: String, textColor: UIColor = .black, font: UIFont? = UIFont(type: .regular, size: .small)) {
        super.init(frame: CGRect.zero, textContainer: nil)
        initialize()
        self.text = text
        self.textColor = textColor
        self.font = font
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
