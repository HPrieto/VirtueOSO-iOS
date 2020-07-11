//
//  UIColor.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/10/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }

    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }

    convenience init(netHex:Int, alpha: CGFloat = 1.0) {
        self.init(
            red:(netHex >> 16) & 0xff,
            green:(netHex >> 8) & 0xff,
            blue:netHex & 0xff,
            alpha: alpha
        )
    }
    
    static let _backgroundGray: UIColor = UIColor(247, 247, 247)

    static let _black: UIColor = UIColor(34, 34, 34)

    static let _lightGray: UIColor = UIColor(netHex: 0xEBEBEB)

    static let _gray: UIColor = UIColor(113, 113, 113)

    static let _darkGray: UIColor = UIColor(72, 72, 72)

    static let _primary: UIColor = UIColor(netHex: 0xff5a5f)

    static let _secondary: UIColor = UIColor(netHex: 0x00a699)
    
    static let _tertiary: UIColor = UIColor(netHex: 0xfc642d)
    
}
