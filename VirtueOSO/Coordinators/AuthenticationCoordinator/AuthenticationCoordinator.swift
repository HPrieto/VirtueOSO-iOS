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
    
    // MARK: - Private Properties
    let mainCoordinator: MainCoordinator
    
    // MARK: - Public Properties
    lazy var rootViewController: UINavigationController = {
        let navController = NavigationController()
        return navController
    }()
    
    // MARK: - ViewControllers
    private lazy var homeViewController: AuthenticationHomeViewController = {
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
    
    private lazy var resetPasswordViewController: SubmitEmailViewController = {
        let controller = SubmitEmailViewController()
        controller._message = "Enter the email address associated with your account, and we’ll email you a link to reset your password."
        controller._title = "Email"
        controller._submitButtonText = "Send reset link"
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
    
    // MARK: - Init
    init(mainCoordinator: MainCoordinator) {
        self.mainCoordinator = mainCoordinator
    }
    
    func navigate(to destination: Destination) {
        let controller = makeViewController(for: destination)
        rootViewController.pushViewController(controller, animated: true)
    }
    
    // MARK: - MakeViewController
    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .root:
            return homeViewController
        case .login:
            return loginViewController
        case .signup:
            return signupViewController
        case .resetPassword:
            return resetPasswordViewController
        }
    }
    
    // MARK: - Start
    func start() {
        navigate(to: .root)
    }
}
