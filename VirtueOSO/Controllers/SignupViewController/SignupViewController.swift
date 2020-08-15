//
//  SignupViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/12/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var firstNameTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "First name"
        view._roundCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    lazy var lastNameTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Last name"
        view._roundCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return view
    }()
    
    lazy var birthdateTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Birthdate"
        return view
    }()
    
    lazy var emailTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Email address"
        return view
    }()
    
    lazy var passwordTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Password"
        view._secureTextEntry = true
        return view
    }()
    
    lazy var receiveMessagesCheckboxView: CheckboxView = {
        let view = CheckboxView()
        view._text = """
        I don't want to reveice marketing messages from Virtuoso. I can also opt out of receiving these at any time in my account settings or via the link in the message.
        """
        return view
    }()
    
    lazy var agreeAndContinueButton: Button = {
        let view = Button("Agree and continue")
        view.backgroundColor = ._secondary
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = navigationController as? NavigationController {
            navigationController._isClear = false
            navigationController._font = UIFont(type: .medium, size: .large)
            navigationController._tintColor = .black
            navigationController._barStyle = .default
            navigationController.navigationBar.backgroundColor = .white
        }
    }
    
    private func initializeSubviews() {
        view.backgroundColor = _darkModeEnabled ? .black : .white
        navigationItem.title = "Sign up"
        
        view.addSubview(scrollView)
        scrollView.addSubview(verticalStackView)
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top + Margins.formTop.rawValue).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        verticalStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        verticalStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: Margins.width.rawValue).isActive = true
        
        verticalStackView.addArrangedSubview(firstNameTextField)
        verticalStackView.addArrangedSubview(lastNameTextField)
        verticalStackView.addArrangedSubview(EmptySpaceView(5))
        verticalStackView.addToStack("Make sure it matches the name on your government ID")
        verticalStackView.addArrangedSubview(EmptySpaceView(20))
        verticalStackView.addArrangedSubview(birthdateTextField)
        verticalStackView.addArrangedSubview(EmptySpaceView(5))
        verticalStackView.addToStack("To sign up, you need to be at least 18. Your birthday won’t be shared with other people who use Airbnb.")
        verticalStackView.addArrangedSubview(EmptySpaceView(20))
        verticalStackView.addArrangedSubview(emailTextField)
        verticalStackView.addArrangedSubview(EmptySpaceView(5))
        verticalStackView.addToStack("We'll email you trip confirmations and receipts.")
        verticalStackView.addArrangedSubview(EmptySpaceView(20))
        verticalStackView.addArrangedSubview(passwordTextField)
        verticalStackView.addArrangedSubview(EmptySpaceView(10))
        verticalStackView.addToStack("We’ll send you marketing promotions, special offers, inspiration, and policy updates via email.")
        verticalStackView.addVerticalEmptySpace(10)
        verticalStackView.addArrangedSubview(receiveMessagesCheckboxView)
        verticalStackView.addVerticalEmptySpace(15)
        verticalStackView.addArrangedSubview(agreeAndContinueButton)
        verticalStackView.addVerticalEmptySpace(view.frame.height / 2)
    }
}
