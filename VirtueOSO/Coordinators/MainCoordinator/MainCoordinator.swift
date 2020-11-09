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
    
    // MARK: - Coordinators
    
    private(set) lazy var eventsCoordinator: EventsCoordinator = {
        let coordinator = EventsCoordinator(mainCoordinator: self)
        coordinator.rootViewController.setTabBarItem(
            withIcon: .house,
            selectedIcon: .houseFill,
            weight: .light,
            selectedWeight: .light)
        return coordinator
    }()
    
    private(set) lazy var authenticationCoordinator: AuthenticationCoordinator = {
        let coordinator = AuthenticationCoordinator(mainCoordinator: self)
        return coordinator
    }()
    
    private(set) lazy var profileCoordinator: ProfileCoordinator = {
        let coordinator = ProfileCoordinator(mainCoordinator: self)
        coordinator.rootViewController.setTabBarItem(
            withIcon: .person,
            selectedIcon: .personFill,
            weight: .light)
        return coordinator
    }()
    
    private(set) lazy var discoverCoordinator: DiscoverCoordinator = {
        let coordinator = DiscoverCoordinator(mainCoordinator: self)
        coordinator.rootViewController.setTabBarItem(
            withIcon: .magnifyingGlass,
            selectedIcon: .magnifyingGlass,
            weight: .light,
            selectedWeight: .bold)
        return coordinator
    }()
    
    // MARK: - Public Properties
    
    enum Destination {
        case root
        case authentication
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
        controller.setTabBarItem(withIcon: .house, selectedIcon: .houseFill, weight: .light, selectedWeight: .light, tag: 1)
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
                eventsCoordinator.rootViewController,
                discoverCoordinator.rootViewController,
                controller3,
                controller4,
                profileCoordinator.rootViewController
            ]
        case .authentication:
            authenticationCoordinator.rootViewController.modalPresentationStyle = .fullScreen
            rootViewController.present(
                authenticationCoordinator.rootViewController,
                animated: true,
                completion: nil)
        }
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        navigate(to: .root)
        
        eventsCoordinator.start()
        authenticationCoordinator.start()
        profileCoordinator.start()
        discoverCoordinator.start()
    }
    
    // MARK: - Private Methods
    private func create(viewControllerFor destination: Destination) -> UIViewController {
        switch destination {
        case .root:
            rootViewController.viewControllers = [
                eventsCoordinator.rootViewController,
                discoverCoordinator.rootViewController,
                controller3,
                controller4,
                profileCoordinator.rootViewController
            ]
            return rootViewController
        case .authentication:
            authenticationCoordinator.start()
            return authenticationCoordinator.rootViewController
        }
    }
}


// MARK: - MainTabBarControllerDelegate
extension MainCoordinator: MainTabBarControllerDelegate {
    
    func mainTabBarController(_ mainTabBarController: MainTabBarController, didSelect viewController: UIViewController, tag: Int) {
        switch tag {
        case 1:
            rootViewController._tabBarType = .normal
        default:
            rootViewController._tabBarType = .normal
        }
    }
}
