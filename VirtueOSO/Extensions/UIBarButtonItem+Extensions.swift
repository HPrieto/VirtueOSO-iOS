//
//  UIBarButtonItem+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 9/27/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init?(sfSymbol: UIImage.SFSymbol,
                      weight: UIImage.SymbolWeight = .semibold,
                      style: UIBarButtonItem.Style,
                      target: Any?,
                      action: Selector?) {
        guard let image = UIImage(sfSymbol: sfSymbol, withWeight: weight) else { return nil }
        self.init(
            image: image,
            style: style,
            target: target,
            action: action
        )
    }
    
    convenience init?(withRoundImage image: UIImage?,
                      target: AnyObject?,
                      action: Selector?,
                      height: CGFloat = 30,
                      width: CGFloat = 30) {
        let roundImageView: UIImageView = UIImageView()
        roundImageView.setTestImage()
        roundImageView.layer.masksToBounds = true
        roundImageView.layer.cornerRadius = height / 2
        roundImageView.translatesAutoresizingMaskIntoConstraints = false
        roundImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        roundImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.init(customView: roundImageView)
        self.target = target
        self.action = action
    }
    
    convenience init?(title: String?,
                      fontType: UIFont.FontType,
                      foregroundColor: UIColor = .black,
                      backgroundColor: UIColor = .clear,
                      size: CGFloat,
                      target: Any?,
                      action: Selector?) {
        self.init(title: title, style: .plain, target: target as Any, action: action)
        self.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(type: fontType, size: size) as Any,
            NSAttributedString.Key.foregroundColor: foregroundColor,
            NSAttributedString.Key.backgroundColor: backgroundColor
        ], for: .normal)
    }
}
