//
//  Coordinator.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/25/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

protocol Coordinator {
    associatedtype Destination: RawRepresentable
    var rootViewController: UINavigationController { get }
    func navigate(to destination: Destination)
    func start()
}
