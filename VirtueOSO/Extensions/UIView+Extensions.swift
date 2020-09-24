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

    func addShadow(_ opacity: Float = 0.1, _ shadowColor: UIColor = ._black) {
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowRadius = self.layer.cornerRadius / 3
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowColor = shadowColor.cgColor
    }

    public var _size: CGSize {
        return self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
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
