//
//  DiscoverCoordinator.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 9/27/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: - DiscoverCoordinator
class DiscoverCoordinator: Coordinator {
    
    enum Destination: Int {
        case root
        case artist
        case artistToRoot
    }
    
    // MARK: Private Properties
    private(set) var mainCoordinator: MainCoordinator
    
    // MARK: - Controllers
    private(set) lazy var rootViewController: UINavigationController = {
        let controller = UINavigationController()
        controller.navigationBar.tintColor = ._black
        controller.navigationBar.backgroundColor = .white
        controller.navigationBar.isTranslucent = true
        controller.navigationBar.barTintColor = .white
        controller.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor._black,
            .font: UIFont(type: .demiBold, size: .regular) as Any
        ]
        controller.navigationBar.barStyle = .default
        return controller
    }()
    
    private(set) lazy var artistViewController: ArtistViewController = {
        let controller = ArtistViewController(coordinator: self)
        return controller
    }()
    
    private lazy var discoverViewController: DiscoverViewController = {
        let controller = DiscoverViewController(coordinator: self)
        return controller
    }()
    
    // MARK: - Flow
    func navigate(to destination: Destination) {
        let controller = makeViewController(for: destination)
        switch destination {
        case .root:
            rootViewController.viewControllers = [controller]
        case .artistToRoot:
            rootViewController.popToViewController(controller, animated: true)
        case .artist:
            rootViewController.pushViewController(controller, animated: true)
        }
    }
    
    func start() {
        navigate(to: .root)
    }
    
    func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .root, .artistToRoot:
            return discoverViewController
        case .artist:
            return artistViewController
        }
    }
    
    // MARK: - Init
    init(mainCoordinator: MainCoordinator) {
        self.mainCoordinator = mainCoordinator
    }
}
