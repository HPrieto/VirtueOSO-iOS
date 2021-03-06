//
//  EventsCoordinator.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 11/7/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: - EventsCoordinator

class EventsCoordinator: Coordinator {
    
    // MARK: - Private Properties
    
    private(set) var mainCoordinator: MainCoordinator
    
    // MARK: - Public Properties
    
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
    
    // MARK: - Destinations
    
    enum Destination: Int {
        case root
        case event
        case directMessages
        case directMessage
        case selectProfilesToMessage
    }
    
    // MARK: - Controllers
    private(set) lazy var discoverEventTableViewController: HomeViewController = {
        // let controller = DiscoverEventViewController(coordinator: self)
        let controller = HomeViewController()
        return controller
    }()
    
    private(set) lazy var eventViewController: EventViewController = {
        let controller = EventViewController()
        return controller
    }()
    
    private(set) lazy var directMessageListViewController: DirectMessageListTableViewController = {
        let controller = DirectMessageListTableViewController(coordinator: self)
        return controller
    }()
    
    private(set) lazy var directMessageViewController: DirectMessageTableViewController = {
        let controller = DirectMessageTableViewController()
        return controller
    }()
    
    private lazy var selectProfileTableViewController: SelectProfilesTableViewController = {
        let controller = SelectProfilesTableViewController(coordinator: self)
        controller.navigationItem.title = "New Message"
        return controller
    }()
    
    // MARK: - Handlers
    
    // MARK: - Init
    init(mainCoordinator: MainCoordinator) {
        self.mainCoordinator = mainCoordinator
    }
    
    // MARK: - Start
    public func start() {
        navigate(to: .root)
    }
    
    func navigate(to destination: Destination) {
        let viewController: UIViewController = makeViewController(for: destination)
        switch destination {
        case .root,
             .event,
             .directMessages,
             .directMessage,
             .selectProfilesToMessage:
            rootViewController.pushViewController(viewController, animated: true)
        default:
            rootViewController.present(viewController, animated: true, completion: nil)
        }
    }
    
    // MARK: - VC Factory
    
    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .root:
            return discoverEventTableViewController
        case .event:
            return eventViewController
        case .directMessages:
            return directMessageListViewController
        case .directMessage:
            return directMessageViewController
        case .selectProfilesToMessage:
            return selectProfileTableViewController
        default:
            return UIViewController()
        }
    }
}
