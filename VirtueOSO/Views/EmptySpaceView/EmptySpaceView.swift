//
//  EmptySpaceView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/12/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class EmptySpaceView: UIView {
    
    private var heightLayoutConstraint: NSLayoutConstraint?
    
    var _height: CGFloat = 20 {
        didSet {
            heightLayoutConstraint?.constant = _height
        }
    }
    
    init(_ height: CGFloat) {
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: _height)
        heightLayoutConstraint?.isActive = true
        _height = height
        heightLayoutConstraint?.constant = height
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
