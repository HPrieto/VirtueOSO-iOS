//
//  MainCoordinator.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 8/16/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: - MainCoordinator
class MainCoordinator {
    
    // MARK: - Private Properties
    private let window: UIWindow
    private weak var authenticationCoordinator: AuthenticationCoordinator!
    private weak var settingsCoordinator: SettingsCoordinator!
    
    private lazy var navigationController: UINavigationController = {
        return UINavigationController()
    }()
    
    private lazy var rootViewController: LiveStreamViewController = {
        let controller = LiveStreamViewController()
        return controller
    }()
    
    // MARK: - Public Properties
    
    enum Destination {
        case root
        case authentication
        case settings
    }
    
    // MARK: - Init
    init(window: UIWindow) {
        self.window = window
    }
    
    
    // MARK: - Flow
    func navigate(to destination: Destination) {
        switch destination {
        case .root:
            navigationController.viewControllers = [rootViewController]
        case .authentication:
            navigationController.present(
                authenticationCoordinator.rootViewController,
                animated: true,
                completion: nil)
        case .settings:
            navigationController.present(
                settingsCoordinator.rootViewController,
                animated: true,
                completion: nil)
        }
    }
    
    func start() {
        window.rootViewController = rootViewController
    }
    
    func create(viewControllerFor destination: Destination) -> UIViewController {
        switch destination {
        case .root:
            return rootViewController
        case .authentication:
            authenticationCoordinator.start()
            return authenticationCoordinator.rootViewController
        case .settings:
            settingsCoordinator.start()
            return settingsCoordinator.rootViewController
        }
    }
}
