//
//  ProfileCoordinator.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 9/26/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

extension ProfileCoordinator {
    
    @objc func handleLogout() {
        mainCoordinator.navigate(to: .authentication)
    }
}
