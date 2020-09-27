//
//  MainTabBarControllerDelegate.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 9/26/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

protocol MainTabBarControllerDelegate {
    func mainTabBarController(_ mainTabBarController: MainTabBarController, didSelect viewController: UIViewController, tag: Int)
}
