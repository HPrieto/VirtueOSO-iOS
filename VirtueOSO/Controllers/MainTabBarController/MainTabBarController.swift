//
//  MainTabViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 9/23/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit


// MARK: - MainTabBarController
class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    enum TabBarType {
        case clear
        case normal
    }
    
    // MARK: - Public Properties
    var _delegate: MainTabBarControllerDelegate?
    
    var _tabBarType: TabBarType = .clear {
        didSet {
            switch _tabBarType {
            case .clear:
                tabBar.backgroundColor = .clear
                tabBar.tintColor = .white
                tabBar.barTintColor = .white
                tabBar.backgroundImage = UIImage()
                tabBar.barStyle = .black
                tabBar.unselectedItemTintColor = .white
            case .normal:
                if self._darkModeEnabled {
                    tabBar.backgroundColor = .black
                    tabBar.tintColor = .white
                    tabBar.barTintColor = .white
                    tabBar.backgroundImage = UIImage()
                    tabBar.barStyle = .black
                    tabBarItem.badgeColor = .white
                    tabBar.unselectedItemTintColor = .white
                } else {
                    tabBar.backgroundColor = .white
                    tabBar.tintColor = .black
                    tabBar.barTintColor = .black
                    tabBar.backgroundImage = UIImage()
                    tabBar.barStyle = .default
                    tabBarItem.badgeColor = .black
                    tabBar.unselectedItemTintColor = .black
                }
            }
        }
    }
    
    // MARK: - Initialize Subviews
    private func initializeSubviews() {
        _tabBarType = .clear
        delegate = self
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tag: Int = viewController.tabBarItem.tag
        _delegate?.mainTabBarController(self, didSelect: viewController, tag: tag)
    }
}
