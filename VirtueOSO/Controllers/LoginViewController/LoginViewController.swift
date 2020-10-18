//
//  LoginViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/12/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Public Properties
    
    private(set) var coordinator: AuthenticationCoordinator
    
    // MARK: - Subviews
    
    private(set) lazy var leftBarButtonItem: UIBarButtonItem? = {
        return UIBarButtonItem(sfSymbol: .chevronLeft, style: .plain, target: self, action: #selector(handleGoBack))
    }()
    
    private(set) lazy var emailTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Email"
        view.inputTextView.keyboardType = .emailAddress
        view._roundCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private(set) lazy var passwordTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Password"
        view._contentType = .password
        view._secureTextEntry = true
        view.inputTextView.keyboardType = .default
        view._roundCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return view
    }()
    
    private(set) lazy var loginButton: Button = {
        let view = Button("Log in", buttonType: .large)
        view.backgroundColor = ._secondary
        return view
    }()
    
    private(set) lazy var forgotPasswordButton: AButton = {
        let view = AButton("Forgot password?")
        view.addTarget(
            self,
            action: #selector(handleForgotPassword),
            for: .touchUpInside
        )
        return view
    }()
    
    private(set) lazy var dontHaveAccountTextView: TextView = {
        let view = TextView()
        view.text = "Don't have an account?"
        view.textColor = ._gray
        return view
    }()
    
    private(set) lazy var signupButton: AButton = {
        let view = AButton("Sign up")
        view.addTarget(
            self,
            action: #selector(handleSignup),
            for: .touchUpInside
        )
        return view
    }()
    
    // MARK: - Handlers
    
    @objc private func handleLogin() {
        guard let email: String = emailTextField._text, email.count > 1,
              let password: String = passwordTextField._text, password.count > 5 else {
            return
        }
        coordinator.login(email: email, password: password)
    }
    
    @objc private func handleForgotPassword() {
        let controller = SubmitEmailViewController()
        controller._message = "Enter the email address associated with your account, and we’ll email you a link to reset your password."
        controller._title = "Email"
        controller._submitButtonText = "Send reset link"
        present(
            NavigationController(rootViewController: controller),
            animated: true,
            completion: nil
        )
    }
    
    @objc private func handleSignup() {
        coordinator.navigate(to: .loginToSignup)
    }
    
    @objc private func handleGoBack() {
        coordinator.navigate(to: .loginToRoot)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = navigationController as? NavigationController {
            navigationController._isClear = false
            navigationController._font = UIFont(type: .demiBold, size: .regular)
            navigationController._tintColor = .black
            navigationController._barStyle = .default
            navigationController.navigationBar.backgroundColor = .white
        }
    }
    
    // MARK: - Initialize Subviews
    
    fileprivate func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.title = "Log in"
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(dontHaveAccountTextView)
        view.addSubview(signupButton)
        
        emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top + Margins.formTop.rawValue).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: Margins.width.rawValue).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: -1).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        loginButton.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 25).isActive = true
        forgotPasswordButton.leftAnchor.constraint(equalTo: loginButton.leftAnchor).isActive = true
        
        dontHaveAccountTextView.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 25).isActive = true
        dontHaveAccountTextView.leftAnchor.constraint(equalTo: loginButton.leftAnchor).isActive = true
        
        signupButton.leftAnchor.constraint(equalTo: dontHaveAccountTextView.rightAnchor).isActive = true
        signupButton.centerYAnchor.constraint(equalTo: dontHaveAccountTextView.centerYAnchor).isActive = true
    }
    
    // MARK: Init
    init(coordinator: AuthenticationCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
