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
        self.init(image: image, style: style, target: target, action: action)
    }
    
    convenience init?(withRoundImage image: UIImage?,
                      target: Any?,
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
    }
    
    convenience init?(text: String,
                      textColor: UIColor = ._black,
                      fontType: UIFont.FontType = .demiBold,
                      fontSize: CGFloat = 18,
                      target: Any?,
                      action: Selector?) {
        let label: UILabel = UILabel()
        label.text = text
        label.backgroundColor = .clear
        label.font = UIFont(type: fontType, size: fontSize)
        label.textColor = textColor
        label.numberOfLines = 1
        self.init(customView: label)
    }
}
