//
//  AuthenticationViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/10/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

/**
 
 Root ViewController for user authentication process.
 
 */

// MARK: - AuthenticationHomeViewController
class AuthenticationHomeViewController: UIViewController {
    
    // MARK: - Strings
    private enum Strings: String {
        case loginButtonTitle = "Log in"
        case title = "Welcome to Virtuoso"
        case googleButtonTitle = "Continue width Google"
        case facebookButtonTitle = "Continue width Facebook"
        case createAccountButtonTitle = "Create an Account"
        case moreOptionsButtonTitle = "More options"
        case disclaimer = """
        By signing up, I agree to Virutuoso's Terms of Service, Non-Discrimination Policy, Payments Terms of Service, and Host Guarantee Terms.
        """
    }
    
    // MARK: - Views
    lazy var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .fill
        view.spacing = 20
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = ._primary
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var verticalButtonStackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .leading
        view.spacing = 20
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var iconImageView: UIImageView = {
        let image = UIImage(named: "music_tickets")!.withRenderingMode(.alwaysTemplate)
        let view = UIImageView()
        view.image = image
        view.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleTextView: TextView = {
        let view = TextView()
        view.font = UIFont(type: .medium, size: .title2)
        view.textColor = .white
        view.text = Strings.title.rawValue
        return view
    }()
    
    lazy var googleButton: Button = {
        let view = Button(Strings.googleButtonTitle.rawValue)
        view.backgroundColor = .white
        view._font = UIFont(type: .medium, size: .large)
        view._textColor = ._secondary
        view._cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var facebookButton: Button = {
        let view = Button(Strings.facebookButtonTitle.rawValue)
        view.backgroundColor = .white
        view._font = UIFont(type: .medium, size: .large)
        view._textColor = ._secondary
        view._cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var createAccountButton: Button = {
        let view = Button(Strings.createAccountButtonTitle.rawValue)
        view.backgroundColor = .white
        view._font = UIFont(type: .medium, size: .large)
        view._textColor = .white
        view.backgroundColor = ._secondary
        view._borderColor = .white
        view._borderWidth = 1
        view._cornerRadius = 25
        view.addTarget(self, action: #selector(handleCreateAccount), for: .touchUpInside)
        return view
    }()
    
    lazy var optionsButton: AButton = {
        let view = AButton(Strings.moreOptionsButtonTitle.rawValue)
        view._textColor = .white
        view.backgroundColor = .clear
        view._font = UIFont(type: .demiBold, size: .regular)
        return view
    }()
    
    lazy var disclaimerTextView: TextView = {
        let view = TextView()
        view.textColor = .white
        view.font = UIFont(type: .medium, size: .regular)
        view.text = Strings.disclaimer.rawValue
        return view
    }()
    
    lazy var loginBarButton: UIBarButtonItem = {
        let view = UIBarButtonItem(
            title: Strings.loginButtonTitle.rawValue,
            style: .plain,
            target: self,
            action: #selector(handleLogin)
        )
        return view
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = navigationController as? NavigationController {
            navigationController._isClear = true
            navigationController._font = UIFont(type: .regular, size: .small)
            navigationController._tintColor = .white
            navigationController._barStyle = .black
            navigationController.navigationBar.backgroundColor = .clear
        }
    }
    
    // MARK: - Initialize Subview
    private func initializeSubviews() {
        view.backgroundColor = ._secondary
        navigationItem.rightBarButtonItem = loginBarButton
        
        view.addSubview(iconImageView)
        view.addSubview(verticalStackView)
        
        let bottomMargin: CGFloat = -(view.safeAreaInsets.bottom + 40)
        
        verticalButtonStackView.addArrangedSubview(googleButton)
        verticalButtonStackView.addArrangedSubview(facebookButton)
        verticalButtonStackView.addArrangedSubview(createAccountButton)
        verticalButtonStackView.addArrangedSubview(optionsButton)
        
        iconImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top + 100).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        iconImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        
        verticalStackView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 20).isActive = true
        verticalStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomMargin).isActive = true
        
        verticalStackView.addArrangedSubview(titleTextView)
        verticalStackView.addArrangedSubview(verticalButtonStackView)
        verticalStackView.addArrangedSubview(disclaimerTextView)
        
        googleButton.widthAnchor.constraint(equalTo: verticalButtonStackView.widthAnchor).isActive = true
        facebookButton.widthAnchor.constraint(equalTo: verticalButtonStackView.widthAnchor).isActive = true
        createAccountButton.widthAnchor.constraint(equalTo: verticalButtonStackView.widthAnchor).isActive = true
    }
    
    // MARK: - Handlers
    @objc func handleLogin() {
        let controller = LoginViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleCreateAccount() {
        let controller = SignupViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
