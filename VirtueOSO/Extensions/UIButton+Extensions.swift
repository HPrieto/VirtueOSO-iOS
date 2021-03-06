//
//  UIButton+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/11/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init(sfSymbol: UIImage.SFSymbol, withWeight weight: UIImage.SymbolWeight = .semibold) {
        self.init()
        let image: UIImage? = UIImage(sfSymbol: sfSymbol, withWeight: weight)
        setImage(image, for: .normal)
        imageView?.contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
    }
    
    convenience init(sfSymbolForBackground sfSymbol: UIImage.SFSymbol, withWeight weight: UIImage.SymbolWeight = .semibold) {
        self.init()
        let image: UIImage? = UIImage(sfSymbol: sfSymbol, withWeight: weight)
        setBackgroundImage(image, for: .normal)
        imageView?.contentMode = .scaleAspectFit
        imageView?.backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
    }
}
