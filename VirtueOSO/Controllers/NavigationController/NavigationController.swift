//
//  NavigationController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/10/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    private func initializeSubviews() {
        navigationBar.isHidden = false
        navigationBar.backgroundColor = self._darkModeEnabled ? .black : .white
        navigationBar.tintColor = self._darkModeEnabled ? .white : .black
        navigationBar.barStyle = .default
        UINavigationBar.appearance().barTintColor = self._darkModeEnabled ? .black : .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor._black]
    }
    
}
