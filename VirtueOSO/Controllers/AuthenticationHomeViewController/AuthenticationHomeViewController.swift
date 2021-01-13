//
//  AuthenticationViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/10/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: - AuthenticationHomeViewControllerDelegate

protocol AuthenticationHomeViewControllerDelegate {
    func authenticationHomeViewController(_ controller: AuthenticationHomeViewController, didPressLoginButton button: UIButton)
    func authenticationHomeViewController(_ controller: AuthenticationHomeViewController, didPressGoogleButton button: UIButton)
    func authenticationHomeViewController(_ controller: AuthenticationHomeViewController, didPressFacebookButton button: UIButton)
    func authenticationHomeViewController(_ controller: AuthenticationHomeViewController, didPressCreateAccountButton button: UIButton)
    func authenticationHomeViewController(_ controller: AuthenticationHomeViewController, didPressMoreOptionsButton button: UIButton)
}

/**
 
 Root ViewController for user authentication process.
 
 */

// MARK: - AuthenticationHomeViewController
class AuthenticationHomeViewController: UIViewController {
    
    // MARK: - Public Properties
    private(set) var coordinator: AuthenticationCoordinator
    
    var authenticationDelegate: AuthenticationHomeViewControllerDelegate?
    
    // MARK: - Strings
    private enum Strings: String {
        case loginButtonTitle = "Log in"
        case title = "Welcome to Kashmir"
        case googleButtonTitle = "Continue with Google"
        case facebookButtonTitle = "Continue with Facebook"
        case createAccountButtonTitle = "Create an Account"
        case moreOptionsButtonTitle = "More options"
        case disclaimer = """
        By signing up, I agree to Kashmir's Terms of Service, Non-Discrimination Policy, Payments Terms of Service, and Host Guarantee Terms.
        """
    }
    
    // MARK: - Views
    private(set) lazy var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .fill
        view.spacing = 20
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = ._primary
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var verticalButtonStackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .leading
        view.spacing = 20
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var iconImageView: UIImageView = {
        // let image = UIImage(named: "music_tickets")!.withRenderingMode(.alwaysTemplate)
        let image = UIImage(sfSymbol: "tv.music.note", withWeight: .light)
        let view = UIImageView()
        view.image = image
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var titleTextView: TextView = {
        let view = TextView()
        view.font = UIFont(type: .medium, size: .title2)
        view.textColor = .white
        view.text = Strings.title.rawValue
        return view
    }()
    
    private(set) lazy var googleButton: Button = {
        let view = Button(Strings.googleButtonTitle.rawValue, buttonType: .roundSides)
        view.backgroundColor = .white
        view._font = UIFont(type: .medium, size: .small)
        view._textColor = ._secondary
        view._cornerRadius = 22.5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(handleGoogle), for: .touchUpInside)
        return view
    }()
    
    private(set) lazy var facebookButton: Button = {
        let view = Button(Strings.facebookButtonTitle.rawValue, buttonType: .roundSides)
        view.backgroundColor = .white
        view._font = UIFont(type: .medium, size: .small)
        view._textColor = ._secondary
        view._cornerRadius = 22.5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(handleFacebook), for: .touchUpInside)
        return view
    }()
    
    private(set) lazy var createAccountButton: Button = {
        let view = Button(Strings.createAccountButtonTitle.rawValue, buttonType: .roundSides)
        view.backgroundColor = .white
        view._font = UIFont(type: .medium, size: .small)
        view._textColor = .white
        view.backgroundColor = ._secondary
        view._borderColor = .white
        view._borderWidth = 1
        view._cornerRadius = 22.5
        view.addTarget(self, action: #selector(handleCreateAccount), for: .touchUpInside)
        return view
    }()
    
    private(set) lazy var optionsButton: AButton = {
        let view = AButton(Strings.moreOptionsButtonTitle.rawValue)
        view._textColor = .white
        view.backgroundColor = .clear
        view._font = UIFont(type: .demiBold, size: .small)
        return view
    }()
    
    // By signing up, I agree to Virutuoso's Terms of Service, Non-Discrimination Policy, Payments Terms of Service, and Host Guarantee Terms.
    private(set) lazy var disclaimerTextView: AttributedTextView = {
        let view = AttributedTextView(attributes: [
            NSAttributedString(
                string: "By signing up, I agree to Kashmir's ",
                color: .white,
                fontSize: .small
            ),
            NSAttributedString(
                string: "Terms of Service",
                color: .white,
                fontType: .demiBold,
                fontSize: .small
            ),
            NSAttributedString(
                string: ", ",
                color: .white,
                fontSize: .small
            ),
            NSAttributedString(
                string: "Non-Discrimination Policy",
                color: .white,
                fontType: .demiBold,
                fontSize: .small
            ),
            NSAttributedString(
                string: ", ",
                color: .white,
                fontSize: .small
            ),
            NSAttributedString(
                string: "Payments Terms of Service",
                color: .white,
                fontType: .demiBold,
                fontSize: .small
            ),
            NSAttributedString(
                string: ", and ",
                color: .white,
                fontSize: .small
            ),
            NSAttributedString(
                string: "Host Gaurantee Terms",
                color: .white,
                fontType: .demiBold,
                fontSize: .small
            ),
        ])
        view.textContainer.maximumNumberOfLines = 3
        view.isEditable = false
        view.isSelectable = true
        view.isScrollEnabled = false
        view.backgroundColor = .clear
        return view
    }()
    
    private(set) lazy var loginBarButton: UIBarButtonItem = {
        let view = UIBarButtonItem(
            title: Strings.loginButtonTitle.rawValue,
            style: .plain,
            target: self,
            action: #selector(handleLogin)
        )
        return view
    }()
    
    // MARK: - Handlers
    @objc private func handleLogin(sender: UIButton) {
        authenticationDelegate?.authenticationHomeViewController(self, didPressLoginButton: sender)
    }
    
    @objc private func handleGoogle(sender: UIButton) {
        authenticationDelegate?.authenticationHomeViewController(self, didPressGoogleButton: sender)
    }
    
    @objc private func handleFacebook(sender: UIButton) {
        authenticationDelegate?.authenticationHomeViewController(self, didPressFacebookButton: sender)
    }
    
    @objc private func handleCreateAccount(sender: UIButton) {
        authenticationDelegate?.authenticationHomeViewController(self, didPressCreateAccountButton: sender)
    }
    
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
    
    // MARK: - Init
    init(coordinator: AuthenticationCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
