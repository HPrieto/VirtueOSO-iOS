//
//  NSMutableAttributedString+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/3/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    
    convenience init(string: String,
                     color: UIColor = ._black,
                     fontType: UIFont.FontType = .regular,
                     fontSize: CGFloat = 12,
                     underlineStyle: NSUnderlineStyle? = nil,
                     underlineColor: UIColor = .black) {
        var attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(type: fontType, size: fontSize) as Any,
            .foregroundColor: color
        ]
        if let underlineStyle = underlineStyle {
            attributes[NSAttributedString.Key.underlineStyle] = underlineStyle
            attributes[NSAttributedString.Key.underlineColor] = underlineColor
        }
        let attributedString: NSAttributedString = NSAttributedString(
            string: string,
            attributes: attributes)
        self.init(attributedString: attributedString)
    }
    
    public func append(attributedStrings: [NSAttributedString]) {
        attributedStrings.forEach { [weak self] (attrString) in
            guard let `self` = self else { return }
            self.append(attrString)
        }
    }
    
    convenience init(attributedStrings: [NSAttributedString]) {
        self.init(string: "")
        attributedStrings.forEach { [weak self] (attrString) in
            guard let `self` = self else { return }
            self.append(attrString)
        }
    }
}
