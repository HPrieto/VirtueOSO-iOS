//
//  UIScrollView+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/18/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    public func scrollToTop() {
        self.contentOffset = CGPoint(x: 0, y: 0)
    }
}
