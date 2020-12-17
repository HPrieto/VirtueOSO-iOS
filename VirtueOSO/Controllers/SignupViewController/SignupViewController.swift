//
//  SignupViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/12/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: - SignupModel

struct SignupModel {
    public var firstname: String?
    public var lastname: String?
    public var birthDate: Date?
    public var email: String?
    public var password: String?
    public var confirmPassword: String?
    public var agreedToTerms: Bool
}

// MARK: - SignupViewControllerDelegate

protocol SignupViewControllerDelegate {
    func signupViewController(_ controller: SignupViewController, didEnter model: SignupModel)
    func signupViewController(_ controller: SignupViewController, agreeAndContinue button: UIButton, model: SignupModel)
    func signupViewController(_ controller: SignupViewController, goBack buttonItem: UIBarButtonItem)
}

// MARK: - SignupViewController

class SignupViewController: UIViewController {
    
    enum State {
        case enabled
        case disabled
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
            }
        }
    }
    
    // MARK: - Public Properties
    
    var signupDelegate: SignupViewControllerDelegate?
    
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
        view.inputTextView.delegate = self
        return view
    }()
    
    private(set) lazy var lastNameTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Last name"
        view._roundCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.inputTextView.delegate = self
        return view
    }()
    
    private(set) lazy var birthdateTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Birthdate"
        view.inputTextView.delegate = self
        return view
    }()
    
    private(set) lazy var emailTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Email address"
        view.inputTextView.delegate = self
        return view
    }()
    
    private(set) lazy var passwordTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Password"
        view.inputTextView.isSecureTextEntry = true
        view._roundCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.inputTextView.delegate = self
        return view
    }()
    
    private(set) lazy var confirmPasswordTextField: BorderedTextField = {
        let view = BorderedTextField()
        view._title = "Confirm Password"
        view.inputTextView.isSecureTextEntry = true
        view._roundCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.inputTextView.delegate = self
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
    @objc private func handleGoBack(sender: UIBarButtonItem) {
        signupDelegate?.signupViewController(self, goBack: sender)
    }
    
    @objc private func handleSignup(sender: UIButton) {
        signupDelegate?.signupViewController(self, agreeAndContinue: sender, model: buildSignupModel())
    }
    
    // MARK: - Utils
    
    private func buildSignupModel() -> SignupModel {
        SignupModel(
            firstname: firstNameTextField.inputTextView.text,
            lastname: lastNameTextField.inputTextView.text,
            birthDate: birthdateTextField.inputTextView.text.toJsonDate(),
            email: emailTextField.inputTextView.text,
            password: passwordTextField.inputTextView.text,
            confirmPassword: confirmPasswordTextField.inputTextView.text,
            agreedToTerms: receiveMessagesCheckboxView._checked
        )
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
}

// MARK: - UITextViewDelegate

extension SignupViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        signupDelegate?.signupViewController(
            self,
            didEnter: buildSignupModel()
        )
    }
}

// MARK: - CheckboxDelegate

extension SignupViewController: CheckboxDelegate {
    
    func checkboxView(_ view: CheckboxView, isChecked: Bool) {
        signupDelegate?.signupViewController(self, didEnter: buildSignupModel())
    }
}
