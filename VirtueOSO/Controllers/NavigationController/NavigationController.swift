//
//  NavigationController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/10/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    var _barStyle: UIBarStyle = .default {
        didSet {
            navigationBar.barStyle = _barStyle
        }
    }
    
    var _font: UIFont? = UIFont(type: .medium, size: .regular) {
        didSet {
            guard let font = _font else { return }
            navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
        }
    }
    
    var _tintColor: UIColor = .black {
        didSet {
            navigationBar.tintColor = _tintColor
        }
    }
    
    var _backgroundColor: UIColor = .white {
        didSet {
            navigationBar.backgroundColor = _backgroundColor
        }
    }
    
    var _isClear: Bool = false {
        didSet {
            navigationBar.isTranslucent = _isClear
            if !_isClear { return }
            navigationBar.backgroundColor = .clear
            navigationBar.shadowImage = UIImage()
            navigationBar.setBackgroundImage(UIImage(), for: .default)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    private func initializeSubviews() {
        navigationBar.isHidden = false
        navigationBar.backgroundColor = self._darkModeEnabled ? .black : .white
        navigationBar.tintColor = self._darkModeEnabled ? .white : .black
        navigationBar.barStyle = .default
        //UINavigationBar.appearance().barTintColor = self._darkModeEnabled ? .black : .white
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: _font!
        ]
    }
    
}
