//
//  NSAttributedString+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/3/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    convenience init?(image: UIImage) {
        let attachment: NSTextAttachment = NSTextAttachment(image: image)
        self.init(attachment: attachment)
    }
    
    convenience init(string: String,
                     color: UIColor = ._black,
                     fontType: UIFont.FontType = .regular,
                     fontSize: UIFont.FontSize = .regular) {
        let attributedString: NSAttributedString = NSAttributedString(
            string: string,
            attributes: [
                .font: UIFont(type: fontType, size: fontSize) as Any,
                NSAttributedString.Key.foregroundColor: color
            ])
        self.init(attributedString: attributedString)
    }
}
