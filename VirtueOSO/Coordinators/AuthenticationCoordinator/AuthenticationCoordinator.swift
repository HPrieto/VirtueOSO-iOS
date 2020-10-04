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
    
    // MARK: - Destination
    enum Destination: Int {
        case root
        
        /// Login
        case login
        case loginToRoot
        case loginToForgotPassword
        case loginToSignup
        
        /// Signup
        case signup
        case signupToRoot
        
        /// Reset Password
        case resetPassword
        case forgotPasswordToLogin
    }
    
    // MARK: - Private Properties
    let mainCoordinator: MainCoordinator
    
    // MARK: - Public Properties
    private(set) lazy var rootViewController: UINavigationController = {
        let navController = NavigationController()
        return navController
    }()
    
    // MARK: - ViewControllers
    private(set) lazy var homeViewController: AuthenticationHomeViewController = {
        let controller = AuthenticationHomeViewController(coordinator: self)
        return controller
    }()
    
    // MARK: - LoginViewController
    private(set) lazy var loginViewController: LoginViewController = {
        let controller = LoginViewController(coordinator: self)
        return controller
    }()
    
    // MARK: - SignupViewController
    private(set) lazy var signupViewController: SignupViewController = {
        let controller = SignupViewController(coordinator: self)
        return controller
    }()
    
    private(set) lazy var resetPasswordViewController: SubmitEmailViewController = {
        let controller = SubmitEmailViewController()
        controller._message = "Enter the email address associated with your account, and we’ll email you a link to reset your password."
        controller._title = "Email"
        controller._submitButtonText = "Send reset link"
        return controller
    }()
    
    // MAKR: - Utils
    
    public func login(email: String, password: String) {
        print("Email: \(email)")
        print("Password: \(password)")
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Init
    init(mainCoordinator: MainCoordinator) {
        self.mainCoordinator = mainCoordinator
    }
    
    func navigate(to destination: Destination) {
        let controller = makeViewController(for: destination)
        
        switch destination {
        case .root:
            rootViewController.viewControllers = [controller]
        case .loginToRoot, .signupToRoot:
            rootViewController.popToViewController(controller, animated: true)
        case .loginToSignup:
            rootViewController.viewControllers = [homeViewController, signupViewController]
        case .loginToForgotPassword:
            rootViewController.present(controller, animated: true, completion: nil)
        case .forgotPasswordToLogin:
            controller.dismiss(animated: true, completion: nil)
        default:
            rootViewController.pushViewController(controller, animated: true)
        }
    }
    
    private func makeViewController(for destination: Destination) -> UIViewController {
        
        switch destination {
        case .root, .loginToRoot, .signupToRoot:
            return homeViewController
        case .login, .forgotPasswordToLogin:
            return loginViewController
        case .signup, .loginToSignup:
            return signupViewController
        case .resetPassword, .loginToForgotPassword:
            return resetPasswordViewController
        }
    }
    
    // MARK: - Start
    func start() {
        navigate(to: .root)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        rootViewController.dismiss(animated: animated, completion: { [weak self] in
            guard let `self` = self else { return }
            completion?()
            self.navigate(to: .root)
        })
    }
}
