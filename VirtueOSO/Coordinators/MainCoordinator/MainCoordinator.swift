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
    
    private(set) lazy var homeViewController: HomeViewController = {
        let controller = HomeViewController()
        controller.setTabBarItem(
            withIcon: .house,
            selectedIcon: .houseFill,
            weight: .light,
            selectedWeight: .light
        )
        return controller
    }()
    
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
            selectedIcon: .personFill)
        return coordinator
    }()
    
    private(set) lazy var discoverCoordinator: DiscoverCoordinator = {
        let coordinator = DiscoverCoordinator(mainCoordinator: self)
        coordinator.rootViewController.setTabBarItem(
            withIcon: .magnifyingGlass,
            selectedIcon: .magnifyingGlass)
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
    
    // MARK: - Init
    init(window: UIWindow) {
        self.window = window
    }
    
    
    // MARK: - Flow
    public func navigate(to destination: Destination) {
        switch destination {
        case .root:
            rootViewController.viewControllers = [
                eventsCoordinator.rootViewController,
                discoverCoordinator.rootViewController,
                profileCoordinator.rootViewController
            ]
        case .authentication:
            authenticationCoordinator.rootViewController.modalPresentationStyle = .fullScreen
            rootViewController.present(
                authenticationCoordinator.rootViewController,
                animated: true,
                completion: nil
            )
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
