//
//  Coordinator.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/25/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

protocol Coordinator {
    associatedtype Destination
    var navigationController: UINavigationController { get set }
    func navigate(to destination: Destination)
    func start()
}
