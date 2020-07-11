//
//  Border.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/11/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class Border: ComponentView {
    
    enum Axis {
        case horizontal
        case vertical
    }
    
    var thickness: CGFloat = 1 {
        didSet {
            widthLayoutConstraint?.constant = thickness
            heightLayoutConstraint?.constant = thickness
        }
    }
    
    var axis: Axis = .horizontal {
        didSet {
            switch axis {
            case .horizontal:
                widthLayoutConstraint?.isActive = false
                heightLayoutConstraint?.isActive = true
            case .vertical:
                heightLayoutConstraint?.isActive = false
                heightLayoutConstraint?.isActive = true
            }
        }
    }
    
    private var widthLayoutConstraint: NSLayoutConstraint?
    private var heightLayoutConstraint: NSLayoutConstraint?
    
    override func initializeSubviews() {
        backgroundColor = ._lightGray
        
        widthLayoutConstraint = widthAnchor.constraint(equalToConstant: thickness)
        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: thickness)
        heightLayoutConstraint?.isActive = true
    }
    
    override func updateSubviews() {
        
    }
    
}
