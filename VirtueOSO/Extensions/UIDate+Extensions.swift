//
//  UIDate+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/31/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

extension Date {
    
    public func toString(withDateFormat dateFormat: String = "MM-dd-yyyy HH:mm:ss") -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
}
