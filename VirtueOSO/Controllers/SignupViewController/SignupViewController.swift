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
    
    enum Strings: String {
        case usernameLabel = "Username must be unique."
        case emailLabel = "We'll email you event confirmations and receipts."
        case passwordLabel = "Use 8-20 characters from at least 2 categories: letters, numbers, special characters."
        case unmatchingPasswordLabel = "Passwords do not match."
        case validPasswords = "Passwords are valid."
        case nameLabel = "Make sure it matches the name on your government ID."
        case birthDateLabel = "To sign up, you need to be at least 13. Your birthday won’t be shared with other people."
        case invalidBirthDateLabel = "You must be at least 13 years of age to sign up."
        case phoneLabel = "We'll send you text confirmations."
    }
    
    enum State {
        case enabled
        case disabled
        case usernameUnavailable(message: String)
        case usernameAvailable(message: String)
        case emailUnavailable(message: String)
        case emailAvailable(message: String)
        case validBirthdate(message: String)
        case invalidBirthdate(message: String)
        case validPasswords(message: String)
        case invalidPasswords(message: String)
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
        case birthDateLabel
        case password
        case confirmPassword
        case passwordsLabel
    }
    
    // MARK: - Private Properties
    
    private var age: Int {
        Date().years(from: birthdateTextField._date)
    }
    
    private var isOldEnough: Bool {
        return age >= 13
    }
    
    // MARK: - Public Properties
    
    var signupDelegate: SignupViewControllerDelegate?
    
    var newUser: User? {
        guard
            receiveMessagesCheckboxView._checked,
            usernameAvailable,
            emailAvailable
        else {
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
        
        // user must be minimum of 13 years old
        guard isOldEnough else {
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
            password.count > 7,
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
                usernameAvailable = false
                agreeAndContinueButton.isEnabled = false
                agreeAndContinueButton.backgroundColor = ._lightGray
                if let usernameTextView: UITextView = usernameTextView {
                    usernameTextView.text = message
                    usernameTextView.textColor = ._redError
                }
            case .usernameAvailable(let message):
                usernameAvailable = true
                if let usernameTextView: UITextView = usernameTextView {
                    usernameTextView.text = message
                    usernameTextView.textColor = .green
                }
                if let _ = newUser {
                    agreeAndContinueButton.isEnabled = true
                    agreeAndContinueButton.backgroundColor = ._secondary
                } else {
                    agreeAndContinueButton.isEnabled = false
                    agreeAndContinueButton.backgroundColor = ._lightGray
                }
            case .emailUnavailable(let message):
                emailAvailable = false
                agreeAndContinueButton.isEnabled = false
                agreeAndContinueButton.backgroundColor = ._lightGray
                if let emailTextView = emailTextView {
                    emailTextView.text = message
                    emailTextView.textColor = ._redError
                }
            case .emailAvailable(let message):
                emailAvailable = true
                if let emailTextView = emailTextView {
                    emailTextView.text = message
                    emailTextView.textColor = .green
                }
                if let _ = newUser {
                    agreeAndContinueButton.isEnabled = true
                    agreeAndContinueButton.backgroundColor = ._secondary
                } else {
                    agreeAndContinueButton.isEnabled = false
                    agreeAndContinueButton.backgroundColor = ._lightGray
                }
            case .invalidBirthdate(let message):
                agreeAndContinueButton.isEnabled = false
                agreeAndContinueButton.backgroundColor = ._lightGray
                birthdateTextField._state = .error
                if let birthDateTextView = birthDateTextView {
                    birthDateTextView.text = message
                    birthDateTextView.textColor = ._redError
                }
            case .validBirthdate(let message):
                birthdateTextField._state = .normal
                if let birthDateTextView = birthDateTextView {
                    birthDateTextView.text = message
                    birthDateTextView.textColor = .green
                }
                if let _ = newUser {
                    agreeAndContinueButton.isEnabled = true
                    agreeAndContinueButton.backgroundColor = ._secondary
                } else {
                    agreeAndContinueButton.isEnabled = false
                    agreeAndContinueButton.backgroundColor = ._lightGray
                }
            case .validPasswords(let message):
                passwordTextField._state = .normal
                confirmPasswordTextField._state = .normal
                if let passwordsTextView = passwordsTextView {
                    passwordsTextView.text = message
                    passwordsTextView.textColor = .green
                }
                if let _ = newUser {
                    agreeAndContinueButton.isEnabled = true
                    agreeAndContinueButton.backgroundColor = ._secondary
                } else {
                    agreeAndContinueButton.isEnabled = false
                    agreeAndContinueButton.backgroundColor = ._lightGray
                }
            case .invalidPasswords(let message):
                passwordTextField._state = .error
                confirmPasswordTextField._state = .error
                if let passwordsTextView = passwordsTextView {
                    passwordsTextView.text = message
                    passwordsTextView.textColor = ._redError
                }
            }
        }
    }
    
    public var usernameAvailable: Bool = false {
        didSet {
            usernameTextField._state = usernameAvailable ? .normal : .error
        }
    }
    
    public var emailAvailable: Bool = false {
        didSet {
            emailTextField._state = emailAvailable ? .normal : .error
        }
    }
    
    var usernameTextView: UITextView? {
        verticalStackView.arrangedSubviews.first(where: { $0.tag == SubviewTags.usernameLabel.rawValue }) as? UITextView
    }
    
    var emailTextView: UITextView? {
        verticalStackView.arrangedSubviews.first(where: { $0.tag == SubviewTags.emailLabel.rawValue }) as? UITextView
    }
    
    var birthDateTextView: UITextView? {
        verticalStackView.arrangedSubviews.first(where: { $0.tag == SubviewTags.birthDateLabel.rawValue }) as? UITextView
    }
    
    var passwordsTextView: UITextView? {
        verticalStackView.arrangedSubviews.first(where: { $0.tag == SubviewTags.passwordsLabel.rawValue }) as? UITextView
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
        view.textField.addTarget(self, action: #selector(handleVerificationRequired), for: .valueChanged)
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
        view.textField.addTarget(self, action: #selector(handleVerificationRequired), for: .valueChanged)
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
    
    private(set) lazy var birthdateTextField: BorderedDatePicker = {
        let view = BorderedDatePicker(title: "Birthdate")
        view.datePicker.datePickerMode = .date
        view.datePicker.tag = SubviewTags.birthDate.rawValue
        view.datePicker.addTarget(self, action: #selector(handleDatePickerValueChanged), for: .valueChanged)
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
        view.textField.delegate = self
        view.textField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        view.textField.addTarget(self, action: #selector(handleVerificationRequired), for: .valueChanged)
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
        view.textField.delegate = self
        view.textField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        view.textField.addTarget(self, action: #selector(handleVerificationRequired), for: .valueChanged)
        return view
    }()
    
    private(set) lazy var receiveMessagesCheckboxView: CheckboxView = {
        let view = CheckboxView()
        view.textView.attributedText =
            NSMutableAttributedString(attributedStrings: [
                NSAttributedString(string: "By checking this box, you agree to Kashmir's ", color: ._gray, fontType: .regular, fontSize: 14),
                NSAttributedString(string: "Terms of Use", color: .black, fontType: .medium, fontSize: 14),
                NSAttributedString(string: " and confirm that you have read Kashmir's ", color: ._gray, fontType: .regular, fontSize: 14),
                NSAttributedString(string: "Privacy Policy", color: .black, fontType: .medium, fontSize: 14),
                NSAttributedString(string: ".", color: ._gray, fontType: .regular, fontSize: 14),
            ])
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
    
    @objc private func handleVerificationRequired(textField: UITextField) {
        state = .disabled
        if let username: String = textField.text, username.count > 1, textField.tag == SubviewTags.username.rawValue {
            signupDelegate?.signupViewController(self, didEnterUsername: username)
        } else if let email: String = textField.text, email.count > 1, textField.tag == SubviewTags.email.rawValue {
            signupDelegate?.signupViewController(self, didEnterEmail: email)
        } else if textField.tag == SubviewTags.password.rawValue || textField.tag == SubviewTags.confirmPassword.rawValue,
                  let password: String = passwordTextField.textField.text, let confirmPassword: String = confirmPasswordTextField.textField.text,
                  password.count > 0 && confirmPassword.count > 0 {
            if password.count < 8 || confirmPassword.count < 8 {
                self.state = .invalidPasswords(message: Strings.passwordLabel.rawValue)
            } else if password != confirmPassword {
                self.state = .invalidPasswords(message: Strings.unmatchingPasswordLabel.rawValue)
            } else {
                self.state = .validPasswords(message: Strings.validPasswords.rawValue)
            }
            
        }
    }
    
    @objc private func handleDatePickerValueChanged(sender: UIDatePicker) {
        if sender.tag == SubviewTags.birthDate.rawValue {
            if isOldEnough {
                state = .validBirthdate(message: Strings.birthDateLabel.rawValue)
            } else {
                state = .invalidBirthdate(message: Strings.invalidBirthDateLabel.rawValue)
            }
        }
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
        verticalStackView.addText(Strings.usernameLabel.rawValue, tag: SubviewTags.usernameLabel.rawValue)
        verticalStackView.addArrangedSubview(EmptySpaceView(20))
        verticalStackView.addArrangedSubview(emailTextField)
        verticalStackView.addArrangedSubview(EmptySpaceView(5))
        verticalStackView.addText(Strings.emailLabel.rawValue, tag: SubviewTags.emailLabel.rawValue)
        verticalStackView.addArrangedSubview(EmptySpaceView(20))
        verticalStackView.addArrangedSubview(passwordTextField)
        verticalStackView.addArrangedSubview(confirmPasswordTextField)
        verticalStackView.addArrangedSubview(EmptySpaceView(10))
        verticalStackView.addText(Strings.passwordLabel.rawValue, tag: SubviewTags.passwordsLabel.rawValue)
        verticalStackView.addArrangedSubview(EmptySpaceView(20))
        verticalStackView.addArrangedSubview(firstNameTextField)
        verticalStackView.addArrangedSubview(lastNameTextField)
        verticalStackView.addArrangedSubview(EmptySpaceView(5))
        verticalStackView.addText(Strings.nameLabel.rawValue)
        verticalStackView.addArrangedSubview(EmptySpaceView(20))
        verticalStackView.addArrangedSubview(birthdateTextField)
        verticalStackView.addArrangedSubview(EmptySpaceView(5))
        verticalStackView.addText(Strings.birthDateLabel.rawValue, tag: SubviewTags.birthDateLabel.rawValue)
        verticalStackView.addArrangedSubview(EmptySpaceView(20))
        verticalStackView.addArrangedSubview(phoneNumberTextField)
        verticalStackView.addArrangedSubview(EmptySpaceView(5))
        verticalStackView.addText(Strings.phoneLabel.rawValue)
        verticalStackView.addVerticalEmptySpace(10)
        verticalStackView.addArrangedSubview(receiveMessagesCheckboxView)
        verticalStackView.addVerticalEmptySpace(15)
        verticalStackView.addArrangedSubview(agreeAndContinueButton)
        verticalStackView.addVerticalEmptySpace(view.frame.height / 2)
    }
}

// MARK: - UITextFieldDelegate

extension SignupViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        NSObject.cancelPreviousPerformRequests(
                withTarget: self,
                selector: #selector(handleVerificationRequired),
                object: textField)
        self.perform(
                #selector(handleVerificationRequired),
                with: textField,
                afterDelay: 0.5)
        return true
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
