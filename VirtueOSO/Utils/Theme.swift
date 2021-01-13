//
//  Theme.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 1/11/21.
//  Copyright © 2021 Heriberto Prieto. All rights reserved.
//

import UIKit

public struct Theme {
    private init() {}
}

// MARK: - Margins

public extension Theme {
    
    struct Margins {
        private init() {}
        
        public static let left: CGFloat = 20
        
        public static let right: CGFloat = -20
        
        public static let normal: UIEdgeInsets = UIEdgeInsets(
            top: 5,
            left: 9,
            bottom: 5,
            right: 9
        )
        
        public static let large: UIEdgeInsets = UIEdgeInsets(
            top: 13,
            left: 23,
            bottom: 13,
            right: 23
        )
    }
}
