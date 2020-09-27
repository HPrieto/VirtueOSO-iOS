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
    
    private lazy var authenticationCoordinator: AuthenticationCoordinator = {
        let coordinator = AuthenticationCoordinator(mainCoordinator: self)
        return coordinator
    }()
    
    private lazy var settingsCoordinator: ProfileCoordinator = {
        let coordinator = ProfileCoordinator(mainCoordinator: self)
        coordinator.rootViewController.setTabBarItem(
            withIcon: .person,
            selectedIcon: .personFill,
            weight: .light)
        return coordinator
    }()
    
    // MARK: - Public Properties
    
    enum Destination {
        case root
        case authentication
        case settings
    }
    
    // MARK: - Controllers
    private lazy var rootViewController: MainTabBarController = {
        let controller = MainTabBarController()
        controller._delegate = self
        return controller
    }()
    
    private lazy var controller1: UIViewController = {
        let controller = UIViewController()
        controller.view.backgroundColor = .black
        controller.setTabBarItem(withIcon: .houseFill, selectedIcon: .houseFill, weight: .light, selectedWeight: .bold, tag: 1)
        return controller
    }()
    
    private lazy var controller2: UIViewController = {
        let controller = UIViewController()
        controller.view.backgroundColor = .orange
        controller.setTabBarItem(withIcon: .magnifyingGlass, selectedIcon: .magnifyingGlass, weight: .light, selectedWeight: .bold)
        return controller
    }()
    
    private lazy var controller3: UIViewController = {
        let controller = UIViewController()
        controller.view.backgroundColor = .green
        controller.setTabBarItem(withIcon: .plusRectangle, selectedIcon: .plusRectangleFill, weight: .light)
        return controller
    }()
    
    private lazy var controller4: UIViewController = {
        let controller = UIViewController()
        controller.view.backgroundColor = .blue
        controller.setTabBarItem(withIcon: .heart, selectedIcon: .heartFill, weight: .light)
        return controller
    }()
    
    // MARK: - Create ViewControllers
    
    // MARK: - Init
    init(window: UIWindow) {
        self.window = window
    }
    
    
    // MARK: - Flow Public
    public func navigate(to destination: Destination) {
        switch destination {
        case .root:
            rootViewController.viewControllers = [
                controller1,
                controller2,
                controller3,
                controller4,
                settingsCoordinator.rootViewController
            ]
        case .authentication:
            authenticationCoordinator.rootViewController.modalPresentationStyle = .fullScreen
            rootViewController.present(
                authenticationCoordinator.rootViewController,
                animated: true,
                completion: nil)
        case .settings:
            rootViewController.present(
                settingsCoordinator.rootViewController,
                animated: true,
                completion: nil)
        }
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        navigate(to: .root)
        
        authenticationCoordinator.start()
        settingsCoordinator.start()
    }
    
    // MARK: - Private Methods
    private func create(viewControllerFor destination: Destination) -> UIViewController {
        switch destination {
        case .root:
            rootViewController.viewControllers = [
                controller1,
                controller2,
                controller3,
                controller4,
                settingsCoordinator.rootViewController
            ]
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


// MARK: - MainTabBarControllerDelegate
extension MainCoordinator: MainTabBarControllerDelegate {
    
    func mainTabBarController(_ mainTabBarController: MainTabBarController, didSelect viewController: UIViewController, tag: Int) {
        switch tag {
        case 1:
            rootViewController._tabBarType = .clear
        default:
            rootViewController._tabBarType = .normal
        }
    }
}
