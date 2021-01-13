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
    private(set) var mainCoordinator: MainCoordinator
    
    // MARK: - Public Properties
    private(set) lazy var rootViewController: UINavigationController = {
        let navController = NavigationController()
        return navController
    }()
    
    // MARK: - ViewControllers
    private(set) lazy var homeViewController: AuthenticationHomeViewController = {
        let controller = AuthenticationHomeViewController(coordinator: self)
        controller.authenticationDelegate = self
        return controller
    }()
    
    // MARK: - LoginViewController
    private(set) lazy var loginViewController: LoginViewController = {
        let controller = LoginViewController()
        controller.state = .disabled
        controller.loginDelegate = self
        return controller
    }()
    
    // MARK: - SubmitEmailViewController
    private(set) lazy var submitEmailViewController: SubmitEmailViewController = {
        let controller = SubmitEmailViewController()
        controller.delegate = self
        return controller
    }()
    
    // MARK: - SignupViewController
    private(set) lazy var signupViewController: SignupViewController = {
        let controller = SignupViewController()
        controller.state = .disabled
        controller.signupDelegate = self
        return controller
    }()
    
    private(set) lazy var resetPasswordViewController: SubmitEmailViewController = {
        let controller = SubmitEmailViewController()
        controller._message = "Enter the email address associated with your account, and we’ll email you a link to reset your password."
        controller._title = "Email"
        controller._submitButtonText = "Send reset link"
        return controller
    }()
    
    // MAKR: - Network Methods
    
    public func login(email: String, password: String, completionHandler: @escaping UserCompletion) {
        let credentials: Credentials = Credentials(username: "duskayame@gmail.com", password: "MFourT3st")
        DBManager.shared.login(credentials: credentials, completionHandler: completionHandler)
    }
    
    public func isUsernameAvailable(username: String, completionHandler: @escaping AvailabilityCompletion) {
        DBManager.shared.getUsernameAvailability(username: username, completionHandler: completionHandler)
    }
    
    public func isEmailAvailable(email: String, completionHandler: @escaping AvailabilityCompletion) {
        DBManager.shared.getEmailAvailability(email: email, completionHandler: completionHandler)
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

// MARK: - AuthenticationViewControllerDelegate

extension AuthenticationCoordinator: AuthenticationHomeViewControllerDelegate {
    func authenticationHomeViewController(_ controller: AuthenticationHomeViewController, didPressLoginButton button: UIButton) {
        navigate(to: .login)
    }
    
    func authenticationHomeViewController(_ controller: AuthenticationHomeViewController, didPressGoogleButton button: UIButton) {
        
    }
    
    func authenticationHomeViewController(_ controller: AuthenticationHomeViewController, didPressFacebookButton button: UIButton) {
        
    }
    
    func authenticationHomeViewController(_ controller: AuthenticationHomeViewController, didPressCreateAccountButton button: UIButton) {
        navigate(to: .signup)
    }
    
    func authenticationHomeViewController(_ controller: AuthenticationHomeViewController, didPressMoreOptionsButton button: UIButton) {
        
    }
    
    
}

// MARK: - LoginViewControllerDelegate

extension AuthenticationCoordinator: LoginViewControllerDelegate {
    func loginViewController(_ controller: LoginViewController, didEnterEmail email: String?, password: String?) {
        guard
            let email: String = email, email.count > 1,
            let password: String = password, password.count > 5
        else {
            print("invalid email or password")
            controller.state = .disabled
            return
        }
        print("valid email:", email, password)
        controller.state = .enabled
    }
    
    func loginViewController(_ controller: LoginViewController, forgotPasswordTapped button: UIButton) {
        submitEmailViewController._message = "Enter the email address associated with your account, and we’ll email you a link to reset your password."
        submitEmailViewController._title = "Email"
        submitEmailViewController._submitButtonText = "Send reset link"
        submitEmailViewController.emailTextField.textField.text = ""
        rootViewController.present(
            NavigationController(rootViewController: submitEmailViewController),
            animated: true,
            completion: nil
        )
    }
    
    func loginViewController(_ controller: LoginViewController, loginButtonTapped button: UIButton, credentials: Credentials) {
        let email: String = credentials.username
        let password: String = credentials.password
        login(email: email, password: password) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .failure(let error):
                self.rootViewController.presentAlert(title: "Error", message: error.localizedDescription)
            case .success(let user):
                print(user.username, user.id, user.createTime)
            }
        }
    }
    
    func loginViewController(_ controller: LoginViewController, signupButtonTapped button: UIButton) {
        navigate(to: .loginToSignup)
    }
    
    func loginViewController(_ controller: LoginViewController, goBack buttonItem: UIBarButtonItem) {
        navigate(to: .loginToRoot)
    }
}

// MARK: - SignupViewControllerDelegate

extension AuthenticationCoordinator: SignupViewControllerDelegate {
    
    func signupViewController(_ controller: SignupViewController, agreeAndContinue button: UIButton, newUser: User) {
        print(newUser.username, newUser.email, newUser.password)
    }
    
    func signupViewController(_ controller: SignupViewController, goBack buttonItem: UIBarButtonItem) {
        navigate(to: .signupToRoot)
    }
    
    // TODO: Finish handling when an invalid username is chosen by user
    func signupViewController(_ controller: SignupViewController, didEnterUsername username: String) {
        isUsernameAvailable(username: username) { (result) in
            switch result {
            case .failure(let error):
                controller.state = .usernameUnavailable(message: error.localizedDescription)
            case .success(let model):
                guard
                    let available: Bool = model.available,
                    let message: String = model.message
                else {
                    return
                }
                if available {
                    controller.state = .usernameAvailable(message: message)
                } else {
                    controller.state = .usernameUnavailable(message: message)
                }
            }
        }
    }
    
    // TODO: Finish handling when an invalid email is chosen by user
    func signupViewController(_ controller: SignupViewController, didEnterEmail email: String) {
        isEmailAvailable(email: email) { (result) in
            switch result {
            case .failure(let error):
                controller.state = .emailUnavailable(message: error.localizedDescription)
            case .success(let model):
                guard
                    let available: Bool = model.available,
                    let message: String = model.message
                else {
                    return
                }
                if available {
                    controller.state = .emailAvailable(message: message)
                } else {
                    controller.state = .emailUnavailable(message: message)
                }
            }
        }
    }
}

// MARK: - SubmitEmailViewController

extension AuthenticationCoordinator: SubmitEmailViewControllerDelegate {
    
    func submitEmailViewController(_ controller: SubmitEmailViewController, didSubmitEmail email: String) {
        print("Submitting email: ", email)
    }
}
