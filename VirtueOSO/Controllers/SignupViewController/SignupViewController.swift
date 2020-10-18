//
//  SignupViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/12/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    // MARK: - Public Properties
    private(set) var coordinator: AuthenticationCoordinator
    
    // MARK: - Subviews
    
    private(set) lazy var leftBarButtonItem: UIBarButtonItem? = {
        return UIBarButtonItem(
            sfSymbol: .chevronLeft,
            style: .plain,
            target: self,
            action: #selector(handleGoBack))
    }()
    
    private(set) lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var firstNameTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "First name"
        view._roundCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private(set) lazy var lastNameTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Last name"
        view._roundCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return view
    }()
    
    private(set) lazy var birthdateTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Birthdate"
        return view
    }()
    
    private(set) lazy var emailTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Email address"
        return view
    }()
    
    private(set) lazy var passwordTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Password"
        view.inputTextView.isSecureTextEntry = true
        view._roundCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private(set) lazy var confirmPasswordTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Confirm Password"
        view.inputTextView.isSecureTextEntry = true
        view._roundCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return view
    }()
    
    private(set) lazy var receiveMessagesCheckboxView: CheckboxView = {
        let view = CheckboxView()
        view._text = """
        I don't want to receive marketing messages from Virtuoso. I can also opt out of receiving these at any time in my account settings or via the link in the message.
        """
        return view
    }()
    
    private(set) lazy var agreeAndContinueButton: Button = {
        let view = Button("Agree and continue", buttonType: .large)
        view.backgroundColor = ._secondary
        view.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Handlers
    @objc private func handleGoBack() {
        coordinator.navigate(to: .signupToRoot)
    }
    
    @objc private func handleSignup() {
        coordinator.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Scroll to top when view appears
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
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
        view.backgroundColor = _darkModeEnabled ? .black : .white
        
        navigationItem.title = "Sign up"
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        view.addSubview(scrollView)
        scrollView.addSubview(verticalStackView)
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        verticalStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        verticalStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: Margins.width.rawValue).isActive = true
        
        verticalStackView.addVerticalEmptySpace(20)
        verticalStackView.addArrangedSubview(firstNameTextField)
        verticalStackView.addArrangedSubview(lastNameTextField)
        verticalStackView.addArrangedSubview(EmptySpaceView(5))
        verticalStackView.addText("Make sure it matches the name on your government ID")
        verticalStackView.addArrangedSubview(EmptySpaceView(20))
        verticalStackView.addArrangedSubview(birthdateTextField)
        verticalStackView.addArrangedSubview(EmptySpaceView(5))
        verticalStackView.addText("To sign up, you need to be at least 18. Your birthday won’t be shared with other people who use Airbnb.")
        verticalStackView.addArrangedSubview(EmptySpaceView(20))
        verticalStackView.addArrangedSubview(emailTextField)
        verticalStackView.addArrangedSubview(EmptySpaceView(5))
        verticalStackView.addText("We'll email you trip confirmations and receipts.")
        verticalStackView.addArrangedSubview(EmptySpaceView(20))
        verticalStackView.addArrangedSubview(passwordTextField)
        verticalStackView.addArrangedSubview(confirmPasswordTextField)
        verticalStackView.addArrangedSubview(EmptySpaceView(10))
        verticalStackView.addText("We’ll send you marketing promotions, special offers, inspiration, and policy updates via email.")
        verticalStackView.addVerticalEmptySpace(10)
        verticalStackView.addArrangedSubview(receiveMessagesCheckboxView)
        verticalStackView.addVerticalEmptySpace(15)
        verticalStackView.addArrangedSubview(agreeAndContinueButton)
        verticalStackView.addVerticalEmptySpace(view.frame.height / 2)
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
