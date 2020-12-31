//
//  SignupViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/12/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: - SignupViewControllerDelegate

protocol SignupViewControllerDelegate {
    func signupViewController(_ controller: SignupViewController, agreeAndContinue button: UIButton, newUser: User)
    func signupViewController(_ controller: SignupViewController, goBack buttonItem: UIBarButtonItem)
    func signupViewController(_ controller: SignupViewController, didEnterUsername username: String)
    func signupViewController(_ controller: SignupViewController, didEnterEmail email: String)
}

// MARK: - SignupViewController

class SignupViewController: UIViewController {
    
    enum State {
        case enabled
        case disabled
        case usernameUnavailable(message: String)
        case emailUnavailable(message: String)
    }
    
    enum SubviewTags: Int {
        case username = 1
        case usernameLabel
        case firstName
        case lastName
        case email
        case emailLabel
        case phoneNumber
        case birthDate
        case password
        case confirmPassword
    }
    
    var state: State = .enabled {
        didSet {
            switch state {
            case .enabled:
                agreeAndContinueButton.isEnabled = true
                agreeAndContinueButton.backgroundColor = ._secondary
            case .disabled:
                agreeAndContinueButton.isEnabled = false
                agreeAndContinueButton.backgroundColor = ._lightGray
            case .usernameUnavailable(let message):
                agreeAndContinueButton.isEnabled = false
                agreeAndContinueButton.backgroundColor = ._lightGray
                if let usernameLabel: UITextView = verticalStackView.arrangedSubviews.first(where: { $0.tag == SubviewTags.usernameLabel.rawValue }) as? UITextView {
                    usernameLabel.text = message
                }
            case .emailUnavailable(let message):
                agreeAndContinueButton.isEnabled = false
                agreeAndContinueButton.backgroundColor = ._lightGray
                if let emailLabel: UITextView = verticalStackView.arrangedSubviews.first(where: { $0.tag == SubviewTags.emailLabel.rawValue }) as? UITextView {
                    emailLabel.text = message
                }
            }
        }
    }
    
    // MARK: - Public Properties
    
    var signupDelegate: SignupViewControllerDelegate?
    
    var newUser: User? {
        guard receiveMessagesCheckboxView._checked else {
            return nil
        }
        
        guard
            let username: String = usernameTextField.textField.text,
            username.count > 0
        else {
            return nil
        }
        
        guard
            let firstName: String = firstNameTextField.textField.text,
            let lastName: String = lastNameTextField.textField.text,
            firstName.count > 1, lastName.count > 1
        else {
            return nil
        }
        
        guard
            let email: String = emailTextField.textField.text,
            email.count > 3
        else {
            return nil
        }
        
        guard
            let phoneNumber: String = phoneNumberTextField.textField.text,
            phoneNumber.count > 6
        else {
            return nil
        }
        
        guard
            let password: String = passwordTextField.textField.text,
            let confirmPassword: String = confirmPasswordTextField.textField.text,
            password.count > 5,
            password == confirmPassword
        else {
            return nil
        }
        
        var newUser: User = User()
        newUser.firstName = firstName
        newUser.lastName = lastName
        newUser.email = email
        newUser.phoneNumber = phoneNumber
        newUser.password = password
        return newUser
    }
    
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
    
