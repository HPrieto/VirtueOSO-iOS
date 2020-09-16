//
//  LoginCoordinator.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 8/22/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: - LoginCoordinator
class AuthenticationCoordinator: Coordinator {
    
    // MARK: - ViewControllers
    private lazy var rootViewController: AuthenticationHomeViewController = {
        let controller = AuthenticationHomeViewController()
        return controller
    }()
    
    // MARK: - LoginViewController
    private lazy var loginViewController: LoginViewController = {
        let controller = LoginViewController()
        return controller
    }()
    
    // MARK: - SignupViewController
    private lazy var signupViewController: SignupViewController = {
        let controller = SignupViewController()
        return controller
    }()
    
    // MARK: - Destination
    enum Destination: Int {
        case root
        
        /// Login
        case login
        
        /// Signup
        case signup
        
        /// Reset Password
        case resetPassword
    }
    
    var navigationController: UINavigationController
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigate(to destination: Destination) {
        
    }
    
    // MARK: - MakeViewController
    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .root:
            return rootViewController
        case .login:
            return loginViewController
        case .signup:
            return signupViewController
        }
    }
    
    // MARK: - Start
    func start() {
        navigate(to: .root)
    }
}
