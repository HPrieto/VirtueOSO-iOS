//
//  UIImage+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/25/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

extension UIImage {
    
    static let _backArrow: UIImage? = UIImage(named: "back-arrow")?.withRenderingMode(.alwaysTemplate)
    
    static let _unlocked: UIImage? = UIImage(named: "unlocked")?.withRenderingMode(.alwaysTemplate)
    static let _locked: UIImage? = UIImage(named: "locked")?.withRenderingMode(.alwaysTemplate)
    
    static let _upArrow25: UIImage? = UIImage(named: "up-arrow25")?.withRenderingMode(.alwaysTemplate)
}
