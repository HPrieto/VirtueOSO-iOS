//
//  UIFont+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/10/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

extension UIFont {
    enum FontType: String {
        case light      = "Avenir-Light"
        case regular    = "AvenirNext-Regular"
        case medium     = "AvenirNext-Medium"
        case demiBold   = "AvenirNext-DemiBold"
        case bold       = "AvenirNext-Bold"
        case heavy      = "AvenirNext-Heavy"
    }
    
    enum FontSize: CGFloat {
        case title1     = 44
        case title2     = 32
        case title3     = 24
        case large      = 19
        case regular    = 17
        case small      = 14
        case micro      = 8
    }
    
    convenience init?(type: FontType, size: FontSize) {
        self.init(name: type.rawValue, size: size.rawValue)
    }
}
