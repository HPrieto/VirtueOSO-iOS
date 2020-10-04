//
//  NSMutableAttributedString+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/3/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    
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
