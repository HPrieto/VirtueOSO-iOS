//
//  UIBarButtonItem+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 9/27/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init?(sfSymbol: UIImage.SFSymbol, weight: UIImage.SymbolWeight = .regular, style: UIBarButtonItem.Style, target: Any?, action: Selector?) {
        guard let image = UIImage(sfSymbol: sfSymbol, withWeight: weight) else { return nil }
        self.init(image: image, style: style, target: target, action: action)
    }
    
}
