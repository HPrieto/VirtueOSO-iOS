//
//  String+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 12/31/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation

extension String {
    
    var boolValue: Bool {
        return (self as NSString).boolValue
    }
}
