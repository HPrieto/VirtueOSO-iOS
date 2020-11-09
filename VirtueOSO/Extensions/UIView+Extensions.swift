//
//  UIView+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/10/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

extension UIView {

    public var _darkModeEnabled: Bool {
        return UITraitCollection().userInterfaceStyle == .dark
    }

    func addShadow(opacity: Float = 0.4, color: UIColor = ._black, width: CGFloat = 0, height: CGFloat = 0, radius: CGFloat = 8) {
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowColor = color.cgColor
    }

    public var _size: CGSize {
        return self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
    
    convenience init(corners: UIRectCorner, radius: Double) {
        self.init()
        layer.masksToBounds = true
        round(corners: corners, radius: radius)
    }
    
    func round(corners: UIRectCorner, radius: Double) {
        let path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