    private(set) lazy var usernameTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Username"
        view.textField.delegate = self
        view.textField.tag = SubviewTags.username.rawValue
        view.textField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        return view
    }()
    
    private(set) lazy var firstNameTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "First name"
        view._roundCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.textField.delegate = self
        view.textField.tag = SubviewTags.firstName.rawValue
        view.textField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        return view
    }()
    
    private(set) lazy var lastNameTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Last name"
        view._roundCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.textField.delegate = self
        view.textField.tag = SubviewTags.lastName.rawValue
        view.textField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        return view
    }()
    
    private(set) lazy var emailTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Email address"
        view.textField.delegate = self
        view.textField.tag = SubviewTags.email.rawValue
        view.textField.keyboardType = .emailAddress
        view.textField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        return view
    }()
    
    private(set) lazy var phoneNumberTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Phone number"
        view.textField.delegate = self
        view.textField.tag = SubviewTags.phoneNumber.rawValue
        view.textField.keyboardType = .numberPad
        view.textField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        return view
    }()
    
    private(set) lazy var birthdateTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Birthdate"
        view.textField.delegate = self
        view.textField.tag = SubviewTags.birthDate.rawValue
        return view
    }()
    
    private(set) lazy var passwordTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Password"
        view.textField.isSecureTextEntry = true
        view._roundCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.textField.delegate = self
        view.textField.tag = SubviewTags.password.rawValue
        view._secureTextEntry = true
        view.textField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        return view
    }()
    
    private(set) lazy var confirmPasswordTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Confirm Password"
        view.textField.isSecureTextEntry = true
        view._roundCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.textField.delegate = self
        view.textField.tag = SubviewTags.confirmPassword.rawValue
        view._secureTextEntry = true
        view.textField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        return view
    }()
    
    private(set) lazy var receiveMessagesCheckboxView: CheckboxView = {
        let view = CheckboxView()
        view._text = """
        I don't want to receive marketing messages from Virtuoso. I can also opt out of receiving these at any time in my account settings or via the link in the message.
        """
        view.checkboxDelegate = self
        return view
    }()
    
    private(set) lazy var agreeAndContinueButton: Button = {
        let view = Button("Agree and continue", buttonType: .large)
        view.backgroundColor = ._secondary
        view.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Handlers
    @objc private func handleGoBack(sender: UIBarButtonItem) {
        signupDelegate?.signupViewController(self, goBack: sender)
    }
    
    @objc private func handleSignup(sender: UIButton) {
        guard let newUser: User = newUser else {
            state = .disabled
            return
        }
        signupDelegate?.signupViewController(self, agreeAndContinue: sender, newUser: newUser)
    }
    
    @objc private func handleTextFieldChange(sender: UITextField) {
        guard
            let _ = newUser,
            receiveMessagesCheckboxView._checked
        else {
            state = .disabled
            return
        }
        state = .enabled
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
        
        usernameTextField.textField.becomeFirstResponder()
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
        verticalStackView.addArrangedSubview(usernameTextField)
        verticalStackView.addArrangedSubview(EmptySpaceView(5))
        verticalStackView.addText("Username must be unique.", tag: SubviewTags.usernameLabel.rawValue)
        verticalStackView.addArrangedSubview(EmptySpaceView(20))
        verticalStackView.addArrangedSubview(firstNameTextField)
        verticalStackView.addArrangedSubview(lastNameTextField)
        verticalStackView.addArrangedSubview(EmptySpaceView(5))
        verticalStackView.addText("Make sure it matches the name on your government ID.")
        verticalStackView.addArrangedSubview(EmptySpaceView(20))
        verticalStackView.addArrangedSubview(birthdateTextField)
        verticalStackView.addArrangedSubview(EmptySpaceView(5))
        verticalStackView.addText("To sign up, you need to be at least 18. Your birthday won’t be shared with other people who use Airbnb.")
        verticalStackView.addArrangedSubview(EmptySpaceView(20))
        verticalStackView.addArrangedSubview(emailTextField)
        verticalStackView.addArrangedSubview(EmptySpaceView(5))
        verticalStackView.addText("We'll email you event confirmations and receipts.", tag: SubviewTags.emailLabel.rawValue)
        verticalStackView.addArrangedSubview(EmptySpaceView(20))
        verticalStackView.addArrangedSubview(phoneNumberTextField)
        verticalStackView.addArrangedSubview(EmptySpaceView(5))
        verticalStackView.addText("We'll send you text confirmations.")
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
}

// MARK: - UITextFieldDelegate

extension SignupViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let username: String = textField.text, username.count > 1, textField.tag == SubviewTags.username.rawValue {
            signupDelegate?.signupViewController(self, didEnterUsername: username)
        } else if let email: String = textField.text, email.count > 1, textField.tag == SubviewTags.email.rawValue {
            signupDelegate?.signupViewController(self, didEnterEmail: email)
        }
    }
}

// MARK: - CheckboxDelegate

extension SignupViewController: CheckboxDelegate {
    
    func checkboxView(_ view: CheckboxView, isChecked: Bool) {
        guard
            let _ = newUser,
            isChecked
        else {
            state = .disabled
            return
        }
        state = .enabled
    }
}
