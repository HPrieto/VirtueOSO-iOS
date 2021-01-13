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
    
    convenience init?(type: FontType, size: CGFloat) {
        self.init(name: type.rawValue, size: size)
    }
    
    public static func light(size: CGFloat) -> UIFont? {
        return UIFont(name: UIFont.FontType.light.rawValue, size: size)
    }
    
    public static func regular(size: CGFloat) -> UIFont? {
        return UIFont(name: UIFont.FontType.regular.rawValue, size: size)
    }
    
    public static func medium(size: CGFloat) -> UIFont? {
        return UIFont(name: UIFont.FontType.medium.rawValue, size: size)
    }
    
    public static func demiBold(size: CGFloat) -> UIFont? {
        return UIFont(name: UIFont.FontType.demiBold.rawValue, size: size)
    }
    
    public static func bold(size: CGFloat) -> UIFont? {
        return UIFont(name: UIFont.FontType.bold.rawValue, size: size)
    }
    
    public static func heavy(size: CGFloat) -> UIFont? {
        return UIFont(name: UIFont.FontType.heavy.rawValue, size: size)
    }
}
