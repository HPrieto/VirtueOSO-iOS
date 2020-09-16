//
//  MainCoordinator.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 8/16/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: - MainCoordinator
class MainCoordinator: Coordinator {
    
    // MARK: - Public Properties
    let window: UIWindow
    let rootViewController: UINavigationController
    private var authenticationCoordinator: AuthenticationCoordinator?
    private var settingsCoordinator: SettingsCoordinator?
    
    
    enum Destination: Int {
        case root
        case authentication
        case settings
    }
    
    // MARK: - Init
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
    }
    
    func navigate(to destination: Destination) {
        switch destination {
        case .authentication:
            
        }
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
