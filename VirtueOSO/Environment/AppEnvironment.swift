//
//  AppEnvironment.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 1/11/21.
//  Copyright © 2021 Heriberto Prieto. All rights reserved.
//

import Foundation

@objc public class AppEnvironment: NSObject {
    
    private static var _shared: AppEnvironment = AppEnvironment()
    
    @objc
    public class var shared: AppEnvironment {
        get {
            return _shared
        }
        set {
            _shared = newValue
        }
    }
}
